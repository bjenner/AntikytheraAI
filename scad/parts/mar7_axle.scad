// part_id: mar7
// name: Mars stepped axle
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar7(
    d1 = 3.0,
    d2 = 3.9,
    d3 = 3.0,
    h1 = 1.1,
    h2 = 2.0,
    h3 = 2.0,
    h4 = 3.0,
    total_h = 8.1
) {
    union() {
        cylinder(d = d1, h = h1, center = false, $fn = 40);
        translate([0, 0, h1]) cylinder(d = d2, h = h2, center = false, $fn = 44);
        translate([0, 0, h1 + h2]) cylinder(d = d3, h = h3, center = false, $fn = 40);
        translate([0, 0, h1 + h2 + h3]) cylinder(d = d2, h = h4, center = false, $fn = 44);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar7();
}
