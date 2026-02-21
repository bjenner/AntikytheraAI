// part_id: sat6
// name: SAT6 axle for date pointer drive
// source_drawing_ids: DRW-056
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_sat6(axle_d = 3, axle_h = 24, tip_chamfer = 0.5) {
    difference() {
        cylinder(d = axle_d, h = axle_h, center = false);
        translate([0, 0, axle_h - tip_chamfer])
            cylinder(d1 = axle_d + 0.2, d2 = axle_d - 0.6, h = tip_chamfer + 0.1, center = false);
    }
}

