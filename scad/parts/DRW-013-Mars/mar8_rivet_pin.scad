// part_id: mar8
// name: Mars rivet pin
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar8(pin_d = 1.5, pin_h = 2.7) {
    cylinder(d = pin_d, h = pin_h, center = false, $fn = 28);
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar8();
}
