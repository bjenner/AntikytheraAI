// part_id: b16
// name: B16 rivet pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b16(pin_d = 2.0, pin_h = 3.0, head_d = 2.8, head_h = 1.0, tip_angle = 10) {
    union() {
        cylinder(d = pin_d, h = pin_h, center = false, $fn = 30);
        cylinder(d = head_d, h = head_h, center = false, $fn = 30);
        translate([0, 0, pin_h]) cylinder(d1 = pin_d, d2 = 0.8, h = 0.8, center = false, $fn = 24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b16();
}
