// part_id: d5
// name: D5 washer
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part D5: simple thin washer shown on DRW-004 sheet 14.
//
// Local origin convention:
// - XY origin is the washer axis.
// - Z origin is the part midplane.

module part_d5(
    outer_d = 9.0,
    inner_d = 6.0,
    thickness = 0.1
) {
    difference() {
        cylinder(d = outer_d, h = thickness, center = true, $fn = 96);
        cylinder(d = inner_d, h = thickness + 0.2, center = true, $fn = 64);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_d5();
}
