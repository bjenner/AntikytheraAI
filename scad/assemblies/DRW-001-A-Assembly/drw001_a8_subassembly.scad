// DRW-001 reusable A8 subassembly (a8, a9, a10).
// Centered on the main axle axis at origin for reuse in sheet scenes.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-001-A-Assembly/a8_rivet_pin.scad>
use <../../parts/DRW-001-A-Assembly/a9_axle.scad>
use <../../parts/DRW-001-A-Assembly/a10_disc.scad>

module drw001_a8_subassembly(
    a10_th = 3.0,
    // A8 pin cross-hole center measured from the axle bottom face.
    a8_hole_z = 43.8
) {
    a9_total_h = 32.0 + 11.4 + 3.0;

    // Main disc (A10), centered on Z=0 plane for easy placement.
    color([0.45, 0.30, 0.18])
        part_a10(th = a10_th);

    // Axle (A9) passes its lower core through the disc thickness so the
    // larger shaft starts flush at the top face of A10.
    color([0.52, 0.43, 0.34])
        translate([0, 0, a9_total_h / 2 - a10_th / 2])
        rotate([0, 0, 90])
            part_a9();

    // One A8 pin inserted through the top hole of A9.
    color([0.25, 0.25, 0.25])
        translate([0, 0, a8_hole_z - a10_th / 2])
            rotate([90, 0, 0])
                part_a8();
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw001_a8_subassembly();
}
