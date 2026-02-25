// part_id: mar10
// name: Mars center disc
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar10(
    outer_d = 22.0,
    mid_d = 17.4,
    bore_d = 3.0,
    total_h = 6.7,
    base_h = 2.0,
    top_h = 3.65,
    tab_w = 1.05,
    tab_l = 4.0,
    tab_h = 2.0
) {
    difference() {
        union() {
            cylinder(d = outer_d, h = base_h, center = false, $fn = 100);
            translate([0, 0, base_h]) cylinder(d = mid_d, h = top_h, center = false, $fn = 96);
            translate([mid_d / 2, -tab_w / 2, base_h]) cube([tab_l, tab_w, tab_h], center = false);
        }
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = total_h + 0.1, center = false, $fn = 48);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar10();
}
