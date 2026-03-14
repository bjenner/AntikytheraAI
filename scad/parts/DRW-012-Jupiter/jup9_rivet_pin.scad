// part_id: jup9
// name: Jupiter rivet pin
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup9(pin_d = 1.5, pin_h = 2.7) {
    cylinder(d = pin_d, h = pin_h, center = false, $fn = 28);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup9();
}
