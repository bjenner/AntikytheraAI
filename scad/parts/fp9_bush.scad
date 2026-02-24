// part_id: fp9
// name: Zodiac angle pointer bush
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_fp9(
    outer_d = 15.5,
    through_d = 7.0,
    counterbore_d = 10.0,
    height = 6.8,
    counterbore_depth = 5.8
) {
    difference() {
        cylinder(d = outer_d, h = height, center = false, $fn = 96);
        translate([0, 0, -0.05]) cylinder(d = through_d, h = height + 0.1, center = false, $fn = 48);
        translate([0, 0, height - counterbore_depth])
            cylinder(d = counterbore_d, h = counterbore_depth + 0.05, center = false, $fn = 64);
    }
}
