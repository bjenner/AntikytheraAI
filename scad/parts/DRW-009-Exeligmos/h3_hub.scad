// part_id: h3
// name: Exeligmos stepped hub shaft
// source_drawing_ids: DRW-009
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_h3(
    flange_d = 12.0,
    flange_h = 2.1,
    body_d = 7.8,
    body_h = 8.0,
    stem_d = 4.9,
    stem_h = 6.2,
    tip_d = 2.9,
    tip_h = 2.0,
    lower_d = 4.0,
    lower_h = 1.8,
    through_d = 2.0
) {
    difference() {
        union() {
            translate([0, 0, lower_h]) cylinder(d = flange_d, h = flange_h, center = false, $fn = 96);
            cylinder(d = body_d, h = body_h + lower_h, center = false, $fn = 80);
            translate([0, 0, body_h + lower_h]) cylinder(d = stem_d, h = stem_h, center = false, $fn = 70);
            translate([0, 0, body_h + lower_h + stem_h]) cylinder(d = tip_d, h = tip_h, center = false, $fn = 60);
            cylinder(d = lower_d, h = lower_h, center = false, $fn = 48);
        }
        translate([0, 0, -0.05]) cylinder(d = through_d, h = body_h + lower_h + flange_h + stem_h + tip_h + 0.1, $fn = 30);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_h3();
}
