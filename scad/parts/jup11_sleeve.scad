// part_id: jup11
// name: Jupiter pointer sleeve
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup11(
    outer_d = 14.3,
    inner_d = 13.0,
    height = 17.6,
    lip_h = 2.0,
    lip_d = 14.0
) {
    difference() {
        union() {
            cylinder(d = outer_d, h = height, center = false, $fn = 96);
            translate([0, 0, 0]) cylinder(d = lip_d, h = lip_h, center = false, $fn = 88);
        }
        translate([0, 0, -0.05]) cylinder(d = inner_d, h = height + 0.1, center = false, $fn = 88);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup11();
}
