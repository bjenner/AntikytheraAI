// part_id: dat1
// name: Date pointer arm with central ring
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module dat1_profile_2d(
    arm_len = 63.5,
    arm_w = 4.0,
    hub_od = 25.0,
    hub_id = 18.5,
    end_hole_d = 1.0
) {
    difference() {
        union() {
            hull() {
                translate([-arm_len, 0]) circle(d = arm_w, $fn = 36);
                circle(d = arm_w, $fn = 36);
            }
            hull() {
                translate([arm_len, 0]) circle(d = arm_w, $fn = 36);
                circle(d = arm_w, $fn = 36);
            }
            difference() {
                circle(d = hub_od, $fn = 96);
                circle(d = hub_id, $fn = 96);
            }
        }
        translate([-arm_len, 0]) circle(d = end_hole_d, $fn = 24);
        translate([arm_len, 0]) circle(d = end_hole_d, $fn = 24);
    }
}

module part_dat1(thickness = 1.0) {
    linear_extrude(height = thickness) dat1_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_dat1();
}
