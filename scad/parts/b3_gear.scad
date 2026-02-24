// part_id: b3
// name: B3 companion gear
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b3_gear_2d(outer_d = 18.0, root_d = 16.2, tooth_count = 26, bore_d = 4.0) {
    difference() {
        union() {
            circle(d = root_d, $fn = 90);
            for (i = [0 : tooth_count - 1])
                rotate(i * 360 / tooth_count)
                    translate([outer_d / 2 - 0.45, 0])
                        square([0.85, 0.65], center = true);
        }
        circle(d = bore_d, $fn = 40);
    }
}

module part_b3(thickness = 1.6) {
    linear_extrude(height = thickness)
        b3_gear_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b3();
}
