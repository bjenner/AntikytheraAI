# DRW-005: Common Parts

## Scope
- Drawing ID: `DRW-005`
- Source PDF: `ref/drawings/DRW-005-Common-Parts/Common Parts.pdf`
- Expected sheets/pages: `1..3`
- Current SCAD sheets: `scad/assemblies/DRW-005-Common-Parts/drw005_sheet1.scad` through `drw005_sheet3.scad`

## Notes
- `cp-f5` now has a tuned first-pass body and slot reconstruction in [`scad/parts/DRW-005-Common-Parts/cpf5_fork.scad`](../../../scad/parts/DRW-005-Common-Parts/cpf5_fork.scad).
- The small outer `R0.3 mm` chamfer/edge treatment shown on the `cp-f5` section detail is not yet modeled.
- `cp-f6` now has a workable first-pass body and slot reconstruction in [`scad/parts/DRW-005-Common-Parts/cpf6_fork.scad`](../../../scad/parts/DRW-005-Common-Parts/cpf6_fork.scad).
- The outer `R1.8` chamfer/edge treatment called out on the drawing is not yet modeled.
- Treat that outer edge on `cp-f6` as an explicit follow-up task rather than an accidental omission.

## Source Links
- Metadata row: `ref/meta/drawing_index.csv` (`DRW-005`)
- Reconciliation rows: `ref/meta/parts_list.csv` (`cp1..cp9`, `cpf1..cpf6`, `cpr1..cpr6`)
