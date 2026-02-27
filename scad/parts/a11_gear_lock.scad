// part_id: a11
// name: A11 gear lock (b1 Gear Lock)
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT
//
// Lock ring that secures b1 on the central axle.
// Geometry is approximate – no dedicated detail drawing available.

module part_a11(od = 18.0, id = 9.0, th = 1.5, gap_w = 2.0) {
    difference() {
        cylinder(d = od, h = th, center = false, $fn = 72);
        translate([0, 0, -0.1]) cylinder(d = id, h = th + 0.2, center = false, $fn = 60);
        // Split gap (c-clip style).
        translate([0, -gap_w / 2, -0.1]) cube([od / 2 + 1, gap_w, th + 0.2], center = false);
    }
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_a11();
}
