// part_id: sp1
// name: SP1 superior gear
// source_drawing_ids: DRW-022;DRW-056
// units: mm
// revision: 0.3-drw022
// SPDX-License-Identifier: MIT

module sp1_tooth_ring(root_d = 36.6, tip_d = 39.2, tooth_count = 60, thickness = 2.0, tooth_w = 0.9) {
    union() {
        cylinder(d = root_d, h = thickness, center = false);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2, 0, 0])
                    translate([0, -tooth_w / 2, 0])
                        cube([(tip_d - root_d) / 2, tooth_w, thickness], center = false);
        }
    }
}

module part_sp1(
    od = 39.2,
    thickness = 2.0,
    root_d = 36.6,
    tooth_count = 60,
    bore_d = 20.2,
    bolt_d = 3.0,
    bolt_r = 13.0
) {
    difference() {
        sp1_tooth_ring(root_d = root_d, tip_d = od, tooth_count = tooth_count, thickness = thickness);
        translate([0, 0, -0.1]) cylinder(d = bore_d, h = thickness + 0.2, center = false);
        for (a = [0, 90, 180, 270]) {
            rotate([0, 0, a]) translate([bolt_r, 0, -0.1])
                cylinder(d = bolt_d, h = thickness + 0.2, center = false);
        }
    }
}
