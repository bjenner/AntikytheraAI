// part_id: sp8
// name: SP8 large gear (sp2 axle OD)
// source_drawing_ids: DRW-022
// units: mm
// revision: 0.1-drw022
// SPDX-License-Identifier: MIT
//
// Dimensions from DRW-022 sheet 6:
//   Tooth tip radius R20.48 (OD 40.96), root radius R19.09 (root_d 38.18).
//   Press-fit boss: Ø4.0 bore, Ø4.9 boss OD, 12.5 mm fitted depth onto sp2 axle.
//   Tooth ring thickness: 2.0 mm.

module sp8_tooth_ring(root_d = 38.18, tip_d = 40.96, tooth_count = 60, thickness = 2.0, tooth_w = 0.9) {
    union() {
        cylinder(d = root_d, h = thickness, center = false, $fn = 180);
        for (a = [0 : 360 / tooth_count : 360 - 360 / tooth_count]) {
            rotate([0, 0, a])
                translate([root_d / 2, -tooth_w / 2, 0])
                    cube([(tip_d - root_d) / 2, tooth_w, thickness], center = false);
        }
    }
}

module part_sp8(
    tip_d     = 40.96,
    root_d    = 38.18,
    thickness = 2.0,
    tooth_count = 60,
    boss_od   = 4.9,
    bore_d    = 4.0,
    boss_h    = 12.5
) {
    union() {
        // Tooth ring with central boss clearance cut.
        difference() {
            sp8_tooth_ring(
                root_d = root_d, tip_d = tip_d,
                tooth_count = tooth_count, thickness = thickness
            );
            translate([0, 0, -0.1]) cylinder(d = boss_od, h = thickness + 0.2, center = false, $fn = 40);
        }
        // Press-fit boss extending below gear face.
        difference() {
            cylinder(d = boss_od, h = boss_h, center = false, $fn = 40);
            translate([0, 0, -0.1]) cylinder(d = bore_d, h = boss_h + 0.2, center = false, $fn = 40);
        }
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_sp8();
}
