# QA Findings

Active QA findings captured during review so they do not get lost in chat history.

## Open

### DRW-001

- Status: resolved
- Scope: DRW-001 source-label reconciliation
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet2.scad`
- Issue: DRW-001 Sheet 2 appears to mislabel the existing link part as `a11`; the source set does not provide evidence for a distinct `a11` part, and the callout should be treated as `a12`.
- Evidence: `ref/drawings/DRW-001-A-Assembly/a_page02.png` labels the flat link-like part as `a11`, while `ref/drawings/DRW-001-A-Assembly/a_page05.png` provides the matching dimensioned link geometry tracked in-project as `a12`; no separate `a11` drawing/detail has been found
- Confidence: high
- Next action: none for label reconciliation; keep future DRW-001 review notes aligned with the `a12` interpretation

- Status: resolved
- Scope: DRW-001 assembly note cleanup
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_a8_subassembly.scad`
- Issue: The reusable A8 subassembly previously referenced a nonexistent `a11`; the code has been reconciled to the project interpretation and should now be reviewed only for layout/fidelity, not missing-part placement.
- Evidence: `scad/assemblies/DRW-001-A-Assembly/drw001_a8_subassembly.scad` now declares only `(a8, a9, a10)`, matching the current interpretation that the mislabelled link belongs to `a12`
- Confidence: high
- Next action: none for note cleanup; any remaining work belongs under sheet fidelity/composition review

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
