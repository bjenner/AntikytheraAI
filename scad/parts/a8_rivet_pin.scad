// part_id: a8
// name: A8 rivet pin
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

module part_a8(pin_d = 3.0, pin_h = 11.0) {
    cylinder(d = pin_d, h = pin_h, center = false, $fn = 64);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a8();
}
