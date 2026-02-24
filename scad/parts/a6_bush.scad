// part_id: a6
// name: A6 bush
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a6(od = 12, id = 8, h = 17) {
    difference() {
        union() {
            cylinder(d = od, h = h, center = false);
            cylinder(d = od + 1.2, h = 2.0, center = false);
        }
        translate([0, 0, -0.1]) cylinder(d = id, h = h + 0.2, center = false);
        translate([0, od / 2 - 0.6, 3]) cube([2.8, 1.2, h - 5], center = true);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a6();
}
