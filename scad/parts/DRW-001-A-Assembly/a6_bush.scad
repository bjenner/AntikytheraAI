// part_id: a6
// name: A6 bush
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

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
    band_z = h - top_band_offset - top_band_h;

    difference() {
        // Main tube body.
        cylinder(d = od, h = h, center = false, $fn = 96);

        // Through inner bore (R4.0 / Ø8.0).
        translate([0, 0, -0.1]) cylinder(d = id, h = h + 0.2, center = false, $fn = 72);

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
        translate([-u_slot_w / 2, -od / 2 - 0.1, 0])
            cube([u_slot_w, od + 0.2, u_slot_rect_h], center = false);
        translate([0, 0, u_slot_rect_h])
            rotate([90, 0, 0])
                cylinder(r = u_slot_r, h = od + 0.2, center = true, $fn = 48);

        // Small top detent/hole (Ø1.5), fully through one side wall into the bore.
        wall_t = (od - id) / 2;
        translate([0, od / 2 + 0.05, top_hole_z])
            rotate([90, 0, 0])
                cylinder(d = top_hole_d, h = wall_t + 0.2, center = false, $fn = 36);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a6();
}
