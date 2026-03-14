// Part A2: thin spacer ring.
// SPDX-License-Identifier: MIT
//
// Local origin convention:
// - XY origin is the ring axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

module part_a2(od = 16, id = 10, th = 0.7) {
    difference() {
        cylinder(d = od, h = th, center = true);
        cylinder(d = id, h = th + 0.2, center = true);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a2();
}
