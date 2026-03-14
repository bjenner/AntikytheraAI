// Part A8: simple rivet pin.
// SPDX-License-Identifier: MIT

module part_a8(pin_d = 3.0, pin_h = 11.0) {
    cylinder(d = pin_d, h = pin_h, center = true, $fn = 64);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a8();
}
