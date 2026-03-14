#!/usr/bin/env bash
# check_all.sh — compile-check all parts and assemblies
# Usage: ./scripts/check_all.sh [--stop-on-error]

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCAD_PARTS="$REPO_ROOT/scad/parts"
SCAD_ASSEMBLIES="$REPO_ROOT/scad/assemblies"

# Locate openscad binary
if command -v openscad &>/dev/null; then
    OPENSCAD="openscad"
elif [ -x "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD" ]; then
    OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
else
    echo "ERROR: openscad not found in PATH or /Applications/OpenSCAD.app" >&2
    exit 1
fi

STOP_ON_ERROR=0
[[ "${1:-}" == "--stop-on-error" ]] && STOP_ON_ERROR=1

PASS=0
FAIL=0
ERRORS=()
TMPFILE="$(mktemp /tmp/scad_check_XXXXXX.csg)"
trap 'rm -f "$TMPFILE"' EXIT

check_file() {
    local file="$1"
    local label
    label="$(basename "$file")"
    # Pass __LIB_MODE__=1 so main guards don't auto-render; export CSG to force full parse
    if "$OPENSCAD" --export-format csg -o "$TMPFILE" -D '__LIB_MODE__=1' "$file" 2>/dev/null; then
        echo "  PASS  $label"
        ((PASS++)) || true
    else
        echo "  FAIL  $label"
        "$OPENSCAD" --export-format csg -o "$TMPFILE" -D '__LIB_MODE__=1' "$file" 2>&1 \
            | grep -i "error\|warning" | head -5 | sed 's/^/          /'
        ERRORS+=("$file")
        ((FAIL++)) || true
        if [[ $STOP_ON_ERROR -eq 1 ]]; then
            echo "Stopped on first error. Re-run without --stop-on-error to see all failures."
            exit 1
        fi
    fi
}

echo "=== Parts ==="
while IFS= read -r f; do
    check_file "$f"
done < <(find "$SCAD_PARTS" -type f -name '*.scad' | sort)

echo ""
echo "=== Assemblies ==="
while IFS= read -r f; do
    check_file "$f"
done < <(find "$SCAD_ASSEMBLIES" -type f -name '*.scad' | sort)

echo ""
echo "=== Summary ==="
echo "  PASS: $PASS"
echo "  FAIL: $FAIL"

if [[ ${#ERRORS[@]} -gt 0 ]]; then
    echo ""
    echo "Failed files:"
    for e in "${ERRORS[@]}"; do
        echo "  $e"
    done
    exit 1
fi

echo "All files passed."
