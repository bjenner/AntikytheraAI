// part_id: a7
// name: A7 block
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

module a7_body_2d(base_r = 8.0, trim_half = 4.0) {
    // Drawing-driven base profile:
    // start from R8 circle, trim with parallel cuts at y = +/-4.
    intersection() {
        circle(r = base_r, $fn = 96);
        square([2 * base_r, 2 * trim_half], center = true);
    }
}

module part_a7(
    w = 16.0,
    d = 8.0,
    body_h = 35.2,
    bore_d = 12.0,
    bore_center_z = 20.6,
    // Bottom blind vertical hole (diameter inferred from drawing).
    bottom_hole_d = 4.0,
    // Top feature: simple column (slot details deferred).
    top_post_d = 4.6,
    top_post_h = 5.0,
    top_post_slot_h = 1.0,
    top_post_slot_depth = 0.25,
    // Body groove around lower portion.
    groove_z = 8.0,
    groove_h = 1.0,
    groove_depth_wide = 2.5,
    base_r = 8.0,
    trim_half = 4.0
) {
    difference() {
        union() {
            // Main block.
            linear_extrude(height = body_h)
                a7_body_2d(base_r = base_r, trim_half = trim_half);

            // Simple top column.
            translate([0, 0, body_h])
                cylinder(d = top_post_d, h = top_post_h, center = false, $fn = 64);
        }

        // Main transverse bore (Ø12), dimension-driven location.
        translate([0, 0, bore_center_z])
            rotate([90, 0, 0])
                cylinder(d = bore_d, h = d + 0.4, center = true, $fn = 96);

        // Bottom blind vertical hole up to side-bore centerline.
        translate([0, 0, -0.1])
            cylinder(d = bottom_hole_d, h = bore_center_z + 0.2, center = false, $fn = 56);

        // Side grooves only on the two wide faces (deeper), not wrapping around short ends.
        for (sy = [-1, 1])
            translate([0, sy * (trim_half - groove_depth_wide / 2), groove_z + groove_h / 2])
                cube([2 * (base_r + 0.4), groove_depth_wide, groove_h + 0.04], center = true);

        // Matching slot pair in the middle of the upper pin.
        // Opposing shallow cuts, centered at pin mid-height.
        for (sy = [-1, 1])
            translate([
                0,
                sy * (top_post_d / 2 - top_post_slot_depth / 2),
                body_h + top_post_h / 2
            ])
                cube([top_post_d + 0.4, top_post_slot_depth, top_post_slot_h], center = true);

    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a7();
}
