// part_id: mar12
// name: Mars pointer arm
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module mar12_profile_2d(
    arm_len = 45.5,
    arm_w = 4.0,
    hub_od = 20.0,
    hub_id = 18.0,
    end_hole_d = 1.0
) {
    difference() {
        union() {
            hull() {
                translate([-arm_len, 0]) circle(d = arm_w, $fn = 32);
                circle(d = arm_w, $fn = 32);
            }
            hull() {
                translate([arm_len, 0]) circle(d = arm_w, $fn = 32);
                circle(d = arm_w, $fn = 32);
            }
            difference() {
                circle(d = hub_od, $fn = 100);
                circle(d = hub_id, $fn = 100);
            }
        }
        translate([-arm_len, 0]) circle(d = end_hole_d, $fn = 24);
        translate([arm_len, 0]) circle(d = end_hole_d, $fn = 24);
    }
}

module part_mar12(thickness = 1.0) {
    linear_extrude(height = thickness) mar12_profile_2d();
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar12();
}
