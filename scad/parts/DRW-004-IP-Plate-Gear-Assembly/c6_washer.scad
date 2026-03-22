// part_id: c6
// name: C6 stepped washer
// source_drawing_ids: DRW-004
// units: mm
// SPDX-License-Identifier: MIT
//
// Part C6: small stepped washer/bush used in the c gear train.
//
// Local origin convention:
// - XY origin is the washer axis.
// - Z origin is the part midplane.

module c6_outer_body(outer_d = 8.0, height = 2.5, top_edge_r = 0.4) {
    outer_r = outer_d / 2;
    top_z = height / 2;
    core_h = max(height - top_edge_r, 0.01);
    top_band_h = min(top_edge_r, height);
    top_band_d = max(outer_d - 2 * top_edge_r, 0.01);

    union() {
        translate([0, 0, -top_edge_r / 2])
            cylinder(d = outer_d, h = core_h, center = true, $fn = 96);

        translate([0, 0, top_z - top_band_h / 2])
            cylinder(d = top_band_d, h = top_band_h, center = true, $fn = 96);

        rotate_extrude($fn = 96)
            translate([outer_r - top_edge_r, top_z - top_edge_r])
                circle(r = top_edge_r, $fn = 32);
    }
}

module part_c6(
    outer_d = 8.0,
    bore_d = 3.5,
    height = 2.5,
    top_edge_r = 0.4,
    debug_block_w = 4.0,
    debug_block_d = 8.0,
    debug_block_h = 1.0,
    debug_block_gap_from_center = 1.0,
    debug_block_base_offset = 0.8
) {
    part_base_z = -height / 2;
    debug_block_center_z = part_base_z + debug_block_base_offset + debug_block_h / 2;
    debug_block_center_x = debug_block_gap_from_center + debug_block_w / 2;

    difference() {
        c6_outer_body(
            outer_d = outer_d,
            height = height,
            top_edge_r = top_edge_r
        );

        union() {
            cylinder(d = bore_d, h = height + 0.2, center = true, $fn = 64);
            translate([debug_block_center_x, 0, debug_block_center_z])
                cube([debug_block_w, debug_block_d, debug_block_h], center = true);
            translate([-debug_block_center_x, 0, debug_block_center_z])
                cube([debug_block_w, debug_block_d, debug_block_h], center = true);
        }
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_c6();
}
