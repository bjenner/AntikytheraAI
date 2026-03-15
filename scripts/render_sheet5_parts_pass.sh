#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$REPO_ROOT/config/sheet5_overlay.env"

OUT_DIR="$REPO_ROOT/$PARTS_PASS_DIR"
FRAMES="${FRAMES:-96}"
IMGSIZE="${IMGSIZE:-2340,1364}"
QUALITY="${QUALITY:-preview}"
MODE="${MODE:-drw001_sheet5_parts_animate}"
PROJECTION="${PROJECTION:-o}"
CAMERA="${CAMERA:-}"
VIEW_OPTIONS="${VIEW_OPTIONS:-}"

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

OPENSCAD_ARGS=(
    --animate "$FRAMES"
    --imgsize="$IMGSIZE"
    --projection="$PROJECTION"
    -D '__LIB_MODE__=1'
    -D "mode=\"$MODE\""
    -D "quality=\"$QUALITY\""
)

if [[ -n "$CAMERA" ]]; then
    OPENSCAD_ARGS+=(--camera "$CAMERA")
else
    OPENSCAD_ARGS+=(--viewall --autocenter)
fi

if [[ -n "$VIEW_OPTIONS" ]]; then
    OPENSCAD_ARGS+=(--view "$VIEW_OPTIONS")
fi

"$OPENSCAD_BIN" \
    "${OPENSCAD_ARGS[@]}" \
    -o "$OUT_DIR/frame.png" \
    "$REPO_ROOT/scad/main.scad"
