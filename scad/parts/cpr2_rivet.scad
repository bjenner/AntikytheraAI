// part_id: cp-r2
// name: Rivet 3D x 2.6L
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cpr2() {
    union() {
        cylinder(d = 3.0, h = 2.6, center = false, $fn = 42);
        translate([0, 0, 2.6]) cylinder(d = 4.5, h = 1.0, center = false, $fn = 56);
        translate([0, 0, 3.6]) cylinder(d = 4.5, h = 1.0, center = false, $fn = 56);
    }
}
