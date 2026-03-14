#!/usr/bin/env python3
"""Composite DRW-001 Sheet 5 parts-pass frames over the source drawing page.

This script is dependency-free on purpose. It uses only the Python standard
library so it can run in the current repo environment without Pillow or ffmpeg.
It supports 8-bit non-interlaced RGB/RGBA PNG files.
"""

from __future__ import annotations

import argparse
import glob
import math
import os
import struct
import sys
import zlib
from pathlib import Path


PNG_SIG = b"\x89PNG\r\n\x1a\n"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Composite a rendered Sheet 5 parts pass over the Sheet 5 source drawing."
    )
    parser.add_argument(
        "--background",
        default="ref/drawings/DRW-001-A-Assembly/a_page05.png",
        help="Background PNG path. Defaults to DRW-001 Sheet 5 source page.",
    )
    parser.add_argument(
        "--frames-dir",
        default="exports/DRW-001-A-Assembly/sheet5_parts_pass",
        help="Directory containing rendered parts-pass PNG frames.",
    )
    parser.add_argument(
        "--glob",
        default="*.png",
        dest="glob_pattern",
        help="Glob used to select frame files within --frames-dir.",
    )
    parser.add_argument(
        "--output-dir",
        default="exports/DRW-001-A-Assembly/sheet5_composite",
        help="Directory to write composite PNG frames.",
    )
    parser.add_argument(
        "--scale",
        type=float,
        default=1.0,
        help="Uniform scale applied to the parts-pass image before compositing.",
    )
    parser.add_argument(
        "--offset-x",
        type=int,
        default=0,
        help="Horizontal offset of the parts pass on the background canvas in pixels.",
    )
    parser.add_argument(
        "--offset-y",
        type=int,
        default=0,
        help="Vertical offset of the parts pass on the background canvas in pixels.",
    )
    parser.add_argument(
        "--white-threshold",
        type=int,
        default=245,
        help="Pixels at or above this RGB value are treated as transparent background.",
    )
    parser.add_argument(
        "--opacity",
        type=float,
        default=1.0,
        help="Global opacity multiplier for the parts pass (0..1).",
    )
    return parser.parse_args()


def paeth_predictor(a: int, b: int, c: int) -> int:
    p = a + b - c
    pa = abs(p - a)
    pb = abs(p - b)
    pc = abs(p - c)
    if pa <= pb and pa <= pc:
        return a
    if pb <= pc:
        return b
    return c


def read_chunk(handle) -> tuple[bytes, bytes]:
    length_raw = handle.read(4)
    if not length_raw:
        return b"", b""
    if len(length_raw) != 4:
        raise ValueError("Truncated PNG chunk length.")
    length = struct.unpack(">I", length_raw)[0]
    chunk_type = handle.read(4)
    chunk_data = handle.read(length)
    crc = handle.read(4)
    if len(chunk_type) != 4 or len(chunk_data) != length or len(crc) != 4:
        raise ValueError("Truncated PNG chunk payload.")
    return chunk_type, chunk_data


