// part_id: mar11
// name: Mars pointer sleeve
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar11(
    outer_d = 12.85,
    inner_d = 11.5,
    height = 21.8,
    lip_h = 2.0,
    lip_d = 12.5
) {
    difference() {
        union() {
            cylinder(d = outer_d, h = height, center = false, $fn = 96);
            cylinder(d = lip_d, h = lip_h, center = false, $fn = 88);
        }
        translate([0, 0, -0.05]) cylinder(d = inner_d, h = height + 0.1, center = false, $fn = 88);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_mar11();
}
