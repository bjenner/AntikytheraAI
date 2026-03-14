// part_id: mar15
// name: Mars pointer orb small
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar15(ball_d = 3.0, pin_d = 1.0, pin_l = 0.5) {
    union() {
        sphere(d = ball_d, $fn = 40);
        translate([0, 0, -ball_d / 2 - pin_l]) cylinder(d = pin_d, h = pin_l, $fn = 20);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar15();
}
