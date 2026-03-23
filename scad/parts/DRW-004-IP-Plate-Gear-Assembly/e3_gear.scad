// part_id: e3
// name: E3 gear
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part E3: large thin fine-tooth gear plate shown in the DRW-004 gear set detail.
//
// Local origin convention:
// - XY origin is the gear rotation axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

function e3_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

module e3_tooth_gap_2d(
    outer_r = 30.40,
    root_r = 29.60,
    pitch_deg = 360 / 144,
    tip_land_deg = 0.62,
    shoulder_r = 30.05,
    shoulder_deg = 0.78,
    throat_r = 29.70,
    throat_deg = 0.48,
    root_deg = 0.24,
    overshoot_r = 0.18
) {
    gap_half_deg = max((pitch_deg - tip_land_deg) / 2, throat_deg + 0.08);

    polygon(points = [
        e3_polar(outer_r + overshoot_r, -gap_half_deg),
        e3_polar(shoulder_r, -shoulder_deg),
        e3_polar(throat_r, -throat_deg),
        e3_polar(root_r, -root_deg),
        e3_polar(root_r, root_deg),
        e3_polar(throat_r, throat_deg),
        e3_polar(shoulder_r, shoulder_deg),
        e3_polar(outer_r + overshoot_r, gap_half_deg)
    ]);
}

module e3_gear_profile_2d(
    outer_d = 60.80,
    root_d = 59.20,
    tooth_count = 144,
    tip_land_deg = 0.62,
    shoulder_d = 60.10,
    shoulder_deg = 0.78,
    throat_d = 59.40,
    throat_deg = 0.48,
    root_deg = 0.24,
    tooth_cut_angle_deg = 90
) {
    pitch_deg = 360 / tooth_count;

    difference() {
        circle(d = outer_d, $fn = max(360, tooth_count * 4));
        for (i = [0 : tooth_count - 1]) {
            rotate(tooth_cut_angle_deg + i * pitch_deg)
                e3_tooth_gap_2d(
                    outer_r = outer_d / 2,
                    root_r = root_d / 2,
                    pitch_deg = pitch_deg,
                    tip_land_deg = tip_land_deg,
                    shoulder_r = shoulder_d / 2,
                    shoulder_deg = shoulder_deg,
                    throat_r = throat_d / 2,
                    throat_deg = throat_deg,
                    root_deg = root_deg
                );
        }
    }
}

module e3_center_bore_2d(
    bore_d = 3.20
) {
    circle(d = bore_d, $fn = 48);
}

module part_e3(
    outer_d = 60.80,
    root_d = 59.20,
    thickness = 1.60,
    tooth_count = 144,
    tip_land_deg = 0.62,
    shoulder_d = 60.10,
    shoulder_deg = 0.78,
    throat_d = 59.40,
    throat_deg = 0.48,
    root_deg = 0.24,
    tooth_cut_angle_deg = 90,
    bore_d = 3.20,
    hole_d = 1.60,
    upper_hole_y = 22.20,
    upper_hole_x = 14.80,
    lower_hole_y = -18.20,
    lower_side_hole_x = 19.20,
    lower_center_hole_y = -15.50
) {
    difference() {
        linear_extrude(height = thickness, center = true)
            e3_gear_profile_2d(
                outer_d = outer_d,
                root_d = root_d,
                tooth_count = tooth_count,
                tip_land_deg = tip_land_deg,
                shoulder_d = shoulder_d,
                shoulder_deg = shoulder_deg,
                throat_d = throat_d,
                throat_deg = throat_deg,
                root_deg = root_deg,
                tooth_cut_angle_deg = tooth_cut_angle_deg
            );

        linear_extrude(height = thickness + 0.2, center = true)
            e3_center_bore_2d(
                bore_d = bore_d
            );

        for (pos = [
            [-upper_hole_x, upper_hole_y],
            [upper_hole_x, upper_hole_y],
            [-lower_side_hole_x, lower_hole_y],
            [0, lower_center_hole_y],
            [lower_side_hole_x, lower_hole_y]
        ]) {
            translate([pos[0], pos[1], 0])
                cylinder(d = hole_d, h = thickness + 0.2, center = true, $fn = 28);
        }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_e3();
}
