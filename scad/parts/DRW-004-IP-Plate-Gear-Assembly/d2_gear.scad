// part_id: d2
// name: D2 gear
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part D2: large thin gear shown on DRW-004 sheet 11.
//
// Local origin convention:
// - XY origin is the gear rotation axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

function d2_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

module d2_tooth_gap_2d(
    outer_r = 28.10,
    root_r = 27.20,
    pitch_deg = 360 / 106,
    tip_land_deg = 0.82,
    shoulder_r = 27.76,
    shoulder_deg = 0.98,
    throat_r = 27.28,
    throat_deg = 0.62,
    root_deg = 0.31,
    overshoot_r = 0.20
) {
    gap_half_deg = max((pitch_deg - tip_land_deg) / 2, throat_deg + 0.08);

    polygon(points = [
        d2_polar(outer_r + overshoot_r, -gap_half_deg),
        d2_polar(shoulder_r, -shoulder_deg),
        d2_polar(throat_r, -throat_deg),
        d2_polar(root_r, -root_deg),
        d2_polar(root_r, root_deg),
        d2_polar(throat_r, throat_deg),
        d2_polar(shoulder_r, shoulder_deg),
        d2_polar(outer_r + overshoot_r, gap_half_deg)
    ]);
}

module d2_gear_profile_2d(
    outer_d = 56.20,
    root_d = 54.40,
    tooth_count = 106,
    tip_land_deg = 0.82,
    shoulder_d = 55.52,
    shoulder_deg = 0.98,
    throat_d = 54.56,
    throat_deg = 0.62,
    root_deg = 0.31,
    tooth_cut_angle_deg = 90
) {
    pitch_deg = 360 / tooth_count;

    difference() {
        circle(d = outer_d, $fn = max(300, tooth_count * 4));
        for (i = [0 : tooth_count - 1]) {
            rotate(tooth_cut_angle_deg + i * pitch_deg)
                d2_tooth_gap_2d(
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

module part_d2(
    outer_d = 56.20,
    thickness = 1.0,
    tooth_count = 106,
    root_d = 54.40,
    tip_land_deg = 0.82,
    shoulder_d = 55.52,
    shoulder_deg = 0.98,
    throat_d = 54.56,
    throat_deg = 0.62,
    root_deg = 0.31,
    tooth_cut_angle_deg = 90,
    bore_d = 17.0
) {
    difference() {
        linear_extrude(height = thickness, center = true)
            d2_gear_profile_2d(
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

        cylinder(d = bore_d, h = thickness + 0.2, center = true, $fn = 96);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_d2();
}
