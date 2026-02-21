// Part A1: starter gear-like disc with center bore and spoke cutouts.
// SPDX-License-Identifier: MIT

module part_a1(body_d = 64, thickness = 4, bore_d = 8, spoke_count = 6) {
    difference() {
        cylinder(d = body_d, h = thickness, center = false);
        translate([0, 0, -0.1]) {
            cylinder(d = bore_d, h = thickness + 0.2, center = false);
        }

        // Spoke windows are placeholders for later historic geometry.
        for (i = [0 : spoke_count - 1]) {
            rotate([0, 0, 360 / spoke_count * i]) {
                translate([body_d * 0.22, 0, -0.1]) {
                    cube([body_d * 0.38, 3.2, thickness + 0.2], center = true);
                }
            }
        }
    }
}
