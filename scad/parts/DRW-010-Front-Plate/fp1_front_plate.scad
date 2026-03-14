// part_id: fp1
// name: Front plate base panel
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module fp1_front_plate_2d(
    width = 318.3,
    height = 184.0,
    dial_d = 132,
    corner_hole_d = 5.0,
    corner_margin = 7.5
) {
    difference() {
        square([width, height], center = true);
        circle(d = dial_d, $fn = 140);

        for (sx = [-1, 1], sy = [-1, 1]) {
            translate([sx * (width / 2 - corner_margin), sy * (height / 2 - corner_margin)])
                circle(d = corner_hole_d, $fn = 24);
        }
    }
}

module fp1_inscription_2d(
    panel_w = 60,
    panel_h = 78,
    row_pitch = 4.2
) {
    for (r = [0 : 13]) {
        y = panel_h / 2 - 4 - r * row_pitch;
        for (c = [0 : 7]) {
            if ((c + r) % 3 != 0)
                translate([-panel_w / 2 + 3.5 + c * 4.1, y])
                    circle(d = 0.65, $fn = 12);
        }
    }
}

module part_fp1(
    thickness = 1.6,
    show_text = true
) {
    linear_extrude(height = thickness)
        fp1_front_plate_2d();

    if (show_text) {
        color("black") {
            translate([-105, 0, thickness + 0.02]) linear_extrude(height = 0.12) rotate([0, 0, 90]) fp1_inscription_2d();
            translate([-63, 0, thickness + 0.02]) linear_extrude(height = 0.12) rotate([0, 0, 90]) fp1_inscription_2d();
            translate([63, 0, thickness + 0.02]) linear_extrude(height = 0.12) rotate([0, 0, 270]) fp1_inscription_2d();
            translate([105, 0, thickness + 0.02]) linear_extrude(height = 0.12) rotate([0, 0, 270]) fp1_inscription_2d();
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_fp1();
}
