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

- Status: resolved
- Scope: DRW-001 sheet reuse / maintainability
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet1.scad`
- Issue: Sheet 1 duplicates assembly geometry locally via `a1_subassembly()`, `a8_subassembly()`, and `a1_gear_assembly()` instead of reusing the existing DRW-001 reusable assembly modules.
- Evidence: local helper modules in `drw001_sheet1.scad` recreate the same assembly structures that already exist in `drw001_a1_subassembly.scad`, `drw001_a8_subassembly.scad`, and `drw001_a1_gear_assembly.scad`
- Confidence: high
- Next action: none for reuse cleanup; review Sheet 1 composition visually against the source layout after the module swap

- Status: resolved
- Scope: DRW-001 sheet reuse / maintainability
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet5.scad`
- Issue: Sheet 5 recreates `a1` geometry locally with `a1_gear()` and `a1_gear_2d()` instead of projecting or reusing the `part_a1()` module.
- Evidence: local `a1_gear()` and `a1_gear_2d()` modules in `drw001_sheet5.scad` duplicate the gear body rather than sourcing it from `scad/parts/DRW-001-A-Assembly/a1.scad`
- Confidence: high
- Next action: none for reuse cleanup; review Sheet 5 composition and A1 orthographic fidelity against the source layout

- Status: resolved
- Scope: DRW-001 sheet fidelity
- File: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet6.scad`
- Issue: Sheet 6 calls the reusable A8 subassembly with `a8_hole_z = 200`, which is far outside the part scale and makes the subassembly placement inconsistent with the source drawing.
- Evidence: `drw001_sheet6.scad` passes `drw001_a8_subassembly(a8_hole_z = 200)` even though the reusable subassembly comment describes `a8_hole_z` as the A8 pin cross-hole center measured from the axle bottom face; the DRW-001 Sheet 6 source shows a compact A8/A9/A10 cluster, not a pin offset by hundreds of millimeters
- Confidence: high
- Next action: none for the internal-override fix; review Sheet 6 composition visually and adjust outer placement only if the page still needs tuning

- Status: resolved
- Scope: DRW-001 metadata synchronization
- File: `ref/meta/parts_list.csv`
- Issue: DRW-001 metadata needed an explicit decision on whether `a11` remained a distinct tracked part or should be folded into `a12`.
- Evidence: the DRW-001 source set provides dimensioned geometry for the flat link tracked as `a12`, while no separate confirmed `a11` part definition has been found in project sources
- Confidence: high
- Next action: none; project policy is now explicit that all DRW-001 references to `a11` should be treated as `a12`, and `parts_list.csv` should continue tracking only `a12`

- Status: resolved
- Scope: DRW-001 part quality pass
- File: `scad/parts/DRW-001-A-Assembly/a8_rivet_pin.scad`
- Issue: `a8` was flagged as a possible geometry mismatch, but the DRW-001 detail confirms it is fundamentally a simple cylindrical pin.
- Evidence: the Sheet 6 detail shows `a8 x 2` with `Ø3.0` and `11` length, matching the current plain-cylinder interpretation; the remaining `R.3 / 0.4` note appears to be a minor end-detail refinement rather than a different overall shape
- Confidence: high
- Next action: none for primary geometry; optional future refinement only if end-edge detail becomes important

- Status: resolved
- Scope: DRW-001 part quality pass
- File: `scad/parts/DRW-001-A-Assembly/a10_disc.scad`
- Issue: `a10` is modeled with `th = 2`, but the DRW-001 detail sheet indicates a `3.0` thickness for the disc.
- Evidence: `ref/drawings/DRW-001-A-Assembly/a_page06.png` shows the A10 side/detail view with a `3.0` thickness callout, while `part_a10()` defaults to `th = 2`
- Confidence: high
- Next action: none for the thickness default; recheck DRW-001 assembly placements only if any visual alignment issues remain
