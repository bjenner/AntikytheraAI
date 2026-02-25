// part_id: jup13
// name: Jupiter pointer arm
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module jup13_profile_2d(
    arm_len = 51.5,
    arm_w = 4.0,
    hub_od = 21.5,
    hub_id = 19.5,
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
                circle(d = hub_od, $fn = 88);
                circle(d = hub_id, $fn = 88);
            }
        }
        translate([-arm_len, 0]) circle(d = end_hole_d, $fn = 24);
        translate([arm_len, 0]) circle(d = end_hole_d, $fn = 24);
    }
}

module part_jup13(thickness = 1.0) {
    linear_extrude(height = thickness) jup13_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup13();
}
