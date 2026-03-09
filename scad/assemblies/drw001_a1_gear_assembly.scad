// DRW-001 reusable A1 gear assembly.
// Composes existing DRW-001 subassemblies around the global Z axis.
// SPDX-License-Identifier: MIT

use <./drw001_a1_subassembly.scad>
use <./drw001_a8_subassembly.scad>

module drw001_a1_gear_assembly(
    theta = 0,
    explode = 0,
    shaft_d = 10.0,
    shaft_h = 70.0,
    shaft_collar_d = 12.0,
    shaft_collar_h = 23.0,
    // Coaxial Z placements for the two reusable subassemblies.
    a8_z = -12.0,
    a1_z = 18.0
) {
    
    rotate([0, 0, theta]) {
        /*
        // Central coupling shaft on global Z axis.
        color([0.40, 0.30, 0.20]) {
            translate([0, 0, -shaft_h / 2]) cylinder(d = shaft_d, h = shaft_h, center = false, $fn = 96);
            translate([0, 0, -shaft_collar_h / 2]) cylinder(d = shaft_collar_d, h = shaft_collar_h, center = false, $fn = 96);
        }
        */
        // Right-side cluster from sheet composition, converted to Z-axis layout.
        translate([0, 0, a8_z - explode / 2]) drw001_a8_subassembly();

        // Left-side cluster from sheet composition, converted to Z-axis layout.
        translate([0, 0, a1_z + explode / 2+26])
            rotate([180, 0, 90])
                drw001_a1_subassembly();
        
    }
}

module drw001_a1_gear_assembly_spin(
    turns = 1,
    explode = 0
) {
    drw001_a1_gear_assembly(theta = 360 * turns * $t, explode = explode);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    if (!is_undef(A1_GEAR_SPIN) && A1_GEAR_SPIN) {
        drw001_a1_gear_assembly_spin(
            turns = !is_undef(A1_GEAR_TURNS) ? A1_GEAR_TURNS : 1,
            explode = !is_undef(A1_GEAR_EXPLODE_MM) ? A1_GEAR_EXPLODE_MM : 0
        );
    } else {
        drw001_a1_gear_assembly(
            explode = !is_undef(A1_GEAR_EXPLODE_MM) ? A1_GEAR_EXPLODE_MM : 0
        );
    }
}
