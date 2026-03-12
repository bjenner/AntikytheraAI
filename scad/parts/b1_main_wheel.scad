// part_id: b1
// name: B1 main wheel plate
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.4
// SPDX-License-Identifier: MIT

function b1_x_from_radius_y(radius, y) = sqrt(radius * radius - y * y);

module b1_spoke_cutout_quadrant_2d(
    inner_x = 7.5,
    inner_y = 7.5,
    ring_inner_r = 52.0,
    center_web_r = 16.0,
    corner_r = 2.8
) {
    difference() {
        offset(r = corner_r)
        offset(delta = -corner_r)
        intersection() {
            circle(r = ring_inner_r, $fn = 200);
            translate([inner_x, inner_y]) square([ring_inner_r, ring_inner_r], center = false);
        }

        // Preserve the central web as a clean R16.0 circle before refining the
        // spoke-root blend geometry in a later pass.
        circle(r = center_web_r, $fn = 120);
    }
}

module b1_spoke_cutouts_2d() {
    b1_spoke_cutout_quadrant_2d();
    mirror([1, 0]) b1_spoke_cutout_quadrant_2d();
    mirror([0, 1]) b1_spoke_cutout_quadrant_2d();
    mirror([1, 0]) mirror([0, 1]) b1_spoke_cutout_quadrant_2d();
}

module b1_wheel_2d(
    core_r = 66.0,
    center_hole_d = 11.0,
    spoke_hole_d = 3.0,
    spoke_hole_r = 10.0,
    left_hole_d = 6.0,
    left_hole_x = -26.5,
    right_hole_d = 2.5,
    right_hole_x = 27.0,
    lower_hole_d = 4.0,
    lower_hole_y = -22.7,
    upper_hole_d = 7.0,
    upper_hole_y = 29.4,
    rim_hole_d = 4.0,
    side_hole_d = 3.0,
    side_hole_r = 59.0
) {
    difference() {
        circle(r = core_r, $fn = 240);
        b1_spoke_cutouts_2d();
        circle(d = center_hole_d, $fn = 72);
        for (a = [0, 90, 180, 270])
            rotate(a) translate([spoke_hole_r, 0]) circle(d = spoke_hole_d, $fn = 32);
        translate([left_hole_x, 0]) circle(d = left_hole_d, $fn = 40);
        translate([right_hole_x, 0]) circle(d = right_hole_d, $fn = 32);
        translate([0, lower_hole_y]) circle(d = lower_hole_d, $fn = 36);
        translate([0, upper_hole_y]) circle(d = upper_hole_d, $fn = 44);
        translate([41.7, 41.7]) circle(d = rim_hole_d, $fn = 36);
        translate([-44.5, 38.7]) circle(d = rim_hole_d, $fn = 36);
        translate([-48.3, -33.8]) circle(d = rim_hole_d, $fn = 36);
        translate([41.7, -41.7]) circle(d = rim_hole_d, $fn = 36);
        // Side holes sit on an inferred R59.0 circle, so derive X from the
        // drawing's Y offsets rather than hard-coding coordinates.
        translate([b1_x_from_radius_y(side_hole_r, -4.6), -4.6]) circle(d = side_hole_d, $fn = 32);
        translate([b1_x_from_radius_y(side_hole_r, -19.8), -19.8]) circle(d = side_hole_d, $fn = 32);
        translate([-b1_x_from_radius_y(side_hole_r, 4.6), 4.6]) circle(d = side_hole_d, $fn = 32);
        translate([-b1_x_from_radius_y(side_hole_r, 19.8), 19.8]) circle(d = side_hole_d, $fn = 32);
    }
}

module part_b1(thickness = 2.0) {
    linear_extrude(height = thickness)
        b1_wheel_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b1();
}
