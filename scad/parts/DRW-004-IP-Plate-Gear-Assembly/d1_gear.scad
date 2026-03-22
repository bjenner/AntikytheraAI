// part_id: d1
// name: D1 gear
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part D1: small spur gear shown on DRW-004 sheet 10.
//
// Local origin convention:
// - XY origin is the gear rotation axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

function d1_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

function d1_tip_land_deg(tip_land_w = 0.18, outer_d = 11.70) =
    2 * asin(min(1, tip_land_w / outer_d));

function d1_root_land_deg(
    tip_land_w = 0.18,
    outer_d = 11.70
) = d1_tip_land_deg(
    tip_land_w = tip_land_w,
    outer_d = outer_d
) * 1.15;

module d1_tooth_gap_2d(
    outer_r = 5.85,
    root_r = 4.84,
    pitch_deg = 15,
    tip_land_deg = d1_tip_land_deg(),
    root_land_deg = d1_root_land_deg(),
    shoulder_r = 5.25,
    shoulder_deg = 3.20,
    throat_r = 4.85,
    throat_deg = 1.95,
    root_deg = root_land_deg / 2,
    overshoot_r = 0.20
) {
    gap_half_deg = max((pitch_deg - tip_land_deg) / 2, throat_deg + 0.15);

    polygon(points = [
        d1_polar(outer_r + overshoot_r, -gap_half_deg),
        d1_polar(shoulder_r, -shoulder_deg),
        d1_polar(throat_r, -throat_deg),
        d1_polar(root_r, -root_deg),
        d1_polar(root_r, root_deg),
        d1_polar(throat_r, throat_deg),
        d1_polar(shoulder_r, shoulder_deg),
        d1_polar(outer_r + overshoot_r, gap_half_deg)
    ]);
}

module d1_gear_profile_2d(
    outer_d = 11.70,
    root_d = 9.68,
    tooth_count = 24,
    tip_land_w = 0.18,
    shoulder_d = 10.50,
    shoulder_deg = 3.20,
    throat_d = 9.70,
    throat_deg = 1.95,
    root_deg = undef,
    tooth_cut_angle_deg = 90
) {
    pitch_deg = 360 / tooth_count;
    tip_land_deg = d1_tip_land_deg(
        tip_land_w = tip_land_w,
        outer_d = outer_d
    );
    root_land_deg = d1_root_land_deg(
        tip_land_w = tip_land_w,
        outer_d = outer_d
    );
    root_half_deg = is_undef(root_deg) ? root_land_deg / 2 : root_deg;

    difference() {
        circle(d = outer_d, $fn = max(160, tooth_count * 6));
        for (i = [0 : tooth_count - 1]) {
            rotate(tooth_cut_angle_deg + i * pitch_deg)
                d1_tooth_gap_2d(
                    outer_r = outer_d / 2,
                    root_r = root_d / 2,
                    pitch_deg = pitch_deg,
                    tip_land_deg = tip_land_deg,
                    root_land_deg = 2 * root_half_deg,
                    shoulder_r = shoulder_d / 2,
                    shoulder_deg = shoulder_deg,
                    throat_r = throat_d / 2,
                    throat_deg = throat_deg,
                    root_deg = root_half_deg
                );
        }
    }
}

module d1_center_bore_2d(
    bore_d = 4.0,
    relief_r = 0.75
) {
    union() {
        circle(d = bore_d, $fn = 56);
        for (x = [-bore_d / 2, bore_d / 2]) {
            translate([x, 0]) circle(r = relief_r, $fn = 36);
        }
    }
}

module part_d1(
    outer_d = 11.70,
    thickness = 2.0,
    tooth_count = 24,
    root_d = 9.68,
    tip_land_w = 0.18,
    shoulder_d = 10.50,
    shoulder_deg = 3.20,
    throat_d = 9.70,
    throat_deg = 1.95,
    root_deg = undef,
    tooth_cut_angle_deg = 90,
    bore_d = 4.0,
    relief_r = 0.75
) {
    difference() {
        linear_extrude(height = thickness, center = true)
            d1_gear_profile_2d(
                outer_d = outer_d,
                root_d = root_d,
                tooth_count = tooth_count,
                tip_land_w = tip_land_w,
                shoulder_d = shoulder_d,
                shoulder_deg = shoulder_deg,
                throat_d = throat_d,
                throat_deg = throat_deg,
                root_deg = root_deg,
                tooth_cut_angle_deg = tooth_cut_angle_deg
            );

        translate([0, 0, -thickness / 2 - 0.1])
            linear_extrude(height = thickness + 0.2)
                d1_center_bore_2d(
                    bore_d = bore_d,
                    relief_r = relief_r
                );
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_d1();
}
