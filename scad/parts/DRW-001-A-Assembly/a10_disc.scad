// Part A10: disc with keyed center cutout.
// SPDX-License-Identifier: MIT

module a10_center_profile_2d(center_hole_d = 9.0, detent_r = 1.5) {
    // Center cutout profile from drawing:
    // Ø9.0 with two offset R1.5 circles.
    union() {
        circle(d = center_hole_d, $fn = 72);
        // Slight overlap avoids zero-thickness point contact at exact tangency.
        detent_offset = center_hole_d / 2 + detent_r - 0.02;
        translate([0,  detent_offset]) circle(r = detent_r, $fn = 36);
        translate([0, -detent_offset]) circle(r = detent_r, $fn = 36);
    }
}

module part_a10(od = 111, th = 3, center_hole_d = 9, center_detent_r = 1.5) {
    difference() {
        cylinder(d = od, h = th, center = true, $fn = 160);
        translate([0, 0, -th / 2 - 0.1])
            linear_extrude(height = th + 0.2)
                a10_center_profile_2d(center_hole_d = center_hole_d, detent_r = center_detent_r);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a10();
}
