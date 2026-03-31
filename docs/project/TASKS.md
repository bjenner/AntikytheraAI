# Tasks (next actions)

## Active Milestone
- `Milestone C`: complete and normalize `DRW-001` (`a assembly`) in strict sheet order.

## DRW-001 snapshot
- Source drawing: `ref/drawings/DRW-001-A-Assembly/a.pdf`
- Source page PNGs: `ref/drawings/DRW-001-A-Assembly/a_page*.png`
- Target sheets: `1,2,3,4,5,6,7`
- Current file presence: all 7 assembly sheet files exist
- Current priority: quality + ordering + metadata consistency

## Ordered execution plan (do in sequence)

### 1) Baseline and ordering
- [x] Verify `drw001_sheet1..drw001_sheet7.scad` each compile standalone.
- [x] Normalize assembly module naming and main-guard consistency in all 7 sheet files.
- [x] Reorder `use <assemblies/drw001_sheetX.scad>` lines in `scad/main.scad` to 1..7 (contiguous).
- [x] Ensure `mode == "drw001_sheetX"` branches are present and ordered 1..7 in `scad/main.scad`.
- [x] Ensure `presets.scad` mode comment list contains ordered `drw001_sheet1..drw001_sheet7`.

### 2) Part quality pass (a-series only)
- [x] Review `a1..a12` against `a_page*.png` references for obvious proportion and feature mismatches.
- [x] Fix high-confidence geometry issues only (OD/ID, thickness, hole locations, tooth count where legible).
- [x] Keep each part file compliant with project standard:
  - [x] `part_<id>()` top-level module.
  - [x] main guard block present.

### 3) Sheet quality pass (1 to 7)
- [x] Sheet 1: composition and label sanity.
- [x] Sheet 2: composition and label sanity.
- [x] Sheet 3: composition and label sanity.
- [x] Sheet 4: composition and label sanity.
- [x] Sheet 5: composition and label sanity.
- [x] Sheet 6: composition and label sanity.
- [x] Sheet 7: composition and label sanity.
- [x] Ensure sheet files reuse part modules and do not duplicate part geometry.

### 4) Metadata synchronization
- [ ] Confirm `drawing_index.csv` row `DRW-001` has:
  - `scad_status=complete`
  - `scad_sheets_done="1,2,3,4,5,6,7"`
- [ ] Confirm `parts_list.csv` contains stable rows for `a`-series IDs used in `DRW-001`.
- [ ] Add/update `scad_file=...` evidence for updated/added entries.

### 5) QA gate
- [ ] Run OpenSCAD compile checks for changed a-series parts (`__LIB_MODE__=1`).
- [ ] Run OpenSCAD compile checks for all 7 `drw001_sheetX` modes.
- [ ] Validate no broken mode routing for `DRW-001` in `main.scad` and `presets.scad`.

## Definition of done for Milestone C
- [ ] All seven `DRW-001` sheets render from their own files and via `main.scad` modes.
- [ ] `DRW-001` routing and mode declarations are in strict numeric order everywhere.
- [ ] `a`-series parts used by `DRW-001` pass compile checks.
- [ ] Metadata rows for `DRW-001` and its parts are consistent and traceable.
- [ ] Checkpoint commit created.

## Commit cadence (for this milestone)
- [ ] `checkpoint 1`: ordering + routing cleanup
- [ ] `checkpoint 2`: part quality fixes
- [ ] `checkpoint 3`: sheet quality + metadata + QA
