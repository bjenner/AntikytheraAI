// part_id: cp-f3
// name: Fork 2W 4D 8L 7T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf3_profile_2d() {
    difference() {
        union() {
            circle(r = 5.0, $fn = 80);
            translate([0, 5.3]) square([5.2, 8.0], center = true);
        }
        translate([0, 9.3]) square([2.0, 4.0], center = true);
    }
}

module part_cpf3(th = 1.0) {
    linear_extrude(height = th) cpf3_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf3();
}
