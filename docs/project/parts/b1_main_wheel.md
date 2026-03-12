# b1 Main Wheel Notes

## Scope
- Part: `b1`
- SCAD file: `scad/parts/b1_main_wheel.scad`
- Primary source image: `docs/sources/Parts/b1_main_wheel.png`
- Drawing set: `DRW-002`

## Hole Schedule

Coordinates below are interpreted from the source drawing relative to the wheel center `(0, 0)` in mm.
Where the source image is ambiguous, the note calls that out explicitly.

| ID | Source callout | Nominal center `(x, y)` | Status in model | Notes |
|---|---|---:|---|---|
| `H01` | `Ø11.0` | `(0.0, 0.0)` | modeled | Main center bore |
| `H02` | `Ø7.0` | `(0.0, +29.4)` | modeled | Upper hole on vertical centerline |
| `H03` | `Ø6.0` | `(-26.5, 0.0)` | modeled | Left-side inner hole |
| `H04` | `Ø2.5` | `(+27.0, 0.0)` | modeled | Right-side inner hole |
| `H05` | `Ø3.0` | `(0.0, -10.0)` to `(0.0, -22.7)` | partly modeled / needs verification | Source annotation is visually crowded; current model includes one lower-center `Ø3.0`, but exact Y location still needs confirmation |
| `H06` | `Ø4.0` | `(0.0, -22.2)` to `(0.0, -33.8)` | partly modeled / needs verification | Source clearly shows a lower vertical `Ø4.0`, but exact Y location should be re-read from the drawing |
| `H07` | `Ø4.0` | `(+41.7, +41.7)` approx | modeled | Upper-right outer hole |
| `H08` | `Ø4.0` | `(-44.5, +38.7)` approx | modeled, position approximate | Upper-left outer hole is not symmetric in the source |
| `H09` | `Ø4.0` | `(-48.3, -33.8)` approx | modeled, position approximate | Lower-left outer hole is not symmetric in the source |
| `H10` | `Ø4.0` | `(+41.7, -41.7)` approx | modeled | Lower-right outer hole |
| `H11` | unlabeled small hole | `(-10.0, 0.0)` approx | modeled as placeholder | Current model uses `Ø2.2`; diameter needs confirmation from source |
| `H12` | unlabeled small hole | `(+10.0, 0.0)` approx | modeled as placeholder | Current model uses `Ø2.2`; diameter needs confirmation from source |
| `H13` | unlabeled side hole | `(-66.0, 0.0)` approx | missing | Visible on left horizontal datum near rim |
| `H14` | unlabeled side hole | `(+66.0, -4.6)` approx | missing | Visible on right horizontal datum near rim |
| `H15` | unlabeled side hole | `(+66.0, -19.8)` approx | missing | Second right-side rim-adjacent hole |

## Current Assessment

The current `b1` model is improved, but the hole field is still incomplete.
The most likely missing features are the rim-adjacent side holes (`H13` to `H15`) and possibly one additional small center-adjacent hole if the crowded source annotation is interpreted differently on the next pass.

## Recommended Fix Order

1. Confirm all center-cluster holes (`H05`, `H06`, `H11`, `H12`) from the source image at higher zoom.
2. Add the rim-adjacent side holes (`H13`, `H14`, `H15`) to `scad/parts/b1_main_wheel.scad`.
3. Recheck whether the outer `Ø4.0` holes are intentionally asymmetric or whether the current layout should be shifted to the exact measured coordinates.
4. After the hole map is stable, do a separate pass on the window contours and tooth profile.
