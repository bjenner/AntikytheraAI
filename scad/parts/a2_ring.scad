// part_id: a2
// name: A2 ring
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a2(od = 14, id = 8, th = 2) {
    difference() {
        cylinder(d = od, h = th, center = false);
        translate([0, 0, -0.1]) cylinder(d = id, h = th + 0.2, center = false);
    }
}