def unfilter_scanlines(raw: bytes, width: int, height: int, bpp: int, stride: int) -> bytes:
    out = bytearray(height * stride)
    pos = 0
    for row in range(height):
        filter_type = raw[pos]
        pos += 1
        row_start = row * stride
        row_bytes = raw[pos: pos + stride]
        pos += stride
        prev_start = (row - 1) * stride

        for i in range(stride):
            left = out[row_start + i - bpp] if i >= bpp else 0
            up = out[prev_start + i] if row > 0 else 0
            up_left = out[prev_start + i - bpp] if row > 0 and i >= bpp else 0
            value = row_bytes[i]

            if filter_type == 0:
                recon = value
            elif filter_type == 1:
                recon = (value + left) & 0xFF
            elif filter_type == 2:
                recon = (value + up) & 0xFF
            elif filter_type == 3:
                recon = (value + ((left + up) // 2)) & 0xFF
            elif filter_type == 4:
                recon = (value + paeth_predictor(left, up, up_left)) & 0xFF
            else:
                raise ValueError(f"Unsupported PNG filter type: {filter_type}")

            out[row_start + i] = recon

    return bytes(out)


def read_png(path: Path) -> tuple[int, int, bytearray]:
    with path.open("rb") as handle:
        if handle.read(len(PNG_SIG)) != PNG_SIG:
            raise ValueError(f"{path} is not a PNG file.")

        width = height = None
        bit_depth = color_type = interlace = None
        idat_parts: list[bytes] = []

        while True:
            chunk_type, chunk_data = read_chunk(handle)
            if not chunk_type:
                break
            if chunk_type == b"IHDR":
                width, height, bit_depth, color_type, compression, filter_method, interlace = struct.unpack(
                    ">IIBBBBB", chunk_data
                )
                if compression != 0 or filter_method != 0 or interlace != 0:
                    raise ValueError("Only standard non-interlaced PNGs are supported.")
                if bit_depth != 8:
                    raise ValueError("Only 8-bit PNGs are supported.")
                if color_type not in (2, 6):
                    raise ValueError("Only RGB/RGBA PNGs are supported.")
            elif chunk_type == b"IDAT":
                idat_parts.append(chunk_data)
            elif chunk_type == b"IEND":
                break

        if width is None or height is None:
            raise ValueError("PNG missing IHDR.")

        bpp = 3 if color_type == 2 else 4
        stride = width * bpp
        raw = zlib.decompress(b"".join(idat_parts))
        decoded = unfilter_scanlines(raw, width, height, bpp, stride)

        rgba = bytearray(width * height * 4)
        if color_type == 2:
            for i in range(width * height):
                src = i * 3
                dst = i * 4
                rgba[dst:dst + 3] = decoded[src:src + 3]
                rgba[dst + 3] = 255
        else:
            rgba[:] = decoded

        return width, height, rgba


def chunk(chunk_type: bytes, payload: bytes) -> bytes:
    crc = zlib.crc32(chunk_type)
    crc = zlib.crc32(payload, crc) & 0xFFFFFFFF
    return struct.pack(">I", len(payload)) + chunk_type + payload + struct.pack(">I", crc)


def write_png(path: Path, width: int, height: int, rgba: bytearray) -> None:
    stride = width * 4
    raw = bytearray()
    for row in range(height):
        raw.append(0)
        start = row * stride
        raw.extend(rgba[start:start + stride])

    ihdr = struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0)
    idat = zlib.compress(bytes(raw), level=9)
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("wb") as handle:
        handle.write(PNG_SIG)
        handle.write(chunk(b"IHDR", ihdr))
        handle.write(chunk(b"IDAT", idat))
        handle.write(chunk(b"IEND", b""))


def sample_bilinear(rgba: bytearray, width: int, height: int, x: float, y: float) -> tuple[int, int, int, int]:
    x = min(max(x, 0.0), width - 1.0)
    y = min(max(y, 0.0), height - 1.0)
    x0 = int(math.floor(x))
    y0 = int(math.floor(y))
    x1 = min(x0 + 1, width - 1)
    y1 = min(y0 + 1, height - 1)
    tx = x - x0
    ty = y - y0

    def px(ix: int, iy: int) -> tuple[int, int, int, int]:
        idx = (iy * width + ix) * 4
        return tuple(rgba[idx + c] for c in range(4))

    c00 = px(x0, y0)
    c10 = px(x1, y0)
    c01 = px(x0, y1)
    c11 = px(x1, y1)

    out = []
    for i in range(4):
        top = c00[i] * (1 - tx) + c10[i] * tx
        bottom = c01[i] * (1 - tx) + c11[i] * tx
        value = top * (1 - ty) + bottom * ty
        out.append(int(round(value)))
    return tuple(out)


def composite(
    bg_w: int,
    bg_h: int,
    bg_rgba: bytearray,
    fg_w: int,
    fg_h: int,
    fg_rgba: bytearray,
    scale: float,
    offset_x: int,
    offset_y: int,
    white_threshold: int,
    opacity: float,
) -> bytearray:
    out = bytearray(bg_rgba)
    scaled_w = max(1, int(round(fg_w * scale)))
    scaled_h = max(1, int(round(fg_h * scale)))

    for y in range(scaled_h):
        dst_y = y + offset_y
        if dst_y < 0 or dst_y >= bg_h:
            continue
        src_y = y / scale
        for x in range(scaled_w):
            dst_x = x + offset_x
            if dst_x < 0 or dst_x >= bg_w:
                continue
            src_x = x / scale
            r, g, b, a = sample_bilinear(fg_rgba, fg_w, fg_h, src_x, src_y)

            if r >= white_threshold and g >= white_threshold and b >= white_threshold:
                continue

            alpha = (a / 255.0) * opacity
            if alpha <= 0:
                continue

            idx = (dst_y * bg_w + dst_x) * 4
            br, bg, bb, ba = out[idx], out[idx + 1], out[idx + 2], out[idx + 3]
            inv = 1.0 - alpha

            out[idx] = int(round(r * alpha + br * inv))
            out[idx + 1] = int(round(g * alpha + bg * inv))
            out[idx + 2] = int(round(b * alpha + bb * inv))
            out[idx + 3] = int(round(255 * (alpha + (ba / 255.0) * inv)))

    return out


def main() -> int:
    args = parse_args()
    repo_root = Path(__file__).resolve().parent.parent
    background_path = (repo_root / args.background).resolve()
    frames_dir = (repo_root / args.frames_dir).resolve()
    output_dir = (repo_root / args.output_dir).resolve()

    frame_paths = sorted(Path(p) for p in glob.glob(str(frames_dir / args.glob_pattern)))
    if not frame_paths:
        print(f"No frames found in {frames_dir} matching {args.glob_pattern}", file=sys.stderr)
        return 1

    bg_w, bg_h, bg_rgba = read_png(background_path)

    for i, frame_path in enumerate(frame_paths):
        fg_w, fg_h, fg_rgba = read_png(frame_path)
        composed = composite(
            bg_w,
            bg_h,
            bg_rgba,
            fg_w,
            fg_h,
            fg_rgba,
            scale=args.scale,
            offset_x=args.offset_x,
            offset_y=args.offset_y,
            white_threshold=args.white_threshold,
            opacity=args.opacity,
        )
        out_name = frame_path.name
        out_path = output_dir / out_name
        write_png(out_path, bg_w, bg_h, composed)
        try:
            shown_path = out_path.relative_to(repo_root)
        except ValueError:
            shown_path = out_path
        print(f"[{i + 1}/{len(frame_paths)}] {shown_path}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
