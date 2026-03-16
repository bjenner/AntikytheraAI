// part_id: b8
// name: B8 rivet pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b8(pin_d = 1.5, pin_h = 6.2) {
    cylinder(d = pin_d, h = pin_h, center = true, $fn = 30);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b8();
}
