// part_id: mar1
// name: Mars companion gear (provisional)
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1-provisional
// SPDX-License-Identifier: MIT

module mar1_tooth_ring(root_d = 14.8, tip_d = 17.2, tooth_count = 44, thickness = 1.6, tooth_w = 0.60) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 120);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2, tooth_w, thickness], center = false);
        }
    }
}

module part_mar1(
    root_d = 14.8,
    tip_d = 17.2,
    tooth_count = 44,
    thickness = 1.6,
    bore_d = 5.0
) {
    difference() {
        mar1_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 48);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_mar1();
}
