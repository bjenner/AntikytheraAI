# Decision Note: Section 8.11.5 Superior Planet Plate (First Pass)

## Source
- Manual section: `8.11.5 Superior Planet Plate`
- Drawing index reference: `DRW-056`
- Pages: `106-109` (text provided directly)

## What Was Captured
- Updated `DRW-056` metadata from generic extracted-PDF placeholder to a manufacturing text section summary.
- Added explicit `DRW-056` traceability to existing superior-planet generic part rows (`PRT-SPP-001` to `PRT-SPP-010`).
- Added explicit section-named part candidates:
  - `PRT-SPP-011` (`SP1`)
  - `PRT-SPP-012` (`SP2` + axle)
  - `PRT-SPP-013` (`SP3`)
  - `PRT-SPP-014` (`SP4` pin set quantity 4)
  - `PRT-SPP-015` (`SP5`)
  - `PRT-SPP-016` (`SP7`)
  - `PRT-SPP-017` (date pointer base for this assembly stage)
  - `PRT-SAT-011` (`SAT6` axle trim instruction)
  - Correction from DRW-022 sheet view: explicit `SP6 x4` rivet pins and `SP1/SP5/SP7` callouts are present on the engineering drawing page.

## Initial OpenSCAD Targets
- `scad/parts/DRW-022-Superior-Planet-Plate/sp1_superior_gear.scad` -> `part_sp1()`
- `scad/parts/DRW-022-Superior-Planet-Plate/sp2_gear_axle_subassembly.scad` -> `part_sp2()`
- `scad/parts/DRW-022-Superior-Planet-Plate/sp3_superior_plate.scad` -> `part_sp3()`
- `scad/parts/DRW-022-Superior-Planet-Plate/sp4_press_pin.scad` -> `part_sp4()`
- `scad/parts/DRW-022-Superior-Planet-Plate/sp5_superior_plate.scad` -> `part_sp5()`
- `scad/parts/DRW-022-Superior-Planet-Plate/sp6_rivet_pin.scad` -> `part_sp6()`
- `scad/parts/DRW-022-Superior-Planet-Plate/sp7_companion_gear.scad` -> `part_sp7()`
- `scad/parts/DRW-022-Superior-Planet-Plate/sat6_date_pointer_axle.scad` -> `part_sat6()`
- `scad/parts/DRW-022-Superior-Planet-Plate/spp17_date_pointer_base.scad` -> `part_spp17()`

## Key Constraints From Text
- `SP3` has four non-evenly spaced mounting holes and one valid orientation to `B1`.
- `SP1` and `SP2` tooth fit requires non-jamming minimum clearance.
- `SP4` is explicitly four pins and is filed flush after press fit.
- Bearing-finish and bush-clearance requirements are explicitly called out for multiple interfaces.
- `SAT6` axle length target: less than `0.5 mm` clearance between date pointer base and `SP3`.

## Open Questions
- Whether newly explicit `SP*` parts should merge with existing generic `PRT-SPP-005/006/008/009` rows.
- Whether `PRT-SPP-017` is the same physical part as previously modeled date pointer base items.
- Whether `SP5` should remain `shaft` category or be split into hub + shaft + bearing surfaces.

## Resolved: SP4 vs SP6 Naming Conflict

**Decision:** SP4 and SP6 are confirmed as two distinct physical pins used in different operations of the superior planet plate sub-assembly.

| Part ID | Label | Source | Dimensions | Operation |
|---|---|---|---|---|
| PRT-SPP-014 | SP4 | Manual sec 8.11.5 (DRW-056) | 2.2 mm dia × 8 mm | Press-fit SP1 + SP7 to SP5; filed flush after |
| PRT-SPP-018 | SP6 | Drawing DRW-022 sheet 5 | 3.0 mm dia × 5.0 mm | Rivet SP1 to SP5 (4× pins) |

Both SCAD files (`sp4_press_pin.scad`, `sp6_rivet_pin.scad`) and both CSV rows are kept. Both are wired in `main.scad`. The naming difference (manual calls SP4; drawing calls SP6) reflects two separate assembly steps, not the same pin labeled differently.
