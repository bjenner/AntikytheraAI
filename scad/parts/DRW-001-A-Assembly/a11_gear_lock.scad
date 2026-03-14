// Part A11: split lock ring / gear lock.
// SPDX-License-Identifier: MIT
//
// Lock ring that secures b1 on the central axle.
// Geometry is approximate – no dedicated detail drawing available.

module part_a11(od = 18.0, id = 9.0, th = 1.5, gap_w = 2.0) {
    difference() {
        cylinder(d = od, h = th, center = true, $fn = 72);
        cylinder(d = id, h = th + 0.2, center = true, $fn = 60);
        // Split gap (c-clip style).
        translate([0, -gap_w / 2, -th / 2 - 0.1]) cube([od / 2 + 1, gap_w, th + 0.2], center = false);
    }
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_a11();
}
