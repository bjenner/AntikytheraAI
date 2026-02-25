// part_id: mar4
// name: Mars gear with slotted window
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module mar4_tooth_ring(root_d = 37.0, tip_d = 39.16, tooth_count = 88, thickness = 1.0, tooth_w = 0.70) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 180);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2 - 0.02, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2 + 0.04, tooth_w, thickness], center = false);
        }
    }
}

module part_mar4(
    root_d = 37.0,
    tip_d = 39.16,
    tooth_count = 88,
    thickness = 1.0,
    bore_d = 17.5,
    rivet_d = 1.5,
    rivet_r = 14.0,
    cut_d = 10.0,
    cut_r = 13.0,
    cut_a = -90
) {
    difference() {
        mar4_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 96);
        translate([rivet_r * cos(-80), rivet_r * sin(-80), -0.05]) cylinder(d = rivet_d, h = thickness + 0.1, $fn = 22);
        rotate([0, 0, cut_a]) translate([cut_r, 0, -0.05])
            hull() {
                cylinder(d = cut_d, h = thickness + 0.1, $fn = 56);
                translate([5.5, 0, 0]) cylinder(d = 4.4, h = thickness + 0.1, $fn = 44);
            }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar4();
}
