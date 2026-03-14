// part_id: h1
// name: Exeligmos main gear
// source_drawing_ids: DRW-009
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_h1(
    outer_r = 13.99,
    root_r = 12.98,
    thickness = 1.6,
    bore_d = 4.0,
    teeth = 68
) {
    difference() {
        linear_extrude(height = thickness)
        union() {
            circle(r = root_r, $fn = 180);
            for (i = [0 : teeth - 1]) {
                a = i * 360 / teeth;
                rotate([0, 0, a]) translate([root_r, 0, 0]) square([outer_r - root_r, 0.78], center = true);
            }
        }
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.1, $fn = 36);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_h1();
}
