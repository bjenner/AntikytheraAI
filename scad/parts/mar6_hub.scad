// part_id: mar6
// name: Mars press-fit hub
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar6(
    flange_d = 7.0,
    body_d = 5.5,
    pin_d = 4.0,
    center_d = 1.0,
    total_h = 6.0,
    flange_h = 2.0,
    body_h = 3.0,
    pin_h = 1.0,
    ear_l = 2.0,
    ear_w = 1.2,
    ear_h = 1.0
) {
    difference() {
        union() {
            cylinder(d = flange_d, h = flange_h, center = false, $fn = 56);
            translate([0, 0, flange_h]) cylinder(d = body_d, h = body_h, center = false, $fn = 56);
            translate([0, 0, flange_h + body_h]) cylinder(d = pin_d, h = pin_h, center = false, $fn = 48);
            translate([body_d / 2 - 0.2, -ear_w / 2, flange_h + 0.3]) cube([ear_l, ear_w, ear_h], center = false);
        }
        translate([0, 0, -0.05]) cylinder(d = center_d, h = total_h + 0.1, center = false, $fn = 20);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar6();
}
