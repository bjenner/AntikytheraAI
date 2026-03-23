// part_id: e4_cut
// name: E4 cut template gear
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part E4_cut: annular sheet-metal cut template shown alongside the later e4 sheet.
//
// Local origin convention:
// - XY origin is the gear rotation axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

function e4_cut_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

module e4_cut_tooth_gap_2d(
    outer_r = 50.69,
    root_r = 50.27,
    pitch_deg = 360 / 250,
    tip_land_deg = 0.36,
    shoulder_r = 50.50,
    shoulder_deg = 0.44,
    throat_r = 50.34,
    throat_deg = 0.27,
    root_deg = 0.13,
    overshoot_r = 0.14
) {
    gap_half_deg = max((pitch_deg - tip_land_deg) / 2, throat_deg + 0.06);

    polygon(points = [
        e4_cut_polar(outer_r + overshoot_r, -gap_half_deg),
        e4_cut_polar(shoulder_r, -shoulder_deg),
        e4_cut_polar(throat_r, -throat_deg),
        e4_cut_polar(root_r, -root_deg),
        e4_cut_polar(root_r, root_deg),
        e4_cut_polar(throat_r, throat_deg),
        e4_cut_polar(shoulder_r, shoulder_deg),
        e4_cut_polar(outer_r + overshoot_r, gap_half_deg)
    ]);
}

module e4_cut_gear_profile_2d(
    outer_d = 101.38,
    root_d = 100.54,
    tooth_count = 250,
    tip_land_deg = 0.36,
    shoulder_d = 101.00,
    shoulder_deg = 0.44,
    throat_d = 100.68,
    throat_deg = 0.27,
    root_deg = 0.13,
    tooth_cut_angle_deg = 90
) {
    pitch_deg = 360 / tooth_count;

    difference() {
        circle(d = outer_d, $fn = max(720, tooth_count * 4));
        for (i = [0 : tooth_count - 1]) {
            rotate(tooth_cut_angle_deg + i * pitch_deg)
                e4_cut_tooth_gap_2d(
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

module part_e4_cut(
    outer_d = 101.38,
    root_d = 100.54,
    thickness = 1.60,
    tooth_count = 250,
    tip_land_deg = 0.36,
    shoulder_d = 101.00,
    shoulder_deg = 0.44,
    throat_d = 100.68,
    throat_deg = 0.27,
    root_deg = 0.13,
    tooth_cut_angle_deg = 90,
    inner_cut_d = 85.0,
    hole_d = 3.0,
    hole_pattern_r = 40.0,
    hole_pair_y = 32.55
) {
    hole_x = sqrt(max(hole_pattern_r * hole_pattern_r - hole_pair_y * hole_pair_y, 0));

    difference() {
        linear_extrude(height = thickness, center = true)
            e4_cut_gear_profile_2d(
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

        cylinder(d = inner_cut_d, h = thickness + 0.2, center = true, $fn = 144);

        for (x = [-hole_x, hole_x], y = [-hole_pair_y, hole_pair_y]) {
            translate([x, y, 0])
                cylinder(d = hole_d, h = thickness + 0.2, center = true, $fn = 28);
        }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_e4_cut();
}
