// part_id: fp5
// name: Front plate rivet for Egyptian dial
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_fp5(
    shank_d = 2.0,
    shank_h = 4.0,
    collar_d = 3.5,
    collar_h = 1.0,
    head_d = 5.0,
    head_h = 1.6
) {
    union() {
        cylinder(d = shank_d, h = shank_h, center = false, $fn = 36);
        translate([0, 0, shank_h]) cylinder(d = collar_d, h = collar_h, center = false, $fn = 42);
        translate([0, 0, shank_h + collar_h]) cylinder(d1 = head_d, d2 = head_d * 0.88, h = head_h, center = false, $fn = 52);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_fp5();
}
