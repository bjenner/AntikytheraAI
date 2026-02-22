// part_id: a12
// name: A12 link
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a12(th = 1.5) {
    linear_extrude(height = th)
        difference() {
            hull() {
                translate([-10, 0]) circle(r = 4.6, $fn = 64);
                translate([10, 0]) circle(r = 3.2, $fn = 64);
                translate([-2, 0]) circle(r = 2.6, $fn = 64);
            }
            translate([-10, 0]) circle(d = 3.0, $fn = 48);
            translate([10, 0]) circle(d = 3.0, $fn = 48);
        }
}

