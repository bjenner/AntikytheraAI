// part_id: cp-r1
// name: Rivet 2D x 2L
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cpr1() {
    union() {
        cylinder(d = 2.0, h = 2.0, center = false, $fn = 40);
        translate([0, 0, 2.0]) cylinder(d = 5.0, h = 1.0, center = false, $fn = 56);
        translate([0, 0, 3.0]) cylinder(d = 4.2, h = 1.0, center = false, $fn = 48);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpr1();
}
