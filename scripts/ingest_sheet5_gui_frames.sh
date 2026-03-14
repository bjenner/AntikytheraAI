#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/scad"
DEST_DIR="$REPO_ROOT/exports/DRW-001-A-Assembly/sheet5_parts_pass"
MOVE_FILES=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --source-dir)
            SOURCE_DIR="$2"
            shift 2
            ;;
        --dest-dir)
            DEST_DIR="$2"
            shift 2
            ;;
        --move)
            MOVE_FILES=1
            shift
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

shopt -s nullglob
frames=("$SOURCE_DIR"/frame*.png)
if [[ ${#frames[@]} -eq 0 ]]; then
    echo "No GUI-dumped frame PNGs found in $SOURCE_DIR" >&2
    exit 1
fi

python3 - "$SOURCE_DIR" <<'PY'
from pathlib import Path
import sys

source = Path(sys.argv[1])
frames = sorted(source.glob("frame*.png"))
nums = [int(f.stem.replace("frame", "")) for f in frames]
if nums[0] != 0:
    raise SystemExit(f"Frame sequence does not start at frame00000.png in {source}")
expected = list(range(nums[0], nums[-1] + 1))
if nums != expected:
    missing = [n for n in expected if n not in nums]
    raise SystemExit(f"Frame sequence has gaps in {source}; first missing entries: {missing[:10]}")
print(f"Validated {len(frames)} contiguous frames in {source}")
PY

mkdir -p "$DEST_DIR"
rm -f "$DEST_DIR"/frame*.png

if [[ "$MOVE_FILES" -eq 1 ]]; then
    echo "Moving GUI-dumped frames to ${DEST_DIR#$REPO_ROOT/}"
    mv "$SOURCE_DIR"/frame*.png "$DEST_DIR"/
else
    echo "Copying GUI-dumped frames to ${DEST_DIR#$REPO_ROOT/}"
    cp "$SOURCE_DIR"/frame*.png "$DEST_DIR"/
fi

echo "Ingest complete: $(find "$DEST_DIR" -maxdepth 1 -type f -name 'frame*.png' | wc -l | tr -d ' ') frames"
