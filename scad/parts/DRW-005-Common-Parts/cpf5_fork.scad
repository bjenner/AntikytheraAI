// part_id: cp-f5
// name: Fork 3W 12D 12L 12T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf5_profile_2d() {
    difference() {
        union() {
            circle(r = 6.0, $fn = 96);
            translate([0, 6.8]) square([8.5, 12.0], center = true);
        }
        translate([0, 8.8]) square([2.5, 12.0], center = true);
    }
}

module part_cpf5(th = 1.0) {
    linear_extrude(height = th) cpf5_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf5();
}
