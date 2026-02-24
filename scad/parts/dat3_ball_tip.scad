// part_id: dat3
// name: Date pointer ball tip (large)
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_dat3(ball_d = 5.0, pin_d = 1.5, pin_l = 1.5) {
    union() {
        sphere(d = ball_d, $fn = 42);
        translate([0, 0, -ball_d / 2 - pin_l])
            cylinder(d = pin_d, h = pin_l, center = false, $fn = 28);
    }
}
