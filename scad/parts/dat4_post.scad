// part_id: dat4
// name: Date pointer post (large)
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_dat4(post_d = 1.5, post_l = 17.4, head_d = 2.1, head_h = 0.8) {
    union() {
        cylinder(d = post_d, h = post_l, center = false, $fn = 24);
        translate([0, 0, post_l]) cylinder(d1 = head_d, d2 = post_d, h = head_h, center = false, $fn = 24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_dat4();
}
