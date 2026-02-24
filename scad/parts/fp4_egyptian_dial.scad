// part_id: fp4
// name: Front plate Egyptian dial ring
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_fp4(
    outer_d = 163.4,
    inner_d = 148.1,
    thickness = 1.6,
    tick_d = 0.35,
    major_tick_h = 1.6,
    minor_tick_h = 0.8,
    tick_count = 360
) {
    difference() {
        cylinder(d = outer_d, h = thickness, center = false, $fn = 220);
        translate([0, 0, -0.05]) cylinder(d = inner_d, h = thickness + 0.1, center = false, $fn = 220);
    }

    // Raised minute/hour ticks around the ring as simplified engraving geometry.
    for (i = [0 : tick_count - 1]) {
        a = i * 360 / tick_count;
        h = (i % 30 == 0) ? major_tick_h : minor_tick_h;
        rotate([0, 0, a])
            translate([outer_d / 2 - 1.2, 0, thickness])
                cube([1.0, tick_d, h], center = true);
    }
}
