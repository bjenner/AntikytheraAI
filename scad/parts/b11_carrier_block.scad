// part_id: b11
// name: B11 carrier block
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b11_profile_2d(w = 16, h = 24, corner_r = 3) {
    difference() {
        hull() {
            translate([corner_r, corner_r]) circle(r = corner_r, $fn = 40);
            translate([w - corner_r, corner_r]) circle(r = corner_r, $fn = 40);
            translate([corner_r, h - corner_r]) circle(r = corner_r, $fn = 40);
            translate([w - corner_r, h - corner_r]) circle(r = corner_r, $fn = 40);
        }
        // Center window
        translate([w / 2 - 4, h / 2 - 3]) offset(r = 0.75) square([8, 6], center = false);
        // Twin top holes
        for (x = [w / 2 - 2.8, w / 2 + 2.8]) translate([x, h - 4]) circle(d = 3.0, $fn = 30);
        // Through axis hole
        translate([w / 2, h / 2]) circle(d = 3.0, $fn = 30);
    }
}

module part_b11(w = 16, h = 24, t = 12.1) {
    difference() {
        linear_extrude(height = t)
            b11_profile_2d(w = w, h = h);

        // Side shaft bore for b13.
        translate([w / 2, h / 2, t - 3.5])
            rotate([0, 90, 0])
                cylinder(d = 5.0, h = w + 0.4, center = true);
    }
}
