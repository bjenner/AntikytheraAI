// DRW-002 b9 subassembly recreation (b11+b12+b13+b14+b15+b16).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b11_carrier_block.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b12_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b13_roller.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b14_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b15_wire_link.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b16_rivet.scad>

module drw002_b9_subassembly() {
    // Core block.
    color([0.40, 0.29, 0.19]) translate([8.0, 12.0, 1.5]) part_b11();

    // Two b12 guide pins through the large face holes.
    color([0.45, 0.34, 0.23]) {
        translate([4.0, 4.0, 4.5]) part_b12();
        translate([12.0, 4.0, 4.5]) part_b12();
    }

    // b13 roller crossing the center window.
    color([0.70, 0.70, 0.70])
        translate([8.0, 12.0, 1.5])
            rotate([0, 0, 90])
                part_b13();

    // b16 rivet through the lower small face hole.
    color([0.25, 0.25, 0.25])
        translate([8.0, 21.5, 1.5])
            part_b16();

    // Wire link centered in the groove.
    color([0.72, 0.72, 0.72])
        translate([8.0, 3.5, 1.6])
            rotate([0, 0, 90])
                translate([8.5, 0, -0.45])
                    part_b15();

    // Placeholder rivet from b17 callout region used in sheet view.
    color([0.15, 0.15, 0.15])
        translate([8.0, 4.0, 0])
            cylinder(d = 1.5, h = 2.0, center = false, $fn = 24);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_b9_subassembly();
}
