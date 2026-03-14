#!/usr/bin/env python3
"""Open source and recreated drawing or part previews side by side for QA."""

from __future__ import annotations

import argparse
import csv
import re
import subprocess
import sys
import time
from pathlib import Path


RE_DRAWING = re.compile(r"^drw(\d{3})_sheet(\d+)$", re.IGNORECASE)
RE_PART_MODE = re.compile(r"^part_([a-z0-9]+)$", re.IGNORECASE)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Open a source drawing/part image and recreated preview side by side in Preview."
    )
    parser.add_argument(
        "target",
        help="Target like drw001_sheet2, DRW-001, b0_gear, b0, or part_b0",
    )
    parser.add_argument(
        "sheet",
        nargs="?",
        type=int,
        help="Sheet number when target is a drawing id like DRW-001; omit to cycle all sheets",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print resolved source/rendered paths without opening Preview",
    )
    parser.add_argument(
        "--refresh",
        action="store_true",
        help="Force re-render of part previews before opening them",
    )
    return parser.parse_args()


def repo_root() -> Path:
    return Path(__file__).resolve().parent.parent


def ref_root(root: Path) -> Path:
    return root / "ref"


def openscad_binary() -> str:
    candidates = [
        "openscad",
        "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD",
        "/Applications/OpenSCAD-2021.01.app/Contents/MacOS/OpenSCAD",
    ]
    for candidate in candidates:
        try:
            result = subprocess.run(
                [candidate, "--version"],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                check=True,
            )
            if result.returncode == 0:
                return candidate
        except (FileNotFoundError, subprocess.CalledProcessError):
            continue
    raise SystemExit("OpenSCAD not found in PATH or standard macOS app locations.")


def normalize_target(target: str, sheet: int | None) -> tuple[str, int | None, str | None]:
    match = RE_DRAWING.match(target)
    if match:
        drawing_num, sheet_num = match.groups()
        return f"DRW-{drawing_num}", int(sheet_num), f"drw{drawing_num}_sheet{sheet_num}"

    normalized = target.upper().replace("_", "-")
    if not normalized.startswith("DRW-"):
        raise SystemExit(
            "Target must look like drw001_sheet2 or DRW-001 [sheet]."
        )
    drawing_num = normalized.split("-", 1)[1]
    if sheet is None:
        return normalized, None, None
    return normalized, sheet, f"drw{drawing_num}_sheet{sheet}"


def resolve_part_file(root: Path, target: str) -> Path:
    parts_dir = root / "scad" / "parts"
    raw = target.strip()
    direct = Path(raw)
    if direct.is_absolute() and direct.exists():
        return direct

    if (root / raw).exists():
        return root / raw

    stem = Path(raw).stem.lower()
    match = RE_PART_MODE.match(stem)
    if match:
        part_id = match.group(1)
        candidates = sorted(parts_dir.rglob(f"{part_id}_*.scad"))
        if candidates:
            return candidates[0]

    direct_matches = sorted(parts_dir.rglob(f"{stem}.scad"))
    if direct_matches:
        return direct_matches[0]

    candidates = sorted(parts_dir.rglob(f"{stem}_*.scad"))
    if candidates:
        return candidates[0]

    raise SystemExit(f"Could not resolve a part file for target: {target}")


def load_drawing_index(csv_path: Path) -> dict[str, dict[str, str]]:
    with csv_path.open(newline="", encoding="utf-8") as handle:
        rows = csv.DictReader(handle)
        return {row["drawing_id"]: row for row in rows}


def find_rendered_preview(root: Path, rendered_name: str, preferred_group: str | None = None) -> Path:
    candidates = []
    if preferred_group:
        candidates.append(root / "exports" / preferred_group / f"{rendered_name}.png")
    nested_matches = sorted((root / "exports").rglob(f"{rendered_name}.png"))
    candidates.extend(nested_matches)
    candidates.append(root / "exports" / f"{rendered_name}.png")
    for candidate in candidates:
        if candidate.exists():
            return candidate

    raise SystemExit(
        f"Rendered preview not found for {rendered_name}. Run `bash scripts/export.sh --file scad/assemblies/{rendered_name}.scad` first."
    )


def find_part_source_image(root: Path, stem: str) -> Path:
    ref_dir = ref_root(root)
    candidates = [
        ref_dir / "parts" / "images" / f"{stem}.png",
    ]
    for candidate in candidates:
        if candidate.exists():
            return candidate

    matches = sorted(ref_dir.rglob(f"{stem}.png"))
    if matches:
        return matches[0]
    raise SystemExit(f"Could not find a source part image for {stem}.")


