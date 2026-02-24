// part_id: h2
// name: Exeligmos pinion gear
// source_drawing_ids: DRW-009
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_h2(
    outer_r = 3.60,
    root_r = 2.70,
    thickness = 2.0,
    bore_d = 2.9,
    teeth = 14,
    hub_d = 4.0,
    hub_h = 0.7
) {
    difference() {
        union() {
            linear_extrude(height = thickness)
            union() {
                circle(r = root_r, $fn = 96);
                for (i = [0 : teeth - 1]) {
                    a = i * 360 / teeth;
                    rotate([0, 0, a]) translate([root_r, 0, 0]) square([outer_r - root_r, 0.56], center = true);
                }
            }
            translate([0, 0, thickness]) cylinder(d = hub_d, h = hub_h, center = false, $fn = 30);
        }
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + hub_h + 0.1, $fn = 28);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_h2();
}
