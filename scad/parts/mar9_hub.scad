// part_id: mar9
// name: Mars stepped hub
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar9(
    base_d = 4.4,
    mid_d = 4.0,
    top_d = 3.6,
    total_h = 6.7,
    base_h = 2.5,
    mid_h = 1.7,
    top_h = 2.5,
    bore_d = 3.0
) {
    difference() {
        union() {
            cylinder(d = base_d, h = base_h, center = false, $fn = 52);
            translate([0, 0, base_h]) cylinder(d = mid_d, h = mid_h, center = false, $fn = 52);
            translate([0, 0, base_h + mid_h]) cylinder(d = top_d, h = top_h, center = false, $fn = 52);
        }
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = total_h + 0.1, center = false, $fn = 42);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar9();
}
