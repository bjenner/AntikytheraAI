# QA Findings

Active QA findings captured during review so they do not get lost in chat history.

## Open

### DRW-001

- Status: open
- Scope: DRW-001 part quality pass
- File: `scad/parts/DRW-001-A-Assembly/a11_gear_lock.scad`
- Issue: `a11` is modeled as a split ring / c-clip style part, but the source drawing shows a flat lever/link-like lock piece.
- Evidence: `ref/drawings/DRW-001-A-Assembly/a_page02.png` exploded view callout for `a11`
- Confidence: high
- Next action: remodel `a11` to match the source silhouette and assembly role, then recheck its use on the DRW-001 assembly sheets

- Status: open
- Scope: DRW-001 assembly reuse / sheet fidelity
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_a8_subassembly.scad`
- Issue: `drw001_a8_subassembly()` declares `(a8, a9, a10, a11)` and imports `a11`, but it never places `part_a11()`.
- Evidence: module header and imports in `scad/assemblies/DRW-001-A-Assembly/drw001_a8_subassembly.scad`, plus the DRW-001 source sheets show `a11` associated with the A8/A10 side assembly
- Confidence: high
- Next action: place `a11` in the reusable A8 subassembly once the `a11` geometry is corrected, then recheck Sheets 2, 6, and 7

- Status: open
- Scope: DRW-001 sheet reuse / maintainability
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet1.scad`
- Issue: Sheet 1 duplicates assembly geometry locally via `a1_subassembly()`, `a8_subassembly()`, and `a1_gear_assembly()` instead of reusing the existing DRW-001 reusable assembly modules.
- Evidence: local helper modules in `drw001_sheet1.scad` recreate the same assembly structures that already exist in `drw001_a1_subassembly.scad`, `drw001_a8_subassembly.scad`, and `drw001_a1_gear_assembly.scad`
- Confidence: high
- Next action: replace the local assembly helpers in Sheet 1 with the reusable DRW-001 assembly modules, then recheck the sheet composition

- Status: open
- Scope: DRW-001 sheet reuse / maintainability
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet5.scad`
- Issue: Sheet 5 recreates `a1` geometry locally with `a1_gear()` and `a1_gear_2d()` instead of projecting or reusing the `part_a1()` module.
- Evidence: local `a1_gear()` and `a1_gear_2d()` modules in `drw001_sheet5.scad` duplicate the gear body rather than sourcing it from `scad/parts/DRW-001-A-Assembly/a1.scad`
- Confidence: high
- Next action: reuse `part_a1()` for the 3D thumbnail and orthographic projection, then recheck the sheet layout and dimensions

- Status: open
- Scope: DRW-001 sheet fidelity
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet6.scad`
- Issue: Sheet 6 calls the reusable A8 subassembly with `a8_hole_z = 200`, which is far outside the part scale and makes the subassembly placement inconsistent with the source drawing.
- Evidence: `drw001_sheet6.scad` passes `drw001_a8_subassembly(a8_hole_z = 200)` even though the reusable subassembly comment describes `a8_hole_z` as the A8 pin cross-hole center measured from the axle bottom face; the DRW-001 Sheet 6 source shows a compact A8/A9/A10 cluster, not a pin offset by hundreds of millimeters
- Confidence: high
- Next action: remove the extreme override or replace it with a drawing-based value once the A8 subassembly is corrected, then recheck Sheet 6 composition
