// part_id: b18
// name: B18 link plate
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b18_profile_2d(length = 124, height = 24, corner_r = 4.5,
                      center_cut_r = 23,
                      h_d = 3.0,
                      center_hole_d = 10.0) {
    center_hole_x = 62.0;
    center_hole_y = 12.0;
    center_cut_x = center_hole_x - 6.0;
    center_cut_y = center_hole_y - 29.0;
    edge_hole_x_left = 3.5;
    edge_hole_x_right = length - 3.5;
    edge_hole_y_offset = 7.8;
    mid_hole_dx_upper = 35.6;
    mid_hole_dx_lower = 26.2;
    mid_hole_dy = 5.4;
    left_inner_hole_dx = 49.4;
    left_inner_hole_dy = 7.8;

    difference() {
        // Rounded rectangle envelope.
        hull() {
            translate([corner_r, corner_r]) circle(r = corner_r, $fn = 40);
            translate([length - corner_r, corner_r]) circle(r = corner_r, $fn = 40);
            translate([corner_r, height - corner_r]) circle(r = corner_r, $fn = 40);
            translate([length - corner_r, height - corner_r]) circle(r = corner_r, $fn = 40);
        }

        // Central underside clearance arc.
        translate([center_cut_x, center_cut_y])
            circle(r = center_cut_r, $fn = 80);

        // Main center hole.
        translate([center_hole_x, center_hole_y])
            circle(d = center_hole_d, $fn = 40);

        // Hole pattern (sheet-10 approximation, intended for visual and assembly use).
        holes = [
            [edge_hole_x_left, center_hole_y - edge_hole_y_offset],
            [edge_hole_x_left, center_hole_y + edge_hole_y_offset],
            [center_hole_x - mid_hole_dx_upper, center_hole_y + mid_hole_dy],
            [center_hole_x - mid_hole_dx_lower, center_hole_y - mid_hole_dy],
            [center_hole_x - left_inner_hole_dx, center_hole_y - left_inner_hole_dy],
            [edge_hole_x_right, center_hole_y - edge_hole_y_offset],
            [edge_hole_x_right, center_hole_y + edge_hole_y_offset]
        ];

        for (p = holes)
            translate(p) circle(d = h_d, $fn = 30);
    }
}

module part_b18(length = 124, height = 24, thickness = 1.6) {
    linear_extrude(height = thickness)
        b18_profile_2d(length = length, height = height);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b18();
}
