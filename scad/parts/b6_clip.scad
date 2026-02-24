// part_id: b6
// name: B6 clip block
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b6(w = 5.0, d = 3.0, h = 5.0,
               pin_d = 2.5, pin_h = 2.0,
               slot_w = 2.0, hole_d = 2.0) {
    difference() {
        union() {
            // Main body.
            translate([-w / 2, -d / 2, pin_h]) cube([w, d, h], center = false);
            // Bottom fitted pin.
            cylinder(d = pin_d, h = pin_h, center = false, $fn = 36);
        }

        // Through side hole.
        translate([0, 0, pin_h + h * 0.55]) rotate([90, 0, 0]) cylinder(d = hole_d, h = d + 0.2, center = true, $fn = 28);

        // Top slot/notch.
        translate([-slot_w / 2, -d / 2 - 0.1, pin_h + h - 2.6]) cube([slot_w, d + 0.2, 2.6], center = false);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b6();
}
