// DRW-002 b9 subassembly recreation (b11+b12+b13+b14+b15+b16).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b11_carrier_block.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b12_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b13_roller.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b14_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b15_wire_link.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b16_rivet.scad>

module drw002_b9_subassembly() {
    block_center = [8.0, 12.0, 1.5];

    // Core block.
    color([0.40, 0.29, 0.19]) translate(block_center) part_b11();

    // Two b12 guide pins through the large face holes.
    color([0.45, 0.34, 0.23]) {
        translate([4.0, 4.0, 4.5]) part_b12();
        translate([12.0, 4.0, 4.5]) part_b12();
    }

    // Roller, bush, and rivet share the window center axis.
    color([0.70, 0.70, 0.70])
        translate(block_center)
            rotate([0, 0, 90])
                part_b13();

    color([0.85, 0.85, 0.85])
        translate(block_center)
            rotate([90, 0, 0])
                part_b14();

    color([0.25, 0.25, 0.25])
        translate(block_center)
            rotate([90, 0, 0])
                part_b16();

    // Wire link seated in the long groove on the block face.
    color([0.72, 0.72, 0.72])
        translate([8.0, 12.0, 1.7])
            rotate([0, 0, 90])
                part_b15();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_b9_subassembly();
}
