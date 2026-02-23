// part_id: cp-f4
// name: Fork 2W 8D 8L 7T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf4_profile_2d() {
    difference() {
        union() {
            circle(r = 5.0, $fn = 80);
            translate([0, 5.3]) square([5.2, 8.0], center = true);
        }
        translate([0, 7.3]) square([2.0, 8.0], center = true);
    }
}

module part_cpf4(th = 1.0) {
    linear_extrude(height = th) cpf4_profile_2d();
}
