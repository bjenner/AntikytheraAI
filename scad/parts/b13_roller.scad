// part_id: b13
// name: B13 roller/stub axle
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b13(roller_d = 5.0, roller_len = 5.0, pin_d = 1.5, pin_len = 1.8) {
    union() {
        rotate([0, 90, 0]) cylinder(d = roller_d, h = roller_len, center = false);
        translate([roller_len, 0, 0]) rotate([0, 90, 0]) cylinder(d = pin_d, h = pin_len, center = false);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b13();
}
