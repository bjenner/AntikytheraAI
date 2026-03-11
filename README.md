# AntikytheraAI

OpenSCAD project for building and animating an Antikythera-inspired mechanism with AI assistants.

## Project Layout

- `docs/`: sources, design decisions, and assembly notes.
- `scad/`: reusable libraries, parts, assemblies, configs, and top-level entrypoint.
- `exports/`: generated STL, PNG, and DXF output.
- `scripts/`: helper scripts for exports and automation.

## Quick Start

1. Open `scad/main.scad` in OpenSCAD.
2. Edit `scad/configs/presets.scad`:
- `mode`: `"part_a1"`, `"assembly"`, `"exploded"`, or `"animate"`
- `quality`: `"preview"` or `"render"`
3. Press Preview (`F5`) for interactive checks.
4. For animation mode, use Design -> Animate and set FPS/Steps as needed. `spin_turns` controls revolutions per cycle.

## Build And Test Cycle

- Compile-check all parts and assemblies: `bash scripts/check_all.sh`
- Compile-check one file:
  - Part: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' scad/parts/<file>.scad`
  - Assembly: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' scad/assemblies/<file>.scad`
- Export artifacts for changed `.scad` files: `bash scripts/export.sh --changed`
- Export one file explicitly: `bash scripts/export.sh --file scad/parts/a1.scad`
- Export one assembly preview explicitly: `bash scripts/export.sh --file scad/assemblies/drw001_sheet1.scad`

Artifact behavior:
- Part files export to `exports/stl/part_<id>.stl`
- Assembly files export to `exports/png/<basename>.png`
- Drawing-sheet exports use a fixed orthographic top-down camera so they line up with the source sheets more closely
- Use `bash scripts/export.sh --all` to rebuild all current parts and assemblies
- Use `bash scripts/export.sh --render` for higher-quality PNG previews

## QA Preview

- Open source + recreated drawing side by side in Preview: `python3 scripts/qa_preview.py drw001_sheet2`
- Alternate form: `python3 scripts/qa_preview.py DRW-001 2`
- Cycle all available sheets for a drawing: `python3 scripts/qa_preview.py DRW-001`
- Dry-run path resolution only: `python3 scripts/qa_preview.py drw001_sheet2 --dry-run`

Behavior:
- Prefers a local extracted source page PNG when available under `docs/sources/`
- Falls back to the source PDF from `docs/sources/drawing_index.csv` and jumps to the requested sheet page
- Opens the recreated PNG from `exports/png/` and arranges source left / recreation right in Preview on macOS
- In drawing-wide mode, pauses after each sheet until you press Enter, then closes the old pair and opens the next one

## Current Starter Modules

- `scad/parts/a1.scad`: placeholder driven gear/disc.
- `scad/assemblies/full_mechanism.scad`: base plate + rotating A1 placement.
- `scad/main.scad`: top-level selector and animation driver.

## Next Build Targets

- Add tooth-profiled gears in `scad/lib/` and swap placeholders.
- Add additional historical part files under `scad/parts/`.
- Add kinematic links for coupled gear trains in `scad/assemblies/`.

## Source References

This project was developed using publicly available engineering drawings
and research materials for the Antikythera Mechanism.

Primary reference:

• Antikythera Mechanism Engineering Drawings  
  https://www.amclock.net/

The repository includes selected source PDFs and extracted section PDFs for
research/traceability under the original stated license terms.
All original works remain the copyright of their respective owners.

Attribution and third-party license details:
- `THIRD_PARTY_NOTICES.md`

Licensed under CC BY 4.0

## Agent Policy Enforcement

- Project agent policy file: `AGENTS.md` (root).
- Policy validation script: `scripts/check_agents_policy.sh`.
- CI gate: `.github/workflows/agents-policy.yml`.
- Local pre-commit hook support:
  - Run once: `scripts/install-hooks.sh`
  - This sets `core.hooksPath` to `.githooks` and runs policy checks on commit.
