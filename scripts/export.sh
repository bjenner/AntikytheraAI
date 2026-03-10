#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PARTS_DIR="$REPO_ROOT/scad/parts"
ASSEMBLIES_DIR="$REPO_ROOT/scad/assemblies"
STL_DIR="$REPO_ROOT/exports/stl"
PNG_DIR="$REPO_ROOT/exports/png"

if command -v openscad >/dev/null 2>&1; then
    OPENSCAD="openscad"
elif [ -x "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD" ]; then
    OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
else
    echo "ERROR: openscad not found in PATH or /Applications/OpenSCAD.app" >&2
    exit 1
fi

mkdir -p "$STL_DIR" "$PNG_DIR"

usage() {
    cat <<'EOF'
Usage:
  bash scripts/export.sh --changed
  bash scripts/export.sh --all
  bash scripts/export.sh --file scad/parts/a1.scad
  bash scripts/export.sh --file scad/assemblies/drw001_sheet2.scad

Options:
  --changed           Export changed/untracked .scad files from git status (default)
  --all               Export all part and assembly .scad files
  --file <path>       Export one specific .scad file; may be used multiple times
  --imgsize WxH       PNG size for assembly exports (default: 1600x1200)
  --render            Use render quality for PNG exports
  --help              Show this message

Behavior:
  - Part files under scad/parts export to exports/stl/part_<id>.stl
  - Assembly files under scad/assemblies export to exports/png/<basename>.png
EOF
}

IMG_W=1600
IMG_H=1200
PNG_QUALITY="preview"
MODE="changed"
FILES=()
SHEET_W=420
SHEET_H=297
SHEET_CAM_Z=600
SHEET_CAM_DIST=800

while [ $# -gt 0 ]; do
    case "$1" in
        --changed)
            MODE="changed"
            ;;
        --all)
            MODE="all"
            ;;
        --file)
            MODE="files"
            [ $# -ge 2 ] || { echo "ERROR: --file requires a path" >&2; exit 1; }
            FILES+=("$2")
            shift
            ;;
        --imgsize)
            [ $# -ge 2 ] || { echo "ERROR: --imgsize requires WxH" >&2; exit 1; }
            IMG_W="${2%x*}"
            IMG_H="${2#*x}"
            shift
            ;;
        --render)
            PNG_QUALITY="render"
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            echo "ERROR: unknown argument: $1" >&2
            usage >&2
            exit 1
            ;;
    esac
    shift
done

collect_changed_files() {
    git -C "$REPO_ROOT" status --short --untracked-files=all -- "scad/parts/*.scad" "scad/assemblies/*.scad" \
        | while read -r status path; do
            [ -n "${path:-}" ] || continue
            printf '%s\n' "$path"
        done
}

collect_all_files() {
    for file in "$PARTS_DIR"/*.scad "$ASSEMBLIES_DIR"/*.scad; do
        [ -f "$file" ] || continue
        printf '%s\n' "$file"
    done
}

normalize_file() {
    local path="$1"
    case "$path" in
        "$REPO_ROOT"/*)
            printf '%s\n' "$path"
            ;;
        /*)
            printf '%s\n' "$path"
            ;;
        *)
            printf '%s\n' "$REPO_ROOT/$path"
            ;;
    esac
}

part_export_name() {
    local stem="$1"
    local part_id="${stem%%_*}"
    printf 'part_%s.stl\n' "$part_id"
}

export_part() {
    local file="$1"
    local stem out
    stem="$(basename "$file" .scad)"
    out="$STL_DIR/$(part_export_name "$stem")"
    echo "[stl] $(basename "$file") -> ${out#$REPO_ROOT/}"
    "$OPENSCAD" -o "$out" "$file"
}

export_assembly() {
    local file="$1"
    local stem out
    stem="$(basename "$file" .scad)"
    out="$PNG_DIR/$stem.png"
    echo "[png] $(basename "$file") -> ${out#$REPO_ROOT/}"

    case "$stem" in
        drw*_sheet*|parts_inventory)
            "$OPENSCAD" \
                --imgsize="$IMG_W","$IMG_H" \
                --projection=o \
                --camera="$((SHEET_W / 2)),$((SHEET_H / 2)),$SHEET_CAM_Z,0,0,0,$SHEET_CAM_DIST" \
                -D "quality=\"$PNG_QUALITY\"" \
                -o "$out" \
                "$file"
            ;;
        *)
            "$OPENSCAD" \
                --imgsize="$IMG_W","$IMG_H" \
                --viewall \
                --autocenter \
                -D "quality=\"$PNG_QUALITY\"" \
                -o "$out" \
                "$file"
            ;;
    esac
}

FILES_TO_EXPORT=()

case "$MODE" in
    changed)
        while read -r file; do
            [ -n "$file" ] || continue
            FILES_TO_EXPORT+=("$(normalize_file "$file")")
        done < <(collect_changed_files)
        ;;
    all)
        while read -r file; do
            [ -n "$file" ] || continue
            FILES_TO_EXPORT+=("$file")
        done < <(collect_all_files)
        ;;
    files)
        for file in "${FILES[@]}"; do
            FILES_TO_EXPORT+=("$(normalize_file "$file")")
        done
        ;;
esac

if [ ${#FILES_TO_EXPORT[@]} -eq 0 ]; then
    echo "No changed .scad files found under scad/parts or scad/assemblies." >&2
    if [ "$MODE" = "changed" ]; then
        echo "Tip: modify a .scad file first, or use --file / --all." >&2
    fi
    exit 0
fi

PASS=0
FAIL=0

for file in "${FILES_TO_EXPORT[@]}"; do
    if [ ! -f "$file" ]; then
        echo "[skip] missing file: ${file#$REPO_ROOT/}" >&2
        ((FAIL++)) || true
        continue
    fi

    case "$file" in
        "$PARTS_DIR"/*.scad)
            if export_part "$file"; then
                ((PASS++)) || true
            else
                echo "[fail] $(basename "$file")" >&2
                ((FAIL++)) || true
            fi
            ;;
        "$ASSEMBLIES_DIR"/*.scad)
            if export_assembly "$file"; then
                ((PASS++)) || true
            else
                echo "[fail] $(basename "$file")" >&2
                ((FAIL++)) || true
            fi
            ;;
        *)
            echo "[skip] unsupported path: ${file#$REPO_ROOT/}" >&2
            ((FAIL++)) || true
            ;;
    esac
done

echo ""
echo "Export summary: PASS=$PASS FAIL=$FAIL"

[ "$FAIL" -eq 0 ]
