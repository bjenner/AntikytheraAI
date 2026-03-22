// part_id: d6
// name: D6 disk
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part D6: stepped disk shown on DRW-004 sheet 15.
//
// Local origin convention:
// - XY origin is the disk axis.
// - Z origin is the part midplane.

module d6_bore_2d(
    core_r = 2.0,
    lobe_r = 0.75,
    lobe_center_offset_y = 2.0
) {
    union() {
        circle(r = core_r, $fn = 48);
        translate([0, lobe_center_offset_y, 0])
            circle(r = lobe_r, $fn = 32);
        translate([0, -lobe_center_offset_y, 0])
            circle(r = lobe_r, $fn = 32);
    }
}

module d6_outer_body(
    outer_d = 20.0,
    outer_h = 2.7,
    outer_top_z = 2.0,
    bottom_round_r = 0.5
) {
    outer_r = outer_d / 2;
    bottom_z = outer_top_z - outer_h;
    round_steps = 8;
    round_center_r = outer_r - bottom_round_r;
    round_center_z = bottom_z + bottom_round_r;
    profile_points = concat(
        [[0, bottom_z], [max(outer_r - bottom_round_r, 0.01), bottom_z]],
        [
            for (a = [270 : 90 / round_steps : 360])
                [
                    round_center_r + bottom_round_r * cos(a),
                    round_center_z + bottom_round_r * sin(a)
                ]
        ],
        [[outer_r, outer_top_z], [0, outer_top_z]]
    );

    rotate_extrude($fn = 96)
        polygon(points = profile_points);
}

module part_d6(
    inner_d = 6.9,
    inner_h = 6.0,
    mid_d = 17.0,
    mid_h = 3.7,
    outer_d = 20.0,
    outer_h = 2.7,
    outer_top_drop = 1.0,
    outer_bottom_round_r = 0.5,
    upper_relief_d = 14.0,
    upper_relief_h = 2.5,
    upper_relief_top_offset = 0.3,
    preview_cut_w = 20.0,
    preview_cut_d = 20.0,
    preview_cut_h = 1.0,
    preview_cut_front_edge_y = -6.0,
    preview_cut_top_drop = 1.2,
    bore_core_r = 2.0,
    bore_lobe_r = 0.75,
    bore_lobe_center_offset_y = 2.0
) {
    overall_h = inner_h;
    top_z = overall_h / 2;
    inner_center_z = top_z - inner_h / 2;
    mid_center_z = top_z - mid_h / 2;
    outer_top_z = top_z - outer_top_drop;
    outer_center_z = outer_top_z - outer_h / 2;
    upper_relief_top_z = top_z + upper_relief_top_offset;
    upper_relief_center_z = upper_relief_top_z - upper_relief_h / 2;
    preview_cut_center_y = preview_cut_front_edge_y - preview_cut_d / 2;
    preview_cut_top_z = top_z - preview_cut_top_drop;
    preview_cut_center_z = preview_cut_top_z - preview_cut_h / 2;

    difference() {
        union() {
            d6_outer_body(
                outer_d = outer_d,
                outer_h = outer_h,
                outer_top_z = outer_top_z,
                bottom_round_r = outer_bottom_round_r
            );
            translate([0, 0, mid_center_z])
                cylinder(d = mid_d, h = mid_h, center = true, $fn = 96);
            translate([0, 0, inner_center_z])
                cylinder(d = inner_d, h = inner_h, center = true, $fn = 96);
        }

        linear_extrude(height = overall_h + 0.2, center = true)
            d6_bore_2d(
                core_r = bore_core_r,
                lobe_r = bore_lobe_r,
                lobe_center_offset_y = bore_lobe_center_offset_y
            );

        translate([0, 0, upper_relief_center_z])
            cylinder(d = upper_relief_d, h = upper_relief_h, center = true, $fn = 96);

        translate([0, preview_cut_center_y, preview_cut_center_z])
            cube([preview_cut_w, preview_cut_d, preview_cut_h], center = true);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_d6();
}
