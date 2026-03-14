// part_id: cp2
// name: Slider (Metonic/Saros)
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cp2(w = 6.2, d = 4.2, h = 4.2,
                slot_w = 4.2, slot_h = 2.2,
                pin_d = 1.0, pin_h = 3.0,
                fork_w = 1.0, fork_gap = 0.6, fork_h = 1.6) {
    difference() {
        union() {
            translate([-w / 2, -d / 2, 0]) cube([w, d, h], center = false);
            // Lower pin.
            translate([0, 0, -pin_h]) cylinder(d = pin_d, h = pin_h, center = false, $fn = 24);
            // Small fork extension.
            translate([w / 2, -fork_w - fork_gap / 2, 0.8]) cube([1.4, fork_w, fork_h], center = false);
            translate([w / 2, fork_gap / 2, 0.8]) cube([1.4, fork_w, fork_h], center = false);
        }

        // Window slot through the body.
        translate([-slot_w / 2, -d / 2 - 0.1, (h - slot_h) / 2])
            cube([slot_w, d + 0.2, slot_h], center = false);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cp2();
}
