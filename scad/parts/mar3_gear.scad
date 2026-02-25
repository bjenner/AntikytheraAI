// part_id: mar3
// name: Mars gear
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module mar3_tooth_ring(root_d = 38.16, tip_d = 40.66, tooth_count = 86, thickness = 1.6, tooth_w = 0.74) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 180);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2 - 0.02, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2 + 0.04, tooth_w, thickness], center = false);
        }
    }
}

module part_mar3(
    root_d = 38.16,
    tip_d = 40.66,
    tooth_count = 86,
    thickness = 1.6,
    bore_d = 4.5,
    slot_w = 1.6,
    slot_l = 13.3,
    slot_r = 4.2,
    slot_a = -78
) {
    difference() {
        mar3_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 64);
        rotate([0, 0, slot_a])
            translate([slot_r, 0, -0.05])
                hull() {
                    cylinder(d = slot_w, h = thickness + 0.1, $fn = 20);
                    translate([slot_l, 0, 0]) cylinder(d = slot_w, h = thickness + 0.1, $fn = 20);
                }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar3();
}
