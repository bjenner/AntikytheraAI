# DRW-001: a assembly (rough draft)

## Scope
- Drawing ID: `DRW-001`
- Source PDF: `ref/drawings/DRW-001-A-Assembly/a.pdf`
- Source PNG prefix: `a_page*.png`
- Expected sheets/pages: `1..7`
- Current SCAD sheets: `scad/assemblies/DRW-001-A-Assembly/drw001_sheet1.scad` through `drw001_sheet7.scad`

## Drawing Description
`DRW-001` is the A-series subassembly around a large disc/crank assembly and a small gear-mount cluster. Across sheets, it covers:
- overall assembly views
- exploded/parts-list layout
- clearance geometry (a1 to b1 interface)
- detailed component views for `a1..a12`
- subassembly composition (`a1` side and `a8` side)

## Sheet-by-Sheet Summary

### Sheet 1 (`drw001_sheet1`)
- Intent: assembly overview (multi-view composition)
- Modeled parts used: `a1, a2, a3, a4, a5, a6, a7, a8, a9, a10`
- Notes: includes two subassemblies (`a1_subassembly`, `a8_subassembly`) and a full assembly composition.

### Sheet 2 (`drw001_sheet2`)
- Intent: parts list and exploded positioning
- Modeled parts used: `a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, cp-r5, cp-f5, cp-f6`
- Notes: sheet now instantiates dedicated `a11` and CP part modules instead of stand-in geometry.

### Sheet 3 (`drw001_sheet3`)
- Intent: `a1` to `b1` gear clearance diagram
- Modeled parts used directly: none (drawing primitives only)
- Notes: sheet encodes explicit clearance/mesh values and center-distance annotations.

### Sheet 4 (`drw001_sheet4`)
- Intent: `a1` axle gear clearance drawing/section
- Modeled parts used directly: none (drawing primitives only)
- Notes: drawing-only reconstruction with section view and hatching.

### Sheet 5 (`drw001_sheet5`)
- Intent: detailed part views (`a1` to `a7`, `a12`)
- Modeled parts used: `a2, a3, a4, a5, a6, a12` plus local `a1_gear()` helper
- Notes: includes orthographic + isometric style layout and sample dimensions.
- Note: source callout for the small A1-side subassembly is treated as a drawing error; use `a3` (not `a4`) as the riveted/fit mate to `a1`.
- Note: the `a1` subassembly annotation appears to mislabel part `a3` as `a4`; project assembly references should treat that fitted rivet/pin part as `a3`.
- Note: Sheet 5 dimensions and geometry are currently treated as `a12`, even though the source sheet appears to label that part as `a11` in at least one view. No local dimension set for a distinct `a11` part has been found in the project sources.

### Sheet 6 (`drw001_sheet6`)
- Intent: detailed part views (`a7` to `a10`)
- Modeled parts used: `a7, a8, a9, a10`
- Notes: includes `a8_subassembly` depiction.

### Sheet 7 (`drw001_sheet7`)
- Intent: `a1` gear assembly composition
- Modeled parts used: `a1, a2, a4, a8, a9, a10`
- Notes: combines `a1_subassembly` and `a8_subassembly` with coupling shaft geometry.

## DRW-001 Part Inventory (Current Modeled Parts)

Dimensions below are the current default parameters in each part file (mm).

| Part | File | Current modeled dimensions (default params) |
|---|---|---|
| `a1` | `scad/parts/DRW-001-A-Assembly/a1.scad` | `body_d=28.2`, `thickness=2.0`, `bore_d=5.0`, `spoke_count=6`, `teeth=56` |
| `a2` | `scad/parts/DRW-001-A-Assembly/a2_ring.scad` | `od=16`, `id=10`, `th=0.7` |
| `a3` | `scad/parts/DRW-001-A-Assembly/a3_pin.scad` | `d=9.8`, `h=16.6`; stepped stack with top lobed boss, lower slot, and `Ø1.5` cross-hole |
| `a4` | `scad/parts/DRW-001-A-Assembly/a4_block.scad` | `w=16`, `d=8`, `body_h=32.2`, `top_pin_d=2.9`, `top_pin_h=2.0`, `pin_spacing=8.0`, `bore_d=10.0`, `bore_center_z=17.6` |
| `a5` | `scad/parts/DRW-001-A-Assembly/a5_ring.scad` | `od=12`, `id=8`, `th=0.1` |
| `a6` | `scad/parts/DRW-001-A-Assembly/a6_bush.scad` | `od=11.8`, `id=8.0`, `h=17.0`, `u_slot_w=3.0`, `u_slot_h=8.8` |
| `a7` | `scad/parts/DRW-001-A-Assembly/a7_block.scad` | `w=16.0`, `d=8.0`, `body_h=35.2`, `bore_d=12.0`, `top_post_d=4.6`, `top_post_h=5.0` |
| `a8` | `scad/parts/DRW-001-A-Assembly/a8_rivet_pin.scad` | `pin_d=3.0`, `pin_h=11.0` |
| `a9` | `scad/parts/DRW-001-A-Assembly/a9_axle.scad` | `body_d=14.0`, `body_h=32.0`, `upper_d=8.8`, `upper_h=11.4`, `bottom_core_d=9.0`, `bottom_pin_d=3.0`, `bottom_pin_h=3.0` |
| `a10` | `scad/parts/DRW-001-A-Assembly/a10_disc.scad` | `od=111`, `th=2`, `center_hole_d=9` |
| `a11` | `scad/parts/DRW-001-A-Assembly/a11_gear_lock.scad` | `od=18.0`, `id=9.0`, `th=1.5`, `gap_w=2.0` |
| `a12` | `scad/parts/DRW-001-A-Assembly/a12_link.scad` | `th=1.0`; `c2c=19.5`, `hole_d=3.0`, `r_left=5.0`, `r_right=2.5`, `shoulder_r=4.5`, tapered left tab |

