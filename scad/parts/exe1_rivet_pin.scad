// part_id: exe1
// name: Exeligmos rivet pin for cp2 subassembly
// source_drawing_ids: DRW-009
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_exe1(
    shaft_d = 1.5,
    shaft_h = 10.0,
    head_d = 2.0,
    head_h = 1.6
) {
    union() {
        cylinder(d = shaft_d, h = shaft_h, center = false, $fn = 28);
        translate([0, 0, -head_h]) cylinder(d = head_d, h = head_h, center = false, $fn = 32);
    }
}
