#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$REPO_ROOT/exports/DRW-001-A-Assembly/sheet5_parts_pass"
FRAMES=48
IMGSIZE="1600,1200"
QUALITY="preview"

OPENSCAD_BIN="${OPENSCAD:-}"
if [[ -z "$OPENSCAD_BIN" ]]; then
    if command -v openscad >/dev/null 2>&1; then
        OPENSCAD_BIN="openscad"
    elif [[ -x /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD ]]; then
        OPENSCAD_BIN="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
    else
        echo "OpenSCAD not found in PATH or standard macOS app location." >&2
        exit 1
    fi
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        --frames)
            FRAMES="$2"
            shift 2
            ;;
        --imgsize)
            IMGSIZE="$2"
            shift 2
            ;;
        --quality)
            QUALITY="$2"
            shift 2
            ;;
        --out-dir)
            OUT_DIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

mkdir -p "$OUT_DIR"

echo "Rendering DRW-001 Sheet 5 parts pass to ${OUT_DIR#$REPO_ROOT/}"
"$OPENSCAD_BIN" \
    --animate "$FRAMES" \
    --imgsize="$IMGSIZE" \
    --viewall \
    --autocenter \
    -D '__LIB_MODE__=1' \
    -D 'mode="drw001_sheet5_parts_animate"' \
    -D "quality=\"$QUALITY\"" \
    -o "$OUT_DIR/frame.png" \
    "$REPO_ROOT/scad/main.scad"
