// part_id: b4
// name: B4 rivet pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

module part_b4(pin_d = 3.0, pin_h = 4.0) {
    cylinder(d = pin_d, h = pin_h, center = true, $fn = 30);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b4();
}
