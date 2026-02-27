// part_id: b0
// name: B0 small gear
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b0_gear_2d(outer_d = 11.5, root_d = 9.2, tooth_count = 20, bore_d = 4.6) {
    difference() {
        union() {
            circle(d = root_d, $fn = 80);
            for (i = [0 : tooth_count - 1])
                rotate(i * 360 / tooth_count)
                    translate([outer_d / 2 - 0.5, 0])
                        square([0.85, 0.65], center = true);
        }
        circle(d = bore_d, $fn = 42);
    }
}

module part_b0(thickness = 1.0) {
    linear_extrude(height = thickness)
        b0_gear_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b0();
}
