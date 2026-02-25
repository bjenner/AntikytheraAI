// part_id: jup14
// name: Jupiter orb large
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup14(ball_d = 5.0, pin_d = 1.5, pin_l = 0.8) {
    union() {
        sphere(d = ball_d, $fn = 48);
        translate([0, 0, -ball_d / 2 - pin_l]) cylinder(d = pin_d, h = pin_l, $fn = 24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup14();
}
