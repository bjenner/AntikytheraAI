// part_id: a2
// name: A2 ring
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

module part_a2(od = 16, id = 10, th = 0.7) {
    difference() {
        cylinder(d = od, h = th, center = false);
        translate([0, 0, -0.1]) cylinder(d = id, h = th + 0.2, center = false);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a2();
}
