// part_id: fp10
// name: Zodiac angle measurement pointer
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module fp10_profile_2d(
    arm_len = 74.0,
    arm_w = 1.6,
    hub_od = 15.5,
    hub_id = 10.0
) {
    difference() {
        union() {
            hull() {
                translate([-arm_len, 0]) circle(d = arm_w, $fn = 24);
                circle(d = arm_w, $fn = 24);
            }
            hull() {
                translate([arm_len, 0]) circle(d = arm_w, $fn = 24);
                circle(d = arm_w, $fn = 24);
            }
            circle(d = hub_od, $fn = 84);
        }
        circle(d = hub_id, $fn = 72);
    }
}

module part_fp10(
    thickness = 1.0,
    end_hook_l = 2.4,
    end_hook_h = 1.0
) {
    linear_extrude(height = thickness) fp10_profile_2d();

    // End return tabs to match the bent pointer ends shown in DRW-010 sheet 9.
    translate([-74.0 - end_hook_l, -0.55, thickness - end_hook_h])
        cube([end_hook_l, 1.1, end_hook_h], center = false);
    translate([74.0, -0.55, thickness - end_hook_h])
        cube([end_hook_l, 1.1, end_hook_h], center = false);
}
