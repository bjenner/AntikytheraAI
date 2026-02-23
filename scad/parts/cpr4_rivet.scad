// part_id: cp-r4
// name: Rivet 3D x 3L
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cpr4() {
    union() {
        cylinder(d = 3.0, h = 3.0, center = false, $fn = 42);
        translate([0, 0, 3.0]) cylinder(d = 6.0, h = 1.0, center = false, $fn = 60);
        translate([0, 0, 4.0]) cylinder(d = 4.8, h = 1.0, center = false, $fn = 56);
    }
}
