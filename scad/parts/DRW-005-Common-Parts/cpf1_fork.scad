// part_id: cp-f1
// name: Fork 1.5W 3D 5L 6T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf1_profile_2d() {
    difference() {
        union() {
            circle(r = 5.0, $fn = 80);
            translate([0, 4.8]) square([4.7, 6.0], center = true);
        }
        translate([0, 6.9]) square([1.5, 6.0], center = true);
    }
}

module part_cpf1(th = 1.0) {
    linear_extrude(height = th) cpf1_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf1();
}
