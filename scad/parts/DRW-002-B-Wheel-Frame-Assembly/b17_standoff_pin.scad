// part_id: b17
// name: B17 standoff pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module rounded_rect_2d(w = 6.0, d = 4.0, corner_r = 0.5) {
    hull() {
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([sx * (w / 2 - corner_r), sy * (d / 2 - corner_r)])
                    circle(r = corner_r, $fn = 24);
    }
}

// Axis is +Z following the drawing side view.
module part_b17(
    body_w = 5.0,
    body_d = 4.0,
    body_corner_to_corner_d = 6.0,
    body_h = 13.3,
    top_pin_d = 3.0,
    top_pin_h = 1.8,
    lower_neck_d = 3.0,
    lower_neck_h = 1.6,
    lower_pin_d = 1.5,
    lower_pin_h = 1.0,
    lower_end_d = 3.0,
    lower_end_h = 1.0
) {
    total_h = body_h + top_pin_h + lower_neck_h + lower_pin_h + lower_end_h;

    translate([0, 0, -(-lower_neck_h - lower_pin_h - lower_end_h + total_h / 2)])
        union() {
            intersection() {
                linear_extrude(height = body_h)
                    rounded_rect_2d(w = body_w, d = body_d, corner_r = 0.5);

                cylinder(d = body_corner_to_corner_d, h = body_h, center = false, $fn = 64);
            }

            translate([0, 0, body_h])
                cylinder(d = top_pin_d, h = top_pin_h, center = false, $fn = 32);

            translate([0, 0, -lower_neck_h])
                cylinder(d = lower_neck_d, h = lower_neck_h, center = false, $fn = 32);

            translate([0, 0, -lower_neck_h - lower_pin_h])
                cylinder(d = lower_pin_d, h = lower_pin_h, center = false, $fn = 24);

            translate([0, 0, -lower_neck_h - lower_pin_h - lower_end_h])
                cylinder(d = lower_end_d, h = lower_end_h, center = false, $fn = 32);
        }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b17();
}
