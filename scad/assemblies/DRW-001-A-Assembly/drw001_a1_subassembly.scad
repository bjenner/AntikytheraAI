// DRW-001 reusable A1 subassembly (A1 fitted to A3).
// Centered on the assembly axis at origin for easy placement in sheet scenes.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-001-A-Assembly/a1.scad>
use <../../parts/DRW-001-A-Assembly/a3_pin.scad>

module drw001_a1_subassembly(
    a1_body_d = 30,
    a1_thickness = 2.0,
    a1_bore_d = 4.0,
    a3_d = 9.8,
    a3_h = 16.6,
    interface_gap = 0.0,
    a1_roll_deg = 90,
    a3_roll_deg = 0
) {
    drw001_a1_subassembly_scene(
        theta = 0,
        explode = 0,
        a1_body_d = a1_body_d,
        a1_thickness = a1_thickness,
        a1_bore_d = a1_bore_d,
        a3_d = a3_d,
        a3_h = a3_h,
        a1_roll_deg = a1_roll_deg,
        a3_roll_deg = a3_roll_deg
    );
}

module drw001_a1_subassembly_scene(
    theta = 0,
    explode = 0,
    a1_body_d = 30,
    a1_thickness = 2.0,
    a1_bore_d = 4.0,
    a3_d = 9.8,
    a3_h = 16.6,
    a1_roll_deg = 90,
    a3_roll_deg = 0
) {
    rotate([0, 0, theta]) {
        drw001_a1_subassembly_place_a1(
            a1_body_d = a1_body_d,
            a1_thickness = a1_thickness,
            a1_bore_d = a1_bore_d,
            a1_roll_deg = a1_roll_deg
        );
        translate([0, 0, explode])
            drw001_a1_subassembly_place_a3(
                a1_thickness = a1_thickness,
                a3_d = a3_d,
                a3_h = a3_h,
                a3_roll_deg = a3_roll_deg
            );
    }
}

module drw001_a1_subassembly_spin(
    explode = 0,
    turns = 1,
    a1_body_d = 30,
    a1_thickness = 2.0,
    a1_bore_d = 4.0,
    a3_d = 9.8,
    a3_h = 16.6,
    a1_roll_deg = 90,
    a3_roll_deg = 0
) {
    drw001_a1_subassembly_scene(
        theta = 360 * turns * $t,
        explode = explode,
        a1_body_d = a1_body_d,
        a1_thickness = a1_thickness,
        a1_bore_d = a1_bore_d,
        a3_d = a3_d,
        a3_h = a3_h,
        a1_roll_deg = a1_roll_deg,
        a3_roll_deg = a3_roll_deg
    );
}

module drw001_a1_subassembly_exploded(
    explode = 0,
    theta = 0,
    a1_body_d = 30,
    a1_thickness = 2.0,
    a1_bore_d = 4.0,
    a3_d = 9.8,
    a3_h = 16.6,
    a1_roll_deg = 90,
    a3_roll_deg = 0
) {
    drw001_a1_subassembly_scene(
        theta = theta,
        explode = explode,
        a1_body_d = a1_body_d,
        a1_thickness = a1_thickness,
        a1_bore_d = a1_bore_d,
        a3_d = a3_d,
        a3_h = a3_h,
        a1_roll_deg = a1_roll_deg,
        a3_roll_deg = a3_roll_deg
    );
}

module drw001_a1_subassembly_place_a1(
    a1_body_d = 30,
    a1_thickness = 2.0,
    a1_bore_d = 4.0,
    a1_roll_deg = 90
) {
    // A1 centered on origin with axis on X.
    // Flip along axis so taper direction matches the drawing.
    color([0.45, 0.30, 0.18])
        rotate([0, 0,45])
            rotate([90, 0, 0])
            rotate([a1_roll_deg, 0, 0])
            part_a1(
                body_d = a1_body_d,
                thickness = a1_thickness,
                bore_d = a1_bore_d,
                spoke_count = 0
            );
}

module drw001_a1_subassembly_place_a3(
    a1_thickness = 2.0,
    a3_d = 9.8,
    a3_h = 16.6,
    a3_roll_deg = 0
) {
    // A3 aligned to same axis, seated into A1 by interface_inset.
    // Use reversed axial orientation so the intended end mates with A1.
    // The lower pin section is the intended fit into A1.
    // Keep that pin seated through the gear thickness while the larger body
    // remains outside the gear face.
    a3_insert_h = 2.0;
    seat_z = a1_thickness / 2 + a3_h / 2 - a3_insert_h;

    color("green")
        // Place with zero gap by default: mating face of A3 sits on the
        // positive face of centered A1.
        translate([0, 0, seat_z])
            rotate([0, 0, 0])
            rotate([0, 180, 90])
            rotate([a3_roll_deg, 0, 0])
                part_a3(
                    d = a3_d,
                    h = a3_h
                );
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    if (!is_undef(A1_SUB_EXPLODE) && A1_SUB_EXPLODE) {
        drw001_a1_subassembly_exploded(
            explode = 14
        );
    } else if (!is_undef(A1_SUB_SPIN) && A1_SUB_SPIN) {
        drw001_a1_subassembly_spin(
            explode = !is_undef(A1_SUB_EXPLODE_MM) ? A1_SUB_EXPLODE_MM : 10,
            turns = !is_undef(A1_SUB_TURNS) ? A1_SUB_TURNS : 1
        );
    } else {
        drw001_a1_subassembly();
    }
}
