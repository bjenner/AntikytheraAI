// part_id: b9
// name: B9 pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b9(pin_d = 2.0, pin_h = 3.5) {
    cylinder(d = pin_d, h = pin_h, center = false, $fn = 30);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b9();
}
