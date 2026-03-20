// Shared scaffold helpers for DRW-005 Sheet 3 fork parts.
// Keeps cp-f1 through cp-f6 dimension-driven and easy to tune from the drawing.
// SPDX-License-Identifier: MIT

module cpf_fork_profile_2d(
    body_r,
    slot_w,
    slot_l,
    overall_w,
    overall_l,
    shoulder_r,
    tip_r,
    center = true
) {
    stem_x = slot_w / 2 + (overall_w - slot_w) / 2;
    stem_w = overall_w - slot_w;
    top_y = overall_l - tip_r;
    shoulder_y = max(body_r * 0.55, overall_l - slot_l - shoulder_r);
    slot_floor_y = max(0, overall_l - slot_l - slot_w / 2);
    y_center = (overall_l - body_r) / 2;

    translate([0, center ? -y_center : 0])
    difference() {
        union() {
            circle(r = body_r, $fn = 96);

            hull() {
                circle(r = body_r, $fn = 96);
                for (side = [-1, 1]) {
                    translate([side * (slot_w / 2 + shoulder_r), shoulder_y])
                        circle(r = shoulder_r, $fn = 48);
                }
            }

            for (side = [-1, 1]) {
                hull() {
                    translate([side * (slot_w / 2 + shoulder_r), shoulder_y])
                        circle(r = shoulder_r, $fn = 48);
                    translate([side * stem_x, top_y])
                        circle(r = tip_r, $fn = 36);
                }

                translate([side * stem_x - stem_w / 2, shoulder_y])
                    square([stem_w, max(0.01, top_y - shoulder_y)], center = false);
            }
        }

        union() {
            hull() {
                translate([0, slot_floor_y]) circle(r = slot_w / 2, $fn = 48);
                translate([0, overall_l - slot_w / 2])
                    circle(r = slot_w / 2, $fn = 48);
            }

            translate([-slot_w / 2, slot_floor_y])
                square([slot_w, max(0.01, overall_l - slot_w / 2 - slot_floor_y)], center = false);
        }
    }
}

module cpf_fork_part(
    body_r,
    slot_w,
    slot_l,
    overall_w,
    overall_l,
    shoulder_r,
    tip_r,
    thickness = 1.0,
    center = true
) {
    linear_extrude(height = thickness)
        cpf_fork_profile_2d(
            body_r = body_r,
            slot_w = slot_w,
            slot_l = slot_l,
            overall_w = overall_w,
            overall_l = overall_l,
            shoulder_r = shoulder_r,
            tip_r = tip_r,
            center = center
        );
}
