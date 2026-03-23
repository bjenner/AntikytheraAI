// part_id: e2
// name: E2 gear
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part E2: thin spur gear with large center bore shown in the DRW-004 gear set detail.
//
// Local origin convention:
// - XY origin is the gear rotation axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

function e2_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

function e2_tip_land_deg(tip_land_w = 0.28, outer_d = 17.20) =
    2 * asin(min(1, tip_land_w / outer_d));

function e2_root_land_deg(
    tip_land_w = 0.28,
    outer_d = 17.20
) = e2_tip_land_deg(
    tip_land_w = tip_land_w,
    outer_d = outer_d
) * 1.10;

module e2_tooth_gap_2d(
    outer_r = 8.60,
    root_r = 7.48,
    pitch_deg = 360 / 32,
    tip_land_deg = e2_tip_land_deg(),
    root_land_deg = e2_root_land_deg(),
    shoulder_r = 8.18,
    shoulder_deg = 2.30,
    throat_r = 7.60,
    throat_deg = 1.42,
    root_deg = root_land_deg / 2,
    overshoot_r = 0.20
) {
    gap_half_deg = max((pitch_deg - tip_land_deg) / 2, throat_deg + 0.15);

    polygon(points = [
        e2_polar(outer_r + overshoot_r, -gap_half_deg),
        e2_polar(shoulder_r, -shoulder_deg),
        e2_polar(throat_r, -throat_deg),
        e2_polar(root_r, -root_deg),
        e2_polar(root_r, root_deg),
        e2_polar(throat_r, throat_deg),
        e2_polar(shoulder_r, shoulder_deg),
        e2_polar(outer_r + overshoot_r, gap_half_deg)
    ]);
}

module e2_gear_profile_2d(
    outer_d = 17.20,
    root_d = 14.96,
    tooth_count = 32,
    tip_land_w = 0.28,
    shoulder_d = 16.36,
    shoulder_deg = 2.30,
    throat_d = 15.20,
    throat_deg = 1.42,
    root_deg = undef,
    tooth_cut_angle_deg = 90
) {
    pitch_deg = 360 / tooth_count;
    tip_land_deg = e2_tip_land_deg(
        tip_land_w = tip_land_w,
        outer_d = outer_d
    );
    root_land_deg = e2_root_land_deg(
        tip_land_w = tip_land_w,
        outer_d = outer_d
    );
    root_half_deg = is_undef(root_deg) ? root_land_deg / 2 : root_deg;

    difference() {
        circle(d = outer_d, $fn = max(180, tooth_count * 6));
        for (i = [0 : tooth_count - 1]) {
            rotate(tooth_cut_angle_deg + i * pitch_deg)
                e2_tooth_gap_2d(
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

module e2_center_bore_2d(
    main_r = 4.5,
    upper_relief_r = 0.8,
    lower_relief_r = 0.8,
    upper_relief_offset_y = 4.5,
    lower_relief_offset_y = -4.5
) {
    union() {
        circle(r = main_r, $fn = 96);
        translate([0, upper_relief_offset_y]) circle(r = upper_relief_r, $fn = 32);
        translate([0, lower_relief_offset_y]) circle(r = lower_relief_r, $fn = 32);
    }
}

module e2_top_cutout(
    cutout_d = 12.0,
    cutout_h = 0.8,
    cutout_z = 0.4
) {
    translate([0, 0, cutout_z])
        cylinder(d = cutout_d, h = cutout_h, center = true, $fn = 96);
}

module part_e2(
    outer_d = 17.20,
    thickness = 1.60,
    tooth_count = 32,
    root_d = 14.96,
    tip_land_w = 0.28,
    shoulder_d = 16.36,
    shoulder_deg = 2.30,
    throat_d = 15.20,
    throat_deg = 1.42,
    root_deg = undef,
    tooth_cut_angle_deg = 90,
    bore_main_r = 4.5,
    bore_upper_relief_r = 0.8,
    bore_lower_relief_r = 0.8,
    bore_upper_relief_offset_y = 4.5,
    bore_lower_relief_offset_y = -4.5,
    top_cutout_d = 12.0,
    top_cutout_h = 0.8,
    top_cutout_z = 0.4
) {
    difference() {
        linear_extrude(height = thickness, center = true)
            e2_gear_profile_2d(
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
                e2_center_bore_2d(
                    main_r = bore_main_r,
                    upper_relief_r = bore_upper_relief_r,
                    lower_relief_r = bore_lower_relief_r,
                    upper_relief_offset_y = bore_upper_relief_offset_y,
                    lower_relief_offset_y = bore_lower_relief_offset_y
                );

        e2_top_cutout(
            cutout_d = top_cutout_d,
            cutout_h = top_cutout_h,
            cutout_z = top_cutout_z
        );
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_e2();
}
