// part_id: sp10
// name: SP10 sp2 axle disc (spacer)
// source_drawing_ids: DRW-022
// units: mm
// revision: 0.1-drw022
// SPDX-License-Identifier: MIT
//
// Dimensions from DRW-022 sheet 6:
//   Stepped disc: Ø9.0 outer, Ø7.0 mid step, Ø5.0 bore.
//   Total height: 2.0 mm (outer flange), boss adds ~1.0 mm.

module part_sp10(
    od      = 9.0,
    mid_d   = 7.0,
    bore_d  = 5.0,
    h_flange = 2.0,
    h_boss   = 1.0
) {
    union() {
        // Outer flange disc.
        difference() {
            cylinder(d = od, h = h_flange, center = false, $fn = 60);
            translate([0, 0, -0.1]) cylinder(d = bore_d, h = h_flange + 0.2, center = false, $fn = 40);
        }
        // Central stepped boss.
        difference() {
            cylinder(d = mid_d, h = h_flange + h_boss, center = false, $fn = 60);
            translate([0, 0, -0.1]) cylinder(d = bore_d, h = h_flange + h_boss + 0.2, center = false, $fn = 40);
        }
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_sp10();
}
