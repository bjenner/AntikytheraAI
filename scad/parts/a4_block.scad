// part_id: a4
// name: A4 block
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a4(w = 12, d = 8, h = 24, bore_d = 8) {
    difference() {
        translate([-w / 2, -d / 2, 0]) cube([w, d, h], center = false);
        translate([0, 0, h * 0.55]) rotate([90, 0, 0]) cylinder(d = bore_d, h = d + 0.2, center = true);
        for (x = [-3, 3]) translate([x, d / 2 - 1.2, h - 2.5]) cylinder(d = 2.0, h = 2.6, center = false);
    }
}

