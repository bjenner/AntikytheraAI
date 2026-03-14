// part_id: jup4
// name: Jupiter gear
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module jup4_tooth_ring(root_d = 28.86, tip_d = 30.94, tooth_count = 64, thickness = 1.0, tooth_w = 0.68) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 140);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2, tooth_w, thickness], center = false);
        }
    }
}

module part_jup4(
    root_d = 28.86,
    tip_d = 30.94,
    tooth_count = 64,
    thickness = 1.0,
    bore_d = 10.0,
    aux_hole_d = 3.5,
    rivet_hole_d = 1.5,
    aux_hole_r = 7.2,
    rivet_hole_r = 8.2
) {
    difference() {
        jup4_tooth_ring(root_d = root_d, tip_d = tip_d, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 64);
        translate([aux_hole_r, 0, -0.05]) cylinder(d = aux_hole_d, h = thickness + 0.1, $fn = 30);
        translate([rivet_hole_r * cos(-102), rivet_hole_r * sin(-102), -0.05])
            cylinder(d = rivet_hole_d, h = thickness + 0.1, $fn = 20);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup4();
}