def render_part_preview(root: Path, part_file: Path, out_path: Path) -> None:
    out_path.parent.mkdir(parents=True, exist_ok=True)
    openscad = openscad_binary()
    subprocess.run(
        [
            openscad,
            "--imgsize=1200,1200",
            "--projection=o",
            "--viewall",
            "--autocenter",
            "-D",
            'quality="preview"',
            "-o",
            str(out_path),
            str(part_file),
        ],
        cwd=root,
        check=True,
    )


def prepare_part_preview(root: Path, part_file: Path, refresh: bool) -> Path:
    group = part_file.parent.name if part_file.parent != root / "scad" / "parts" else "_general"
    out_path = root / "exports" / group / f"{part_file.stem}.png"
    if refresh or not out_path.exists():
        print(f"render:   {part_file.relative_to(root)} -> {out_path.relative_to(root)}")
        render_part_preview(root, part_file, out_path)
    return out_path


def parse_sheet_list(row: dict[str, str]) -> list[int]:
    sheets_done = (row.get("scad_sheets_done") or "").strip()
    png_pages = (row.get("png_pages") or "").strip()

    if sheets_done.lower() == "all":
        if png_pages.isdigit():
            return list(range(1, int(png_pages) + 1))
        raise SystemExit("drawing_index.csv has scad_sheets_done=all but png_pages is not numeric.")

    if sheets_done and sheets_done != "-":
        return [int(part.strip()) for part in sheets_done.split(",") if part.strip()]

    if png_pages.isdigit():
        return list(range(1, int(png_pages) + 1))

    raise SystemExit("Could not determine sheet list from drawing_index.csv.")


def source_png_candidates(prefix: str, sheet: int) -> list[str]:
    return [
        f"{prefix}_page{sheet}.png",
        f"{prefix}_page{sheet:02d}.png",
        f"{prefix}_page_{sheet}.png",
        f"{prefix}_page_{sheet:02d}.png",
    ]


def find_source_page(root: Path, row: dict[str, str], sheet: int) -> tuple[str, Path, int | None]:
    ref_dir = ref_root(root)
    prefix = (row.get("png_prefix") or "").strip()
    source_path = (row.get("file_path_or_url") or "").strip()
    drawing_dir = None
    if source_path and not source_path.startswith(("http://", "https://")):
        drawing_dir = (root / source_path).parent

    if prefix:
        candidates = {name.lower() for name in source_png_candidates(prefix, sheet)}
        search_roots = []
        if drawing_dir is not None and drawing_dir.exists():
            search_roots.append(drawing_dir)
        search_roots.append(ref_dir / "drawings")

        for search_root in search_roots:
            if not search_root.exists():
                continue
            for candidate in sorted(search_root.rglob("*.png")):
                if candidate.name.lower() in candidates:
                    return "png", candidate, None

    if source_path and not source_path.startswith(("http://", "https://")):
        pdf_path = root / source_path
        if pdf_path.exists():
            return "pdf", pdf_path, sheet

    raise SystemExit(
        f"Could not resolve a source page for {row['drawing_id']} sheet {sheet}."
    )


def run_applescript(script: str, *args: str) -> None:
    command = ["osascript", "-"]
    command.extend(args)
    subprocess.run(command, input=script, text=True, check=True)


def open_in_preview(path: Path) -> None:
    subprocess.run(["open", "-a", "Preview", str(path)], check=True)


def close_preview_documents(*paths: Path) -> None:
    script = r'''
on run argv
    tell application "Preview"
        repeat with targetPath in argv
            repeat with d in documents
                try
                    if (path of d) is targetPath then
                        close d saving no
                    end if
                end try
            end repeat
        end repeat
    end tell
end run
'''
    run_applescript(script, *[str(path) for path in paths])


def arrange_preview_windows(source_path: Path, rendered_path: Path) -> None:
    script = r'''
on run argv
    set sourcePath to item 1 of argv
    set renderedPath to item 2 of argv

    tell application "Finder"
        set screenBounds to bounds of window of desktop
    end tell

    set leftEdge to item 1 of screenBounds
    set topEdge to item 2 of screenBounds
    set rightEdge to item 3 of screenBounds
    set bottomEdge to item 4 of screenBounds
    set widthTotal to rightEdge - leftEdge
    set midX to leftEdge + (widthTotal div 2)

    tell application "Preview"
        activate
        repeat with w in windows
            try
                set docPath to path of document of w
                if docPath is sourcePath then
                    set bounds of w to {leftEdge, topEdge, midX, bottomEdge}
                else if docPath is renderedPath then
                    set bounds of w to {midX, topEdge, rightEdge, bottomEdge}
                end if
            end try
        end repeat
    end tell
end run
'''
    run_applescript(script, str(source_path), str(rendered_path))


