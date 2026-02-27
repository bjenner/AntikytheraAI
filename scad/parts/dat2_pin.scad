// part_id: dat2
// name: Date pointer press-fit pin (large)
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_dat2(pin_d = 1.5, pin_l = 12.0, tip_l = 2.2) {
    union() {
        cylinder(d = pin_d, h = pin_l - tip_l, center = false, $fn = 24);
        translate([0, 0, pin_l - tip_l])
            cylinder(d1 = pin_d, d2 = 0.35, h = tip_l, center = false, $fn = 24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_dat2();
}
