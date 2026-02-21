// part_id: spp17
// name: Date pointer base for superior plate stage
// source_drawing_ids: DRW-056;DRW-008
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_spp17(base_d = 14, base_h = 2.5, boss_d = 7, boss_h = 2, bore_d = 3) {
    difference() {
        union() {
            cylinder(d = base_d, h = base_h, center = false);
            cylinder(d = boss_d, h = base_h + boss_h, center = false);
        }
        translate([0, 0, -0.1]) cylinder(d = bore_d, h = base_h + boss_h + 0.2, center = false);
    }
}

