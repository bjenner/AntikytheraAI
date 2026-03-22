// part_id: d3
// name: D3 pin
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part D3: stepped pin with a broad head shown on DRW-004 sheet 12.
//
// Local origin convention:
// - XY origin is the pin axis.
// - Z origin is the part midplane.

module part_d3(
    head_d = 9.0,
    head_h = 2.0,
    head_top_round_r = 0.5,
    core_d = 4.0,
    core_h = 8.0,
    core_bottom_round_r = 0.5,
    side_post_r = 0.75,
    side_post_h = 5.0,
    side_post_y = 2.0,
    notch_block_w = 3.0,
    notch_block_d = 5.0,
    notch_block_h = 1.0,
    notch_cut_depth = 0.75,
    notch_top_above_core_base = 3.0
) {
    cap_bottom_z = core_h / 2;
    cap_top_z = cap_bottom_z + head_h;
    head_r = head_d / 2;
    head_round_steps = 8;
    head_round_center_r = head_r - head_top_round_r;
    head_round_center_z = cap_top_z - head_top_round_r;
    head_profile_points = concat(
        [[0, cap_bottom_z], [head_r, cap_bottom_z], [head_r, cap_top_z - head_top_round_r]],
        [
            for (a = [0 : 90 / head_round_steps : 90])
                [
                    head_round_center_r + head_top_round_r * cos(a),
                    head_round_center_z + head_top_round_r * sin(a)
                ]
        ],
        [[0, cap_top_z]]
    );
    side_post_center_z = cap_bottom_z - side_post_h / 2;
    core_base_z = -core_h / 2;
    core_r = core_d / 2;
    core_round_steps = 8;
    core_round_center_r = core_r - core_bottom_round_r;
    core_round_center_z = core_base_z + core_bottom_round_r;
    core_profile_points = concat(
        [[0, core_base_z]],
        [
            for (a = [270 : 90 / core_round_steps : 360])
                [
                    core_round_center_r + core_bottom_round_r * cos(a),
                    core_round_center_z + core_bottom_round_r * sin(a)
                ]
        ],
        [[core_r, core_h / 2], [0, core_h / 2]]
    );
    notch_center_z = core_base_z + notch_top_above_core_base - notch_block_h / 2;
    // Keep the notch cuts shallow enough that a solid web remains through the core.
    notch_center_x = core_d / 2 + notch_block_w / 2 - notch_cut_depth;

    difference() {
        union() {
            rotate_extrude($fn = 72)
                polygon(points = head_profile_points);

            rotate_extrude($fn = 72)
                polygon(points = core_profile_points);

            for (y = [-side_post_y, side_post_y]) {
                translate([0, y, side_post_center_z])
                    cylinder(r = side_post_r, h = side_post_h, center = true, $fn = 36);
            }
        }

        for (x = [-notch_center_x, notch_center_x]) {
            translate([x, 0, notch_center_z])
                cube([notch_block_w, notch_block_d, notch_block_h], center = true);
        }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_d3();
}
