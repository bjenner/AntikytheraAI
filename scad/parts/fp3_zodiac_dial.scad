// part_id: fp3
// name: Zodiac dial ring
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_fp3(
    outer_d = 148.0,
    inner_d = 132.0,
    thickness = 1.6,
    tick_count = 360
) {
    difference() {
        cylinder(d = outer_d, h = thickness, center = false, $fn = 220);
        translate([0, 0, -0.05]) cylinder(d = inner_d, h = thickness + 0.1, center = false, $fn = 220);
    }

    // Simplified zodiac/minute marks.
    for (i = [0 : tick_count - 1]) {
        a = i * 360 / tick_count;
        h = (i % 30 == 0) ? 1.2 : 0.7;
        rotate([0, 0, a])
            translate([outer_d / 2 - 1.0, 0, thickness])
                cube([0.9, 0.24, h], center = true);
    }
}
