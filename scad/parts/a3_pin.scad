// part_id: a3
// name: A3 pin
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a3(d = 8, h = 15) {
    union() {
        cylinder(d = d, h = h, center = false);
        translate([0, 0, h]) cylinder(d = d * 0.85, h = 1.6, center = false);
        translate([0, 0, 1.6]) difference() {
            cylinder(d = d + 0.8, h = 1.0, center = false);
            cylinder(d = d - 1.0, h = 1.2, center = false);
        }
    }
}

