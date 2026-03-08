// part_id: a4
// name: A4 block
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

module a4_body_2d(w = 16, d = 8, corner_r = 1.0) {
    // First correction pass: rectangular body with softened corners.
    // End-form contour (R8 callout behavior) can be refined in a later pass.
    hull() {
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * (w / 2 - corner_r), sy * (d / 2 - corner_r)])
                circle(r = corner_r, $fn = 24);
    }
}

module part_a4(
    w = 16,
    d = 8,
    body_h = 32.2,
    top_pin_d = 2.9,
    top_pin_h = 2.0,
    pin_spacing = 8.0,
    bore_d = 10.0,
    bore_center_z = 17.6,
    lower_cut_h = 2.5,
    lower_cut_w = 2.5,
    lower_cut_depth = 2.0,
    lower_cut_gap = 8.0,
    corner_r = 1.0
) {
    difference() {
        union() {
            // Main block
            linear_extrude(height = body_h)
                a4_body_2d(w = w, d = d, corner_r = corner_r);

            // Two top protruding bosses (were incorrectly modeled as holes).
            for (x = [-pin_spacing / 2, pin_spacing / 2])
                translate([x, 0, body_h])
                    cylinder(d = top_pin_d, h = top_pin_h, center = false, $fn = 36);
        }

        // Main transverse bore (dimension-driven center height).
        translate([0, 0, bore_center_z])
            rotate([90, 0, 0])
                cylinder(d = bore_d, h = d + 0.4, center = true, $fn = 64);

        // Lower side cutouts (first-pass interpretation of the hidden lower features).
        for (sx = [-1, 1])
            translate([
                sx * (lower_cut_gap / 2 + lower_cut_w / 2),
                d / 2 - lower_cut_depth,
                0
            ])
                cube([lower_cut_w, lower_cut_depth + 0.2, lower_cut_h], center = true);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a4();
}
