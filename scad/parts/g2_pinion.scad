// part_id: g2
// name: Exeligmos pinion gear (g2)
// source_drawing_ids: DRW-009
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_g2(
    outer_r = 4.96,
    root_r = 3.95,
    thickness = 1.6,
    bore_d = 2.0,
    teeth = 16,
    hub_d = 4.0,
    hub_h = 0.6
) {
    difference() {
        union() {
            linear_extrude(height = thickness)
            union() {
                circle(r = root_r, $fn = 96);
                for (i = [0 : teeth - 1]) {
                    a = i * 360 / teeth;
                    rotate([0, 0, a]) translate([root_r, 0, 0]) square([outer_r - root_r, 0.58], center = true);
                }
            }
            translate([0, 0, thickness]) cylinder(d = hub_d, h = hub_h, center = false, $fn = 30);
        }
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + hub_h + 0.1, $fn = 24);
    }
}