def goto_preview_pdf_page(page: int) -> None:
    script = f'''
tell application "Preview"
    activate
end tell

tell application "System Events"
    tell process "Preview"
        keystroke "g" using {{command down, option down}}
        delay 0.3
        keystroke "{page}"
        key code 36
    end tell
end tell
'''
    run_applescript(script)


def show_pair(
    root: Path,
    drawing_id: str,
    sheet: int,
    rendered_path: Path,
    source_kind: str,
    source_path: Path,
    pdf_page: int | None,
    dry_run: bool,
) -> None:
    print(f"drawing:  {drawing_id} sheet {sheet}")
    print(f"source:   {source_path.relative_to(root)}")
    if pdf_page is not None:
        print(f"page:     {pdf_page}")
    print(f"rendered: {rendered_path.relative_to(root)}")

    if dry_run:
        print("")
        return

    open_in_preview(source_path)
    time.sleep(1.0)
    if source_kind == "pdf" and pdf_page is not None:
        goto_preview_pdf_page(pdf_page)
        time.sleep(0.6)

    open_in_preview(rendered_path)
    time.sleep(1.0)
    arrange_preview_windows(source_path, rendered_path)


def show_part_pair(root: Path, part_file: Path, source_path: Path, rendered_path: Path, dry_run: bool) -> int:
    print(f"part:     {part_file.stem}")
    print(f"source:   {source_path.relative_to(root)}")
    print(f"rendered: {rendered_path.relative_to(root)}")

    if dry_run:
        return 0

    open_in_preview(source_path)
    time.sleep(1.0)
    open_in_preview(rendered_path)
    time.sleep(1.0)
    arrange_preview_windows(source_path, rendered_path)
    return 0


def cycle_sheets(root: Path, drawing_id: str, row: dict[str, str], dry_run: bool) -> int:
    sheets = parse_sheet_list(row)
    shown = 0
    previous_source_path: Path | None = None
    previous_rendered_path: Path | None = None
    preferred_group = Path(row["file_path_or_url"]).parent.name if row.get("file_path_or_url") else None

    for index, sheet in enumerate(sheets, start=1):
        rendered_name = f"drw{drawing_id.split('-', 1)[1]}_sheet{sheet}"
        try:
            rendered_path = find_rendered_preview(root, rendered_name, preferred_group)
            source_kind, source_path, pdf_page = find_source_page(root, row, sheet)
        except SystemExit as exc:
            print(f"skip:     {exc}", file=sys.stderr)
            continue

        if previous_source_path is not None and previous_rendered_path is not None and not dry_run:
            close_preview_documents(previous_source_path, previous_rendered_path)
            time.sleep(0.5)

        print(f"[{index}/{len(sheets)}]")
        show_pair(
            root,
            drawing_id,
            sheet,
            rendered_path,
            source_kind,
            source_path,
            pdf_page,
            dry_run,
        )
        shown += 1
        previous_source_path = source_path
        previous_rendered_path = rendered_path

        if dry_run:
            continue

        if index < len(sheets):
            response = input("Press Enter for next sheet, or type q to stop: ").strip().lower()
            if response in {"q", "quit", "exit"}:
                break

    return 0 if shown > 0 else 1


def main() -> int:
    args = parse_args()
    root = repo_root()

    if not args.target.lower().startswith("drw"):
        part_file = resolve_part_file(root, args.target)
        source_path = find_part_source_image(root, part_file.stem)
        group = part_file.parent.name if part_file.parent != root / "scad" / "parts" else "_general"
        rendered_path = root / "exports" / group / f"{part_file.stem}.png"
        if not args.dry_run:
            rendered_path = prepare_part_preview(root, part_file, args.refresh)
        return show_part_pair(root, part_file, source_path, rendered_path, args.dry_run)

    drawing_id, sheet, rendered_name = normalize_target(args.target, args.sheet)
    index = load_drawing_index(root / "ref" / "meta" / "drawing_index.csv")

    if drawing_id not in index:
        raise SystemExit(f"Drawing id not found in drawing_index.csv: {drawing_id}")

    row = index[drawing_id]
    if sheet is None or rendered_name is None:
        return cycle_sheets(root, drawing_id, row, args.dry_run)

    preferred_group = Path(row["file_path_or_url"]).parent.name if row.get("file_path_or_url") else None
    rendered_path = find_rendered_preview(root, rendered_name, preferred_group)
    source_kind, source_path, pdf_page = find_source_page(root, row, sheet)

    show_pair(
        root,
        drawing_id,
        sheet,
        rendered_path,
        source_kind,
        source_path,
        pdf_page,
        args.dry_run,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
