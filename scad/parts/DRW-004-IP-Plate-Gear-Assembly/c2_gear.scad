// part_id: c2
// name: C2 gear
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part C2: smaller coaxial gear from the b/c gear train.
//
// Local origin convention:
// - XY origin is the gear rotation axis.
// - Z origin is the part midplane.
// - Assembly placement and animation should be applied outside this file.

function c2_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

module c2_tooth_gap_2d(
    outer_r = 11.25,
    root_r = 10.24,
    pitch_deg = 360 / 42,
    tip_land_deg = 1.25,
    shoulder_r = 10.80,
    shoulder_deg = 1.84,
    throat_r = 10.36,
    throat_deg = 1.13,
    root_deg = 0.56
) {
    gap_half_deg = max((pitch_deg - tip_land_deg) / 2, throat_deg + 0.15);

    polygon(points = [
        c2_polar(outer_r + 0.2, -gap_half_deg),
        c2_polar(shoulder_r, -shoulder_deg),
        c2_polar(throat_r, -throat_deg),
        c2_polar(root_r, -root_deg),
        c2_polar(root_r, root_deg),
        c2_polar(throat_r, throat_deg),
        c2_polar(shoulder_r, shoulder_deg),
        c2_polar(outer_r + 0.2, gap_half_deg)
    ]);
}

module c2_gear_profile_2d(
    outer_d = 22.50,
    root_d = 20.48,
    tooth_count = 42,
    tip_land_deg = 1.25,
    shoulder_d = 21.60,
    shoulder_deg = 1.84,
    throat_d = 20.72,
    throat_deg = 1.13,
    root_deg = 0.56,
    tooth_cut_count = undef,
    tooth_cut_start = -1,
    tooth_cut_angle_deg = 90
) {
    pitch_deg = 360 / tooth_count;
    cut_count = is_undef(tooth_cut_count) ? tooth_count : tooth_cut_count;

    difference() {
        circle(d = outer_d, $fn = max(160, tooth_count * 4));
        for (i = [0 : cut_count - 1]) {
            rotate(tooth_cut_angle_deg + (tooth_cut_start + i) * pitch_deg)
                c2_tooth_gap_2d(
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

module c2_center_bore_2d(bore_d = 3.5, relief_r = 0.75) {
    union() {
        circle(d = bore_d, $fn = 48);
        translate([0, -bore_d / 2]) circle(r = relief_r, $fn = 36);
    }
}

module part_c2(
    outer_d = 22.50,
    thickness = 2.0,
    tooth_count = 42,
    root_d = 20.48,
    tip_land_deg = 1.25,
    shoulder_d = 21.60,
    shoulder_deg = 1.84,
    throat_d = 20.72,
    throat_deg = 1.13,
    root_deg = 0.56,
    tooth_cut_count = undef,
    tooth_cut_start = -1,
    tooth_cut_angle_deg = 90,
    bore_d = 3.5,
    lower_relief_r = 0.75,
    side_hole_d = 1.50,
    side_hole_radius = 6.50
) {
    difference() {
        linear_extrude(height = thickness, center = true)
            c2_gear_profile_2d(
                outer_d = outer_d,
                root_d = root_d,
                tooth_count = tooth_count,
                tip_land_deg = tip_land_deg,
                shoulder_d = shoulder_d,
                shoulder_deg = shoulder_deg,
                throat_d = throat_d,
                throat_deg = throat_deg,
                root_deg = root_deg,
                tooth_cut_count = tooth_cut_count,
                tooth_cut_start = tooth_cut_start,
                tooth_cut_angle_deg = tooth_cut_angle_deg
            );

        translate([0, 0, -thickness / 2 - 0.1])
            linear_extrude(height = thickness + 0.2)
                c2_center_bore_2d(
                    bore_d = bore_d,
                    relief_r = lower_relief_r
                );

        for (x = [-side_hole_radius, side_hole_radius]) {
            translate([x, 0, 0])
                cylinder(d = side_hole_d, h = thickness + 0.2, center = true, $fn = 36);
        }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_c2();
}
