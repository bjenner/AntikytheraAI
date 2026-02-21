// part_id: sp2
// name: SP2 gear and axle subassembly
// source_drawing_ids: DRW-056
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_sp2(gear_od = 28, gear_thickness = 3, bore_d = 4, axle_d = 4, axle_h = 16) {
    union() {
        difference() {
            cylinder(d = gear_od, h = gear_thickness, center = false);
            translate([0, 0, -0.1]) cylinder(d = bore_d, h = gear_thickness + 0.2, center = false);
        }
        cylinder(d = axle_d, h = axle_h, center = false);
    }
}

