# Current Goal: DRW-001 completion and ordering (Milestone C)

## Status update
- Milestone B is paused.
- Active focus is narrowed to `DRW-001` only.

## Outcome
Deliver a clean, complete, and ordered Drawing 1 implementation across parts, assembly sheets, router modes, and metadata.

## Acceptance criteria
- `DRW-001` sheets `1..7` compile and render through `scad/main.scad` modes.
- `DRW-001` page order is consistent across:
  - `scad/assemblies/`
  - `scad/main.scad` `use` lines
  - `scad/main.scad` mode branches
  - `scad/configs/presets.scad` mode comment list
- All `a`-series part files used by Drawing 1 compile in library mode.
- `docs/sources/drawing_index.csv` has correct `scad_status` and ordered `scad_sheets_done` for `DRW-001`.
- `docs/sources/parts_list.csv` entries for Drawing 1 parts contain stable IDs and `scad_file` evidence.
- Checkpoint commits are made at agreed milestones.

## Next milestone (after C)
Proceed to `DRW-002` cleanup using the same page-ordered workflow.
