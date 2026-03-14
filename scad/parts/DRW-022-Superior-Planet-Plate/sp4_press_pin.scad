// part_id: sp4
// name: SP4 press pin
// source_drawing_ids: DRW-056
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_sp4(pin_d = 2.2, pin_h = 8) {
    cylinder(d = pin_d, h = pin_h, center = false);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_sp4();
}
