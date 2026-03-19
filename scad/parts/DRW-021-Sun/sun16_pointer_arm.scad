// part_id: sun16
// name: Sun pointer arm
// source_drawing_ids: DRW-021
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module sun16_profile_2d(
    center_to_tip = 29.5,
    arm_w = 3.0,
    outer_r = 5.5,
    bore_d = 5.0,
    neck_r = 2.0,
    tip_r = 0.5
) {
    fillet_x = arm_w / 2 + neck_r;
    fillet_y = -sqrt(pow(outer_r + neck_r, 2) - pow(fillet_x, 2));
    stem_top_y = 0;
    stem_bottom_y = -center_to_tip;

    difference() {
        union() {
            circle(r = outer_r, $fn = 96);

            hull() {
                translate([-arm_w / 2 + tip_r, stem_bottom_y + tip_r])
                    circle(r = tip_r, $fn = 24);
                translate([arm_w / 2 - tip_r, stem_bottom_y + tip_r])
                    circle(r = tip_r, $fn = 24);
                translate([-arm_w / 2 + tip_r, stem_top_y - tip_r])
                    circle(r = tip_r, $fn = 24);
                translate([arm_w / 2 - tip_r, stem_top_y - tip_r])
                    circle(r = tip_r, $fn = 24);
            }
        }

        circle(d = bore_d, $fn = 72);

        // Shoulder relief matches the R2 callout where the stem blends into the hub.
        translate([fillet_x, fillet_y]) circle(r = neck_r, $fn = 48);
        translate([-fillet_x, fillet_y]) circle(r = neck_r, $fn = 48);
    }
}

module part_sun16(thickness = 1.7) {
    translate([0, 0, -thickness / 2])
        linear_extrude(height = thickness)
            sun16_profile_2d();
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_sun16();
}
