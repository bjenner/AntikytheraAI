// part_id: a10
// name: A10 disc
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module a10_center_slot(slot_l = 4.2, slot_w = 1.6, pin_d = 3.0) {
    hull() {
        translate([ slot_l / 2, 0]) circle(d = slot_w, $fn = 32);
        translate([-slot_l / 2, 0]) circle(d = slot_w, $fn = 32);
    }
    circle(d = pin_d, $fn = 36);
}

module part_a10(od = 111, th = 2, center_hole_d = 9) {
    difference() {
        cylinder(d = od, h = th, center = false);
        translate([0, 0, -0.1]) cylinder(d = center_hole_d, h = th + 0.2, center = false);
        translate([0, 0, -0.1]) linear_extrude(height = th + 0.2) a10_center_slot();
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a10();
}
