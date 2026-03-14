// Part A6: slotted bush with top band cut.
// SPDX-License-Identifier: MIT
//
// Local origin convention:
// - XY origin is the tube axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

module part_a6(
    od = 11.8,
    id = 8.0,
    h = 17.0,
    // Top band zone (from side view: 2.0 down, 1.0 tall).
    top_band_offset = 2.0,
    top_band_h = 1.0,
    top_band_depth = 0.8,
    // Lower U slot (front view).
    u_slot_w = 3.0,
    u_slot_h = 8.8,
    // Small top notch callout (Ø1.5 centered at top edge -> half-circle depression).
    top_hole_d = 1.5,
    top_hole_z = 17.0,
    // Top band cut with two opposite remaining tabs (opposite sides).
    top_tab_w = 3.0,
    top_slot_h = 1.0
) {
    u_slot_r = u_slot_w / 2;
    // Height where rounded cap of the U-slot starts.
    u_slot_rect_h = max(0, u_slot_h - u_slot_r);
    z_min = -h / 2;
    band_z = z_min + h - top_band_offset - top_band_h;

    difference() {
        // Main tube body.
        translate([0, 0, z_min])
            cylinder(d = od, h = h, center = false, $fn = 96);

        // Through inner bore (R4.0 / Ø8.0).
        translate([0, 0, z_min - 0.1]) cylinder(d = id, h = h + 0.2, center = false, $fn = 72);

        // Inverted interpretation: cut most of the top band annulus,
        // leaving two opposite tabs centered at 0/180 degrees.
        translate([0, 0, band_z])
            difference() {
                difference() {
                    cylinder(d = od + 0.2, h = top_slot_h, center = false, $fn = 96);
                    cylinder(d = od - 2 * top_band_depth, h = top_slot_h + 0.02, center = false, $fn = 96);
                }
                for (a = [90, 270])
                    rotate([0, 0, a])
                        translate([od / 2 - top_band_depth / 2, 0, top_slot_h / 2])
                            cube([top_band_depth + 0.6, top_tab_w, top_slot_h + 0.2], center = true);
            }

        // Bottom U-slot, open from one side (front view behavior).
        // Build from a rectangular stem plus rounded cap.
        translate([-u_slot_w / 2, -od / 2 - 0.1, z_min])
            cube([u_slot_w, od + 0.2, u_slot_rect_h], center = false);
        translate([0, 0, z_min + u_slot_rect_h])
            rotate([90, 0, 0])
                cylinder(r = u_slot_r, h = od + 0.2, center = true, $fn = 48);

        // Small top detent/hole (Ø1.5), fully through one side wall into the bore.
        wall_t = (od - id) / 2;
        translate([0, od / 2 + 0.05, z_min + top_hole_z])
            rotate([90, 0, 0])
                cylinder(d = top_hole_d, h = wall_t + 0.2, center = false, $fn = 36);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a6();
}
