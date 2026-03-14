// DRW-001 reusable A1-side gear assembly.
// Composed of the A1 subassembly, the A6 tube, and the A8 subassembly.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-001-A-Assembly/a6_bush.scad>
use <./drw001_a1_subassembly.scad>
use <./drw001_a8_subassembly.scad>

module drw001_a1_gear_assembly(
    theta = 0,
    explode = 0,
    a6_h = 17.0,
    a1_z_max = 15.6,
    a8_disc_th = 3.0,
    a8_axle_below_disc = 1.5,
    a1_insert_into_a6 = 4.2 +38.3,
    a8_insert_into_a6 = 5.0,
    a6_insert_into_disc = 0.0 +53.5,
    a6_roll_deg = 0
) {
    // The assembly axis is X:
    // left = A1 subassembly, middle = A6 tube, right = A8 subassembly.
    // A8 subassembly uses local -Z as the axle direction away from the disc after
    // the chosen rotation below. Place the axle slightly inside the right end of A6.
    a8_disc_center_x = 0;
    a8_disc_left_face_x = a8_disc_center_x - a8_disc_th / 2;

    // Seat the A6 tube from the left side of the large A10 disc so the left chain
    // sits fully to the left of the disc in side view.
    a6_center_x = a8_disc_left_face_x - a6_h / 2 + a6_insert_into_disc;
    a6_left_x = a6_center_x - a6_h / 2;

    // A1 subassembly uses local +Z as its axial "outward from gear" direction.
    // Place its outer end slightly inside the left end of A6.
    a1_origin_x = a6_left_x - a1_z_max + a1_insert_into_a6 - explode;

    rotate([theta, 0, 0]) {
        // Middle tube, rolled so the slot feature is visible in default preview.
        color([0.38, 0.30, 0.22])
            translate([a6_center_x, 0, 0])
                rotate([0, 90, a6_roll_deg])
                    part_a6();

        // Left gear-side cluster.
        translate([a1_origin_x, 0, 0])
            rotate([0, -90, 0])
                drw001_a1_subassembly();

        // Right crank-side cluster.
        translate([a8_disc_center_x, 0, 0])
            rotate([0, 90, 0])
                drw001_a8_subassembly();
    }
}

module drw001_a1_gear_assembly_debug() {
    // Optional helper for local tweaking.
    %color("red")
        translate([-8.5, 0, 0])
            rotate([0, 90, 0])
                cylinder(d = 12, h = 17, center = false);

    drw001_a1_gear_assembly();
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
