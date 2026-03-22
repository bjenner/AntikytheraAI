#!/usr/bin/env bash
set -euo pipefail

OPENSCAD_APP="/Applications/OpenSCAD.app"
OPENSCAD_BIN="$OPENSCAD_APP/Contents/MacOS/OpenSCAD"
OPENSCAD_PLUGINS="$OPENSCAD_APP/Contents/PlugIns"
OPENSCAD_PLATFORMS="$OPENSCAD_PLUGINS/platforms"

run_openscad() {
    local bin="$1"
    shift

    local stderr_log
    local stdout_text=""
    stderr_log="$(mktemp -t openscad_stderr)"
    trap 'rm -f "$stderr_log"' RETURN

    set +e
    stdout_text="$("$bin" "$@" 2>"$stderr_log")"
    local status=$?
    set -e

    if [[ $status -eq 0 ]]; then
        printf '%s' "$stdout_text"
        cat "$stderr_log" >&2
        return 0
    fi

    printf '%s' "$stdout_text"
    cat "$stderr_log" >&2
    if grep -q "Incompatible processor\. This Qt build requires the following features:" "$stderr_log"; then
        echo "" >&2
        echo "ERROR: OpenSCAD launched, but its bundled Qt runtime rejected this processor environment." >&2
        echo "DETAIL: Qt reported a missing CPU feature (for example: NEON), which usually means" >&2
        echo "        the current execution runtime is incompatible with this OpenSCAD build." >&2
        echo "NOTE:   On this repo's typical macOS setup, /Applications/OpenSCAD.app is often a" >&2
        echo "        universal binary already, so this is usually a sandbox/runtime issue rather" >&2
        echo "        than a bad local install." >&2
        echo "ACTION: Run the same command in your normal local macOS Terminal or the OpenSCAD GUI." >&2
        echo "        If it works there, keep using the wrapper locally and treat this agent runtime" >&2
        echo "        as incompatible with OpenSCAD execution." >&2
    fi

    if grep -q 'Qt platform plugin "cocoa"' "$stderr_log"; then
        echo "" >&2
        echo "ERROR: OpenSCAD could not load the Qt cocoa platform plugin." >&2
        echo "DETAIL: This usually happens when the app binary is launched without the app bundle's" >&2
        echo "        Qt plugin paths in the environment." >&2
        echo "ACTION: Use scripts/openscad.sh or open -a \"/Applications/OpenSCAD.app\" instead of" >&2
        echo "        invoking the raw app binary directly from an arbitrary shell environment." >&2
    fi

    return "$status"
}

if [ -x "$OPENSCAD_BIN" ]; then
    export QT_PLUGIN_PATH="$OPENSCAD_PLUGINS"
    export QT_QPA_PLATFORM_PLUGIN_PATH="$OPENSCAD_PLATFORMS"
    run_openscad "$OPENSCAD_BIN" "$@"
    exit $?
fi

if command -v openscad >/dev/null 2>&1; then
    run_openscad openscad "$@"
    exit $?
fi

echo "ERROR: OpenSCAD not found in /Applications/OpenSCAD.app or PATH" >&2
exit 1
