// part_id: jup3
// name: Jupiter intermediate gear
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module jup3_tooth_ring(root_d = 22.56, tip_d = 25.06, tooth_count = 52, thickness = 1.6, tooth_w = 0.72) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 140);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2, tooth_w, thickness], center = false);
        }
    }
}

module part_jup3(
    root_d = 22.56,
    tip_d = 25.06,
    tooth_count = 52,
    thickness = 1.6,
    bore_d = 6.5,
    slot_w = 1.5,
    slot_l = 3.3,
    slot_r = 5.9,
    slot_a = -74
) {
    difference() {
        jup3_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 64);
        rotate([0, 0, slot_a]) translate([slot_r, 0, -0.05]) hull() {
            cylinder(d = slot_w, h = thickness + 0.1, $fn = 24);
            translate([slot_l, 0, 0]) cylinder(d = slot_w, h = thickness + 0.1, $fn = 24);
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup3();
}
