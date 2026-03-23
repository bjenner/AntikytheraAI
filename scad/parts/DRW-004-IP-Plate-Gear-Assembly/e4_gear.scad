// part_id: e4
// name: E4 gear
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part E4: large thin fine-tooth gear plate shown in the DRW-004 gear set detail.
//
// Local origin convention:
// - XY origin is the gear rotation axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

function e4_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

module e4_tooth_gap_2d(
    outer_r = 52.60,
    root_r = 51.89,
    pitch_deg = 360 / 250,
    tip_land_deg = 0.36,
    shoulder_r = 52.28,
    shoulder_deg = 0.46,
    throat_r = 51.96,
    throat_deg = 0.28,
    root_deg = 0.14,
    overshoot_r = 0.14
) {
    gap_half_deg = max((pitch_deg - tip_land_deg) / 2, throat_deg + 0.06);

    polygon(points = [
        e4_polar(outer_r + overshoot_r, -gap_half_deg),
        e4_polar(shoulder_r, -shoulder_deg),
        e4_polar(throat_r, -throat_deg),
        e4_polar(root_r, -root_deg),
        e4_polar(root_r, root_deg),
        e4_polar(throat_r, throat_deg),
        e4_polar(shoulder_r, shoulder_deg),
        e4_polar(outer_r + overshoot_r, gap_half_deg)
    ]);
}

module e4_gear_profile_2d(
    outer_d = 105.20,
    root_d = 103.78,
    tooth_count = 250,
    tip_land_deg = 0.36,
    shoulder_d = 104.56,
    shoulder_deg = 0.46,
    throat_d = 103.92,
    throat_deg = 0.28,
    root_deg = 0.14,
    tooth_cut_angle_deg = 90
) {
    pitch_deg = 360 / tooth_count;

    difference() {
        circle(d = outer_d, $fn = max(720, tooth_count * 4));
        for (i = [0 : tooth_count - 1]) {
            rotate(tooth_cut_angle_deg + i * pitch_deg)
                e4_tooth_gap_2d(
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

module part_e4(
    outer_d = 105.20,
    root_d = 103.78,
    thickness = 1.60,
    tooth_count = 250,
    tip_land_deg = 0.36,
    shoulder_d = 104.56,
    shoulder_deg = 0.46,
    throat_d = 103.92,
    throat_deg = 0.28,
    root_deg = 0.14,
    tooth_cut_angle_deg = 90,
    bore_d = 9.0,
    upper_left_hole_d = 3.0,
    upper_pair_y = 30.0,
    upper_hole_x = 26.5,
    lower_pair_y = -31.0,
    lower_hole_x = 28.0,
    lower_center_hole_d = 4.0,
    lower_center_hole_y = -22.5
) {
    difference() {
        linear_extrude(height = thickness, center = true)
            e4_gear_profile_2d(
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

        cylinder(d = bore_d, h = thickness + 0.2, center = true, $fn = 72);

        translate([-upper_hole_x, upper_pair_y, 0])
            cylinder(d = upper_left_hole_d, h = thickness + 0.2, center = true, $fn = 28);
        translate([upper_hole_x, upper_pair_y, 0])
            cylinder(d = upper_left_hole_d, h = thickness + 0.2, center = true, $fn = 28);

        translate([-lower_hole_x, lower_pair_y, 0])
            cylinder(d = upper_left_hole_d, h = thickness + 0.2, center = true, $fn = 28);
        translate([lower_hole_x, lower_pair_y, 0])
            cylinder(d = upper_left_hole_d, h = thickness + 0.2, center = true, $fn = 28);

        translate([0, lower_center_hole_y, 0])
            cylinder(d = lower_center_hole_d, h = thickness + 0.2, center = true, $fn = 28);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_e4();
}
