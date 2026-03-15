#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$REPO_ROOT/config/sheet5_overlay.env"

SOURCE_DIR="$REPO_ROOT/$GUI_FRAME_SOURCE"
DEST_DIR="$REPO_ROOT/$PARTS_PASS_DIR"
FRAME_GLOB="${FRAME_GLOB:-frame[0-9][0-9][0-9][0-9][0-9].png}"
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
frames=("$SOURCE_DIR"/$FRAME_GLOB)
if [[ ${#frames[@]} -eq 0 ]]; then
    echo "No GUI-dumped canonical frame PNGs found in $SOURCE_DIR matching $FRAME_GLOB" >&2
    exit 1
fi

python3 - "$SOURCE_DIR" "$FRAME_GLOB" <<'PY'
from pathlib import Path
import sys

source = Path(sys.argv[1])
pattern = sys.argv[2]
frames = sorted(source.glob(pattern))
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
    mv "$SOURCE_DIR"/$FRAME_GLOB "$DEST_DIR"/
else
    echo "Copying GUI-dumped frames to ${DEST_DIR#$REPO_ROOT/}"
    cp "$SOURCE_DIR"/$FRAME_GLOB "$DEST_DIR"/
fi

echo "Ingest complete: $(find "$DEST_DIR" -maxdepth 1 -type f -name 'frame*.png' | wc -l | tr -d ' ') frames"
