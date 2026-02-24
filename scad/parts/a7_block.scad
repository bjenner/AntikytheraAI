// part_id: a7
// name: A7 block
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a7(w = 12, d = 8, h = 24, bore_d = 8, top_pin_d = 4, top_pin_h = 3) {
    difference() {
        union() {
            translate([-w / 2, -d / 2, 0]) cube([w, d, h], center = false);
            translate([0, 0, h]) cylinder(d = top_pin_d, h = top_pin_h, center = false);
            translate([0, 0, h + top_pin_h]) cylinder(d = top_pin_d + 1.2, h = 1.2, center = false);
        }
        translate([0, 0, h * 0.45]) rotate([90, 0, 0]) cylinder(d = bore_d, h = d + 0.2, center = true);
        for (x = [-3, 3]) translate([x, d / 2 - 1.2, h - 2.5]) cylinder(d = 2.0, h = 2.6, center = false);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a7();
}
