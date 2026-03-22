// part_id: c3
// name: C3 pin
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part C3: simple cylindrical pin used twice in the c gear train.
//
// Local origin convention:
// - XY origin is the pin axis.
// - Z origin is the part midplane.

module part_c3(pin_d = 1.5, pin_h = 4.0) {
    cylinder(d = pin_d, h = pin_h, center = true, $fn = 30);
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_c3();
}
