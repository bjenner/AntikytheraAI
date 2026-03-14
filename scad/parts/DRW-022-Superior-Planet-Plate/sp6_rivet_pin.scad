// part_id: sp6
// name: SP6 rivet pin
// source_drawing_ids: DRW-022
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_sp6(pin_d = 3, pin_h = 5) {
    cylinder(d = pin_d, h = pin_h, center = false);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_sp6();
}
