// part_id: cp5
// name: Metonic/Saros pointer spacer
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cp5(od = 12.0, id = 3.0, th = 2.0) {
    difference() {
        cylinder(d = od, h = th, center = false, $fn = 80);
        translate([0, 0, -0.1]) cylinder(d = id, h = th + 0.2, center = false, $fn = 36);
    }
}
