// DRW-002 reusable B7 subassembly (b7, b8 x2, b9 x1).
// Centered on the b7 axis at origin for reuse in sheet scenes.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b7_hub.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b8_rivet_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b9_pin.scad>

module drw002_b7_subassembly(
    b8_offset = 4.0,
    b8_insert_h = 6.0,
    b9_offset = 5.9,
    core_h = 13.9,
    b9_insert_h = 3.6
) {
    color([0.45, 0.30, 0.18])
        part_b7();

    color([0.20, 0.20, 0.20]) {
        for (sx = [-1, 1])
            translate([sx * b8_offset, 0, 0])
                part_b8(pin_h = b8_insert_h);

        translate([-b9_offset, 0, core_h - b9_insert_h])
            part_b9(pin_h = b9_insert_h);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw002_b7_subassembly();
}
