// part_id: cp3
// name: Pointer slip-ring rivet
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cp3(pin_d = 1.0, pin_h = 2.0, head_w = 1.0, head_h = 1.0) {
    union() {
        cylinder(d = pin_d, h = pin_h, center = false, $fn = 24);
        translate([-head_w / 2, -head_w / 2, pin_h]) cube([head_w, head_w, head_h], center = false);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cp3();
}
