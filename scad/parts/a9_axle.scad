// part_id: a9
// name: A9 axle
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a9(body_d = 9, body_h = 32, upper_d = 8, upper_h = 11.4, shoulder_d = 14, shoulder_h = 1.8) {
    union() {
        cylinder(d = body_d, h = body_h, center = false);
        translate([0, 0, body_h]) cylinder(d = upper_d, h = upper_h, center = false);
        translate([0, 0, body_h - shoulder_h]) cylinder(d = shoulder_d, h = shoulder_h, center = false);
        translate([0, 0, -1.2]) cylinder(d = body_d * 0.9, h = 1.2, center = false);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a9();
}
