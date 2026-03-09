// DRW-001 reusable A8 subassembly (a8, a9, a10, a11).
// Centered on the main axle axis at origin for reuse in sheet scenes.
// SPDX-License-Identifier: MIT

use <../parts/a8_rivet_pin.scad>
use <../parts/a9_axle.scad>
use <../parts/a10_disc.scad>
use <../parts/a11_gear_lock.scad>

module drw001_a8_subassembly(
    a10_th = 3.0,
    a11_z = 34.0,
    // A8 pin inserted through A9 top cross-hole.
    a8_hole_z = 43.8
) {
    // Main disc (A10), centered on Z=0 plane for easy placement.
    color([0.45, 0.30, 0.18])
        translate([0, 0, 0])
            part_a10(th = a10_th);

    // Axle (A9) through/above disc.
    color([0.52, 0.43, 0.34])
        rotate([0, 0, 90])
            part_a9();

    // Lock ring (A11) on axle.
    color([0.25, 0.25, 0.25])
        translate([0, 0, a11_z])
            part_a11();

    // One A8 pin inserted into the top hole of A9.
    color([0.25, 0.25, 0.25])
        translate([0, 11/2, a8_hole_z])
            rotate([90, 0, 0])
                part_a8();
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw001_a8_subassembly();
}
