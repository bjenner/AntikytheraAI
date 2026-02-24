// part_id: dat5
// name: Date pointer ball tip (small)
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_dat5(ball_d = 3.0, pin_d = 1.0, pin_l = 1.0) {
    union() {
        sphere(d = ball_d, $fn = 36);
        translate([0, 0, -ball_d / 2 - pin_l])
            cylinder(d = pin_d, h = pin_l, center = false, $fn = 24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_dat5();
}
