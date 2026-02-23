// part_id: b2
// name: B2 gear ring
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b2_gear_2d(outer_d = 31.0, root_d = 28.8, tooth_count = 44,
                  center_d = 11.0, rivet_d = 3.0, rivet_pitch = 20.0) {
    difference() {
        union() {
            circle(d = root_d, $fn = 120);
            for (i = [0 : tooth_count - 1])
                rotate(i * 360 / tooth_count)
                    translate([outer_d / 2 - 0.45, 0])
                        square([0.9, 0.7], center = true);
        }

        circle(d = center_d, $fn = 60);
        for (a = [0, 90, 180, 270])
            rotate(a) translate([rivet_pitch / 2, 0]) circle(d = rivet_d, $fn = 28);
    }
}

module part_b2(thickness = 2.0) {
    linear_extrude(height = thickness)
        b2_gear_2d();
}
