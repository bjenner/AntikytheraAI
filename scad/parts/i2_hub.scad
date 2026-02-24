// part_id: i2
// name: Exeligmos stepped hub
// source_drawing_ids: DRW-009
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_i2(
    flange_d = 12.0,
    flange_h = 4.0,
    mid_d = 8.0,
    mid_h = 5.2,
    top_d = 6.0,
    top_h = 7.5,
    neck_d = 3.9,
    neck_h = 3.9,
    through_d = 2.0
) {
    difference() {
        union() {
            cylinder(d = flange_d, h = flange_h, center = false, $fn = 80);
            translate([0, 0, flange_h]) cylinder(d = mid_d, h = mid_h, center = false, $fn = 70);
            translate([0, 0, flange_h + mid_h]) cylinder(d = top_d, h = top_h, center = false, $fn = 60);
            translate([0, 0, -neck_h]) cylinder(d = neck_d, h = neck_h, center = false, $fn = 40);
        }
        translate([0, 0, -neck_h - 0.05]) cylinder(d = through_d, h = flange_h + mid_h + top_h + neck_h + 0.1, $fn = 32);
        translate([0, 0, flange_h + mid_h + top_h - 2.2]) cube([1.9, 0.9, 2.4], center = true);
    }
}
