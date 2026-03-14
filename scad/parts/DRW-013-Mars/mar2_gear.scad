// part_id: mar2
// name: Mars transfer gear
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module mar2_tooth_ring(root_d = 20.88, tip_d = 23.40, tooth_count = 48, thickness = 1.0, tooth_w = 0.68) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 140);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2 - 0.02, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2 + 0.04, tooth_w, thickness], center = false);
        }
    }
}

module part_mar2(
    root_d = 20.88,
    tip_d = 23.40,
    tooth_count = 48,
    thickness = 1.0,
    bore_d = 5.5,
    key_d = 1.1,
    key_r = 2.3,
    key_a = 210
) {
    difference() {
        mar2_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 64);
        translate([key_r * cos(key_a), key_r * sin(key_a), -0.05]) cylinder(d = key_d, h = thickness + 0.1, $fn = 18);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar2();
}
