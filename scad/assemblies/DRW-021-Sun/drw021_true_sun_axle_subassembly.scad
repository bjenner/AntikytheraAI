// DRW-021 reusable true sun axle subassembly (sun16, sun17, b0).
// Centered on the shaft axis at origin for reuse in sheet scenes.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-021-Sun/sun16_pointer_arm.scad>
use <../../parts/DRW-021-Sun/sun17_slotted_shaft.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b0_gear.scad>

module drw021_true_sun_axle_subassembly(
    sun16_th = 1.7,
    sun17_body_h = 49.2,
    sun17_tip_h = 3.1,
    sun17_top_h = 2.5,
    b0_th = 1.6,
    z_offset = 51.6
) {
    bronze = [0.45, 0.30, 0.18];
    dark_bronze = [0.40, 0.26, 0.14];
    gear_bronze = [0.52, 0.28, 0.14];

    sun17_total_h = sun17_body_h + sun17_top_h;
    sun17_bottom_z = -sun17_total_h / 2;
    sun17_top_z = sun17_total_h / 2;

    // Sun16 is pressed upward until its top face meets the 2.5 mm shoulder.
    sun16_z = sun17_bottom_z + 0.8 + sun16_th / 2;

    // B0 seats downward onto the 3.1 mm upper journal.
    b0_z = sun17_top_z - 1.5 - b0_th / 2;

    translate([0, 0, z_offset]) {
        color(dark_bronze)
            rotate([180, 0, 0])
                part_sun17(
                    body_h = sun17_body_h,
                    split_h = sun17_tip_h,
                    top_h = sun17_top_h
                );

        color(bronze)
            translate([0, 0, sun16_z])
                part_sun16(thickness = sun16_th);

        color(gear_bronze)
            translate([0, 0, b0_z])
                rotate([360, 0, 0])
                    part_b0(thickness = b0_th);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw021_true_sun_axle_subassembly();
}
