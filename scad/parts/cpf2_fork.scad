// part_id: cp-f2
// name: Fork 2W 4D 6L 7T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf2_profile_2d() {
    difference() {
        union() {
            circle(r = 5.0, $fn = 80);
            translate([0, 4.8]) square([5.2, 7.0], center = true);
        }
        translate([0, 6.7]) square([2.0, 7.0], center = true);
    }
}

module part_cpf2(th = 1.0) {
    linear_extrude(height = th) cpf2_profile_2d();
}
