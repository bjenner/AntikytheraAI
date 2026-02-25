// part_id: jup2
// name: Jupiter driven gear
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module jup2_tooth_ring(root_d = 20.88, tip_d = 23.40, tooth_count = 56, thickness = 1.0, tooth_w = 0.62) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 140);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2, tooth_w, thickness], center = false);
        }
    }
}

module part_jup2(
    root_d = 20.88,
    tip_d = 23.40,
    tooth_count = 56,
    thickness = 1.0,
    bore_d = 7.0,
    pin_d = 1.0,
    pin_r = 2.9,
    pin_a = -62
) {
    difference() {
        jup2_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 64);
        translate([pin_r * cos(pin_a), pin_r * sin(pin_a), -0.05])
            cylinder(d = pin_d, h = thickness + 0.1, $fn = 24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup2();
}
