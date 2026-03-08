// part_id: a12
// name: A12 link
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

// 2D profile based on DRW-001 sheet 5 callouts:
// - left eye outer R5 with center hole d=3
// - right eye outer R2.5 with center hole d=3
// - center spacing between holes = 19.5
// - left tongue thickness ~1.5 and reach ~7 from left eye center
// - upper transition uses a tighter shoulder (R4.5 style) than lower contour
module a12_profile_2d(
    c2c = 19.5,
    r_left = 5.0,
    r_right = 2.5,
    hole_d = 3.0,
    tongue_len = 7.0,
    tongue_th = 1.5,
    neck_x = 4.25,
    shoulder_r = 4.5,
    offset = 2.5
) {
    difference() {
        union() {
            // Main link bar with right rounded eye.
            hull() {
                translate([neck_x-3, -offset]) circle(r = r_right, $fn = 72);
                translate([c2c, -offset]) circle(r = r_right, $fn = 72);
            }

            // Left large eye (lower contour remains full R5).
            translate([0, 0]) circle(r = r_left, $fn = 96);

            // Upper shoulder blend (R4.5-style transition).
            // Shifted upward slightly so the top contour is tighter than the lower lobe.
//            translate([0.7, 0.82]) circle(r = shoulder_r, $fn = 96);

            // Left tongue/tab with asymmetric taper to better match the drawing silhouette.
            hull() { 
                translate([-tongue_len + 0.45, tongue_th]) circle(r = tongue_th * 0.22, $fn = 36);
                translate([-3.05,  0.56]) circle(r = tongue_th * 0.28, $fn = 44);
                translate([-2.65, -0.42]) circle(r = tongue_th * 0.36, $fn = 44);
            }
        }

        translate([0, 0]) circle(d = hole_d, $fn = 48);
        translate([c2c, -offset]) circle(d = hole_d, $fn = 48);
    }
}

module part_a12(th = 1.0) {
    linear_extrude(height = th)
        a12_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a12();
}