### Part Status Notes
- `a12` is now considered a workable baseline for DRW-001 Sheet 5.
- Remaining sharp corners on `a12` are currently treated as non-functional/cosmetic.
- `a12` still needs a future refinement pass to smooth/curve specific edge transitions to better match the engineering drawing.
- `a1` is a workable baseline, but tooth profile should be revisited when the mating gear/part is modeled so both tooth forms can be tuned together.
- `a3` has been upgraded from placeholder to a working draft matching key DRW-001 Sheet 5 features (lobed top, lower split slot, `Ø1.5` cross-hole, stepped stack).
- `a3` still needs a fine-tuning pass for exact contour radii and height segmentation against the engineering dimensions.
- `a4` has completed a first correction pass: top bosses are now additive (`Ø2.9`, `2.0` high), overall height is dimensioned (`32.2`), bore is dimension-positioned (`Ø10.0` at `z=17.6`), and lower cutouts were added as a first-pass interpretation.
- `a4` still needs a contour/detail pass to better match the drawing end radii/edge transitions and exact lower cutout profile.
- `a6` currently has a known modeling issue: the top slots do not yet cut fully through the cylinder wall; defer this to the later part-correction pass.
- The `a1`-to-`a6` locking detail remains unresolved: Sheet 7 shows the `a1` subassembly engaging `a6`, but the project does not yet identify a confirmed separate locking hardware part for the `a3` slot / `a6` interface.
- The `a6`-to-`a8` fit is currently inconsistent in the modeled defaults: Sheet 7 calls for a tight friction fit, but the present part files use `a6.id=8.0` and `a9.upper_d=8.8`, so the assembly cannot yet represent that fit faithfully. Leave the current parts and assembly placement as-is for now and defer the fit reconciliation to a later correction pass.
- `a7` has a known unfinished top feature: the current top post is only a simplified baseline, and the intended top slot/groove details are not yet modeled; defer this to the later part-correction pass.
- `a11` remains semantically uncertain: the active DRW-001 project treats it as a lock ring / gear lock tied to `b1 Gear Lock.ipt` on Sheet 2, while the Sheet 5 dimensioned part is currently modeled and tracked as `a12`.

## Cross-Sheet Part Coverage

| Part | Sheets using modeled part geometry |
|---|---|
| `a1` | `1,2,7` |
| `a2` | `1,2,5,7` |
| `a3` | `1,2,5` |
| `a4` | `1,2,5,7` |
| `a5` | `1,2,5` |
| `a6` | `1,2,5` |
| `a7` | `1,2,6` |
| `a8` | `1,2,6,7` |
| `a9` | `1,2,6,7` |
| `a10` | `1,2,6,7` |
| `a11` | `2` |
| `a12` | `2,5` |

### Non-A parts used in DRW-001 assemblies

| Part | File | Sheets using modeled part geometry |
|---|---|---|
| `cp-r5` | `scad/parts/DRW-005-Common-Parts/cpr5_rivet.scad` | `2` |
| `cp-f5` | `scad/parts/DRW-005-Common-Parts/cpf5_fork.scad` | `2` |
| `cp-f6` | `scad/parts/DRW-005-Common-Parts/cpf6_fork.scad` | `2` |

## Rough Gaps To Resolve (next pass)
- Sheet 2 dedicated-part gap is resolved (`a11`, `cp-r5`, `cp-f5`, `cp-f6` now instantiated from part files).
- `a1` spoke-loop warning is resolved: `part_a1()` now guards `spoke_count <= 0`, removing prior `nan/-inf` rotate warnings in DRW-001 exports.
- Sheets 3 and 4 are drawing-primitives only; decide whether any features should reference existing part modules for consistency.
- Several sheet views override part dimensions inline (for presentation). Confirm whether these should be standardized to part defaults or documented as view-only scaling/placeholder dimensions.
- STL export QA still reports manifold/mesh-closure warnings on some sheet scenes (notably 1, 5, 6, 7); review sheet solids if print manifold quality is required.

## Source Links
- Metadata row: `ref/meta/drawing_index.csv` (`DRW-001`)
- Reconciliation rows: `ref/meta/parts_list.csv` (`a1..a12`)
