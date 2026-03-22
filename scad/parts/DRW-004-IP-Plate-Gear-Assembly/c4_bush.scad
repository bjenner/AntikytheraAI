// part_id: c4
// name: C4 stepped bush
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part C4: stepped bush/hub associated with the c gear train.
//
// Local origin convention:
// - XY origin is the rotation axis.
// - Z origin is the part midplane for easier assembly rotation.

module part_c4(
    body_d = 3.5,
    body_h = 8.5,
    flange_d = 5.9,
    flange_h = 2.05,
    flange_top_offset = 2.5,
    side_boss_r = 0.75,
    notch_block_w = 4.0,
    notch_block_d = 4.0,
    notch_block_h = 0.7,
    notch_block_gap_from_axis = 1.0,
    notch_block_z_offset = 0.7
) {
    body_top_z = body_h / 2;
    flange_top_z = body_top_z - flange_top_offset;
    flange_bottom_z = flange_top_z - flange_h;
    lower_stem_h = flange_bottom_z + body_h / 2;
    lower_stem_center_z = -body_h / 2 + lower_stem_h / 2;
    side_boss_center_x = body_d / 2;
    notch_block_center_z = flange_top_z + notch_block_z_offset + notch_block_h / 2;
    notch_block_center_x = notch_block_gap_from_axis + notch_block_w / 2;

    difference() {
        union() {
            cylinder(d = body_d, h = body_h, center = true, $fn = 64);
            translate([0, 0, flange_top_z - flange_h / 2])
                cylinder(d = flange_d, h = flange_h, center = true, $fn = 64);
            translate([side_boss_center_x, 0, lower_stem_center_z])
                cylinder(r = side_boss_r, h = lower_stem_h, center = true, $fn = 36);
        }

        union() {
            translate([notch_block_center_x, 0, notch_block_center_z])
                cube([notch_block_w, notch_block_d, notch_block_h], center = true);
            translate([-notch_block_center_x, 0, notch_block_center_z])
                cube([notch_block_w, notch_block_d, notch_block_h], center = true);
        }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_c4();
}
