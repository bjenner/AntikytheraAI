// Part A5: thin ring spacer.
// SPDX-License-Identifier: MIT

module part_a5(od = 12, id = 8, th = .1) {
    difference() {
        cylinder(d = od, h = th, center = true);
        cylinder(d = id, h = th + 0.2, center = true);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a5();
}
