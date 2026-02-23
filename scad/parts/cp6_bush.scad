// part_id: cp6
// name: Small bush
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cp6(od = 3.5, id = 1.5, th = 2.0, lip_d = 5.0, lip_th = 0.8) {
    difference() {
        union() {
            cylinder(d = od, h = th, center = false, $fn = 48);
            cylinder(d = lip_d, h = lip_th, center = false, $fn = 56);
        }
        translate([0, 0, -0.1]) cylinder(d = id, h = th + 0.2, center = false, $fn = 28);
    }
}
