#!/usr/bin/env python3
"""Open source and recreated drawing previews side by side for QA."""

from __future__ import annotations

import argparse
import csv
import re
import subprocess
import sys
import time
from pathlib import Path


RE_DRAWING = re.compile(r"^drw(\d{3})_sheet(\d+)$", re.IGNORECASE)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Open a source drawing page and recreated preview side by side in Preview."
    )
    parser.add_argument(
        "target",
        help="Drawing target like drw001_sheet2 or DRW-001",
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
    return parser.parse_args()


def repo_root() -> Path:
    return Path(__file__).resolve().parent.parent


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


def load_drawing_index(csv_path: Path) -> dict[str, dict[str, str]]:
    with csv_path.open(newline="", encoding="utf-8") as handle:
        rows = csv.DictReader(handle)
        return {row["drawing_id"]: row for row in rows}


def find_rendered_preview(root: Path, rendered_name: str) -> Path:
    candidates = [
        root / "exports" / "png" / f"{rendered_name}.png",
        root / "exports" / "previews" / f"{rendered_name}.png",
    ]
    for candidate in candidates:
        if candidate.exists():
            return candidate
    raise SystemExit(
        f"Rendered preview not found for {rendered_name}. Run `bash scripts/export.sh --file scad/assemblies/{rendered_name}.scad` first."
    )


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
    prefix = (row.get("png_prefix") or "").strip()
    if prefix:
        candidates = {name.lower() for name in source_png_candidates(prefix, sheet)}
        for candidate in sorted((root / "docs" / "sources").rglob("*.png")):
            if candidate.name.lower() in candidates:
                return "png", candidate, None

    source_path = (row.get("file_path_or_url") or "").strip()
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


def cycle_sheets(root: Path, drawing_id: str, row: dict[str, str], dry_run: bool) -> int:
    sheets = parse_sheet_list(row)
    shown = 0
    previous_source_path: Path | None = None
    previous_rendered_path: Path | None = None

    for index, sheet in enumerate(sheets, start=1):
        rendered_name = f"drw{drawing_id.split('-', 1)[1]}_sheet{sheet}"
        try:
            rendered_path = find_rendered_preview(root, rendered_name)
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
    drawing_id, sheet, rendered_name = normalize_target(args.target, args.sheet)
    index = load_drawing_index(root / "docs" / "sources" / "drawing_index.csv")

    if drawing_id not in index:
        raise SystemExit(f"Drawing id not found in drawing_index.csv: {drawing_id}")

    row = index[drawing_id]
    if sheet is None or rendered_name is None:
        return cycle_sheets(root, drawing_id, row, args.dry_run)

    rendered_path = find_rendered_preview(root, rendered_name)
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
