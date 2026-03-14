// Part A9: stepped axle with upper cross-hole.
// SPDX-License-Identifier: MIT
//
// Local origin convention:
// - XY origin is the axle axis.
// - Z origin is the overall part midplane.
// - Assembly placement and animation should be applied outside this file.

module part_a9(
    body_d = 14.0,
    body_h = 32.0,
    upper_d = 8.8,
    upper_h = 11.4,
    bottom_core_d = 9.0,
    bottom_pin_d = 3.0,
    bottom_pin_h = 3.0,
    top_hole_d = 2.0,
    // Drawing indicates centerline 8.8 mm above body top.
    top_hole_from_body_top = 8.8
) {
    total_h = bottom_pin_h + body_h + upper_h;

    // Z reference:
    // [0..bottom_pin_h] bottom pins
    // [bottom_pin_h..bottom_pin_h+body_h] main body
    // [body top..body top+upper_h] upper stem
    z0 = -total_h / 2;
    z_body = z0 + bottom_pin_h;
    z_body_top = z_body + body_h;
    z_top = z_body_top + upper_h;
    z_hole = z_body_top + top_hole_from_body_top;

    difference() {
        union() {
            // Bottom core section (Ø9.0 x 3.0) below main Ø14 body.
            translate([0, 0, z0])
                cylinder(d = bottom_core_d, h = bottom_pin_h, center = false, $fn = 96);

            // Main shaft body.
            translate([0, 0, z_body]) cylinder(d = body_d, h = body_h, center = false, $fn = 96);

            // Upper stem.
            translate([0, 0, z_body_top]) cylinder(d = upper_d, h = upper_h, center = false, $fn = 96);

            // Two bottom offset pins (Ø3.0) to match bottom view callout.
            // Centers offset from origin by Ø9/2 so they intersect the Ø9 core.
            for (sx = [-1, 1])
                translate([sx * (bottom_core_d / 2), 0, z0])
                    cylinder(d = bottom_pin_d, h = bottom_pin_h, center = false, $fn = 48);
        }

        // Ø2.0 transverse hole through upper stem.
        // Oriented to match drawing top view (horizontal in XY view).
        translate([0, 0, z_hole])
            rotate([0, 90, 0])
                cylinder(d = top_hole_d, h = upper_d + 2.0, center = true, $fn = 48);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a9();
}
