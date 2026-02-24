// part_id: fp6
// name: Front plate support post (long)
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_fp6(
    shaft_d = 4.8,
    shaft_h = 57.6,
    head_d = 10.0,
    head_h = 2.4,
    foot_d = 5.0,
    foot_h = 2.0
) {
    union() {
        cylinder(d = foot_d, h = foot_h, center = false, $fn = 50);
        translate([0, 0, foot_h]) cylinder(d = shaft_d, h = shaft_h, center = false, $fn = 64);
        translate([0, 0, foot_h + shaft_h]) cylinder(d = head_d, h = head_h, center = false, $fn = 72);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_fp6();
}
