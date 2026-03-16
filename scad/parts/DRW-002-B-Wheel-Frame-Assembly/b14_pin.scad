// part_id: b14
// name: B14 sleeve
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b14(outer_d = 1.5, bore_d = 0.4, h = 5.0) {
    translate([0, 0, -h / 2])
        difference() {
            cylinder(d = outer_d, h = h, center = false, $fn = 40);
            translate([0, 0, -0.1])
                cylinder(d = bore_d, h = h + 0.2, center = false, $fn = 28);
        }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b14();
}
