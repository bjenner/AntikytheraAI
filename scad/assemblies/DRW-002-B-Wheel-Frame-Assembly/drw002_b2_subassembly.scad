// DRW-002 reusable B2 subassembly (b2, b4 x4).
// Centered on the gear axis at origin for reuse in sheet scenes.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b2_gear_ring.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b4_rivet_pin.scad>

module drw002_b2_subassembly(
    rivet_pcd_r = 10.0,
    rivet_z = 1.7
) {
    color([0.45, 0.30, 0.18])
        part_b2();

    color([0.25, 0.25, 0.25])
        for (a = [0, 90, 180, 270])
            rotate([0, 0, a])
                translate([rivet_pcd_r, 0, rivet_z])
                    part_b4();
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw002_b2_subassembly();
}
