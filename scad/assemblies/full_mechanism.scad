// First assembly template with one driven part.
// SPDX-License-Identifier: MIT

use <../parts/DRW-001-A-Assembly/a1.scad>

module full_mechanism(theta = 0, exploded_gap = 0) {
    // Base reference plate placeholder.
    color([0.70, 0.68, 0.62]) {
        translate([0, 0, -2]) {
            cube([120, 90, 2], center = true);
        }
    }

    // Driven A1 gear/disc placeholder.
    color([0.82, 0.63, 0.24]) {
        translate([0, 0, exploded_gap]) {
            rotate([0, 0, theta]) {
                part_a1();
            }
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    full_mechanism();
}
