// part_id: cp-r5
// name: Rivet 3D x 4L
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cpr5() {
    union() {
        cylinder(d = 3.0, h = 4.0, center = false, $fn = 42);
        translate([0, 0, 4.0]) cylinder(d = 6.0, h = 1.0, center = false, $fn = 60);
        translate([0, 0, 5.0]) cylinder(d = 4.8, h = 1.0, center = false, $fn = 56);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpr5();
}
