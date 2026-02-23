// part_id: cp-f6
// name: Fork 3W 10L 6D 10T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf6_profile_2d() {
    difference() {
        union() {
            circle(r = 5.0, $fn = 88);
            translate([0, 5.8]) square([7.0, 10.0], center = true);
        }
        translate([0, 7.8]) square([3.0, 10.0], center = true);
    }
}

module part_cpf6(th = 1.0) {
    linear_extrude(height = th) cpf6_profile_2d();
}
