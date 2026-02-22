// part_id: b5
// name: B5 fitted post
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

// Main body axis is +Z.
module part_b5(body_w = 4.0, body_d = 4.0, body_h = 23.6,
               top_stub_d = 4.0, top_stub_h = 2.0,
               bottom_stub_d = 3.9, bottom_stub_h = 1.2,
               collar_d = 4.2, collar_h = 1.0,
               side_flat = 1.75) {
    difference() {
        union() {
            // Main square body.
            translate([-body_w / 2, -body_d / 2, bottom_stub_h])
                cube([body_w, body_d, body_h], center = false);

            // Bottom fitted stem + collar.
            cylinder(d = bottom_stub_d, h = bottom_stub_h, center = false, $fn = 42);
            translate([0, 0, bottom_stub_h])
                cylinder(d = collar_d, h = collar_h, center = false, $fn = 42);

            // Top rounded stem.
            translate([0, 0, bottom_stub_h + body_h])
                cylinder(d = top_stub_d, h = top_stub_h, center = false, $fn = 42);
        }

        // Opposed flats on top stem (keyed profile shown in section views).
        for (sx = [-1, 1])
            translate([sx * (top_stub_d / 2 - side_flat / 2), -3, bottom_stub_h + body_h + 0.25])
                cube([side_flat, 6, top_stub_h - 0.5], center = true);
    }
}
