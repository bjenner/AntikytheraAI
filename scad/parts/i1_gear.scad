// part_id: i1
// name: Exeligmos gear
// source_drawing_ids: DRW-009
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_i1(
    outer_r = 13.39,
    root_r = 12.50,
    thickness = 1.6,
    bore_d = 6.0,
    teeth = 66
) {
    difference() {
        linear_extrude(height = thickness)
        union() {
            circle(r = root_r, $fn = 180);
            for (i = [0 : teeth - 1]) {
                a = i * 360 / teeth;
                rotate([0, 0, a]) translate([root_r, 0, 0]) square([outer_r - root_r, 0.9], center = true);
            }
        }
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 42);
    }
}
