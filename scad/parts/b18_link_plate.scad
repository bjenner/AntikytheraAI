// part_id: b18
// name: B18 link plate
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b18_profile_2d(length = 124, height = 24, corner_r = 4.5,
                      center_cut_r = 23,
                      h_d = 3.0,
                      center_hole_d = 10.0) {
    difference() {
        // Rounded rectangle envelope.
        hull() {
            translate([corner_r, corner_r]) circle(r = corner_r, $fn = 40);
            translate([length - corner_r, corner_r]) circle(r = corner_r, $fn = 40);
            translate([corner_r, height - corner_r]) circle(r = corner_r, $fn = 40);
            translate([length - corner_r, height - corner_r]) circle(r = corner_r, $fn = 40);
        }

        // Central underside clearance arc.
        translate([58.5, -center_cut_r + 0.4])
            circle(r = center_cut_r, $fn = 80);

        // Main center hole.
        translate([58.5, 14.5])
            circle(d = center_hole_d, $fn = 40);

        // Hole pattern (sheet-10 approximation, intended for visual and assembly use).
        holes = [
            [7.8, 4.2], [7.8, 19.8],
            [26.2, 7.0], [26.2, 22.5 - 7.0],
            [35.6, 10.8],
            [115.0, 4.2], [115.0, 19.8],
            [120.5, 7.0]
        ];

        for (p = holes)
            translate(p) circle(d = h_d, $fn = 30);
    }
}

module part_b18(length = 124, height = 24, thickness = 1.6) {
    linear_extrude(height = thickness)
        b18_profile_2d(length = length, height = height);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b18();
}
