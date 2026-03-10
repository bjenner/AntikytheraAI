#!/usr/bin/env python3
"""Thin wrapper around scripts/export.sh for local exports."""

from __future__ import annotations

import subprocess
import sys
from pathlib import Path


def main() -> int:
    repo_root = Path(__file__).resolve().parent.parent
    command = ["bash", str(repo_root / "scripts" / "export.sh"), *sys.argv[1:]]
    return subprocess.call(command, cwd=repo_root)


if __name__ == "__main__":
    raise SystemExit(main())
