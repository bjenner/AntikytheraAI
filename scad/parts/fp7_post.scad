// part_id: fp7
// name: Front plate support post (short)
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_fp7(
    width = 5.0,
    depth = 3.5,
    height = 19.5,
    hole_d = 1.5,
    hole_z = 15.5
) {
    difference() {
        cube([width, depth, height], center = false);
        translate([width / 2, depth / 2, hole_z]) rotate([90, 0, 0])
            cylinder(d = hole_d, h = depth + 0.2, center = true, $fn = 24);
    }
}
