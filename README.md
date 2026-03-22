# AntikytheraAI

OpenSCAD project for building and animating an Antikythera-inspired mechanism with AI assistants.

## Project Layout

- `ref/`: source drawings, part reference images, manuals, and metadata.
- `ref/drawings/DRW-...-Name/`: one folder per drawing with the source PDF and extracted page PNGs.
- `docs/`: project notes, planning, and design decisions.
- `scad/parts/DRW-...-Name/`: parts grouped by origin drawing.
- `scad/assemblies/DRW-...-Name/`: sheets and subassemblies grouped by drawing.
- `scad/`: reusable libraries, configs, routers, and top-level entrypoint.
- `exports/DRW-...-Name/`: generated PNG and STL outputs grouped by drawing.
- `scripts/`: helper scripts for exports and automation.

## Quick Start

1. Open `scad/main.scad` in OpenSCAD.
2. Edit `scad/configs/presets.scad`:
- `mode`: `"part_a1"`, `"assembly"`, `"exploded"`, or `"animate"`
- `quality`: `"preview"` or `"render"`
3. Press Preview (`F5`) for interactive checks.
4. For animation mode, use Design -> Animate and set FPS/Steps as needed. `spin_turns` controls revolutions per cycle.

OpenSCAD on macOS:
- Repo scripts use `scripts/openscad.sh`, which launches `/Applications/OpenSCAD.app` with the Qt plugin paths set explicitly.
- This avoids the common VS Code / terminal `Qt platform plugin "cocoa"` startup failure when calling the app binary indirectly.

## Build And Test Cycle

- Compile-check all parts and assemblies: `bash scripts/check_all.sh`
- Compile-check one file:
  - Part: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' scad/parts/<drawing-folder>/<file>.scad`
  - Assembly: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' scad/assemblies/<drawing-folder>/<file>.scad`
- Export artifacts for changed `.scad` files: `bash scripts/export.sh --changed`
- Export one file explicitly: `bash scripts/export.sh --file scad/parts/DRW-001-A-Assembly/a1.scad`
- Export one assembly preview explicitly: `bash scripts/export.sh --file scad/assemblies/DRW-001-A-Assembly/drw001_sheet1.scad`

Artifact behavior:
- Part files export to `exports/<drawing-folder>/part_<id>.stl`
- Assembly files export to `exports/<drawing-folder>/<basename>.png`
- Drawing-sheet exports use a fixed orthographic top-down camera so they line up with the source sheets more closely
- Use `bash scripts/export.sh --all` to rebuild all current parts and assemblies
- Use `bash scripts/export.sh --render` for higher-quality PNG previews

## QA Preview

- Open source + recreated drawing side by side in Preview: `python3 scripts/qa_preview.py drw001_sheet2`
- Alternate form: `python3 scripts/qa_preview.py DRW-001 2`
- Cycle all available sheets for a drawing: `python3 scripts/qa_preview.py DRW-001`
- Open a source part image + rendered part side by side: `python3 scripts/qa_preview.py b0_gear`
- Dry-run path resolution only: `python3 scripts/qa_preview.py drw001_sheet2 --dry-run`

Behavior:
- Prefers a local extracted source page PNG in the matching `ref/drawings/DRW-...-Name/` folder
- Falls back to the source PDF from `ref/meta/drawing_index.csv` and jumps to the requested sheet page
- Opens the recreated PNG from `exports/<drawing-folder>/` and arranges source left / recreation right in Preview on macOS
- In drawing-wide mode, pauses after each sheet until you press Enter, then closes the old pair and opens the next one
- In part mode, renders a fresh orthographic PNG to `exports/<drawing-folder>/<part>.png` before opening it

## Key Entry Points

- `scad/parts/DRW-001-A-Assembly/a1.scad`: representative part file.
- `scad/assemblies/full_mechanism.scad`: base plate + rotating A1 placement.
- `scad/main.scad`: top-level selector and animation driver.

## Next Build Targets

- Add tooth-profiled gears in `scad/lib/` and swap placeholders.
- Add additional historical part files under `scad/parts/<drawing-folder>/`.
- Add kinematic links for coupled gear trains in `scad/assemblies/<drawing-folder>/`.

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
