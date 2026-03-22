// part_id: c5
// name: C5 washer
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part C5: simple washer used in the c gear train.
//
// Local origin convention:
// - XY origin is the washer axis.
// - Z origin is the part midplane.

module part_c5(outer_d = 12.0, inner_d = 6.0, thickness = 0.1) {
    difference() {
        cylinder(d = outer_d, h = thickness, center = true, $fn = 96);
        cylinder(d = inner_d, h = thickness + 0.2, center = true, $fn = 64);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_c5();
}
