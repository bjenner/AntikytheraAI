// part_id: jup5
// name: Jupiter pointer drive gear
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module jup5_tooth_ring(root_d = 28.86, tip_d = 30.94, tooth_count = 64, thickness = 1.6, tooth_w = 0.72) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 140);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2, tooth_w, thickness], center = false);
        }
    }
}

module part_jup5(
    root_d = 28.86,
    tip_d = 30.94,
    tooth_count = 64,
    thickness = 1.6,
    bore_d = 14.0
) {
    difference() {
        jup5_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, center = false, $fn = 72);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup5();
}
