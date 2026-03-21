// part_id: cp-f3
// name: Fork 2W 4D 8L 7T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

function cpf3_body_r() = 3.5;
function cpf3_body_center_y() = -2.0;
function cpf3_shoulder_r() = 2.0;
function cpf3_shoulder_center_x() = 4.5;
function cpf3_shoulder_center_y() =
    sqrt(pow(cpf3_body_r() + cpf3_shoulder_r(), 2) - pow(cpf3_shoulder_center_x(), 2));
function cpf3_tangent_point_y() =
    cpf3_body_r() * cpf3_shoulder_center_y() / (cpf3_body_r() + cpf3_shoulder_r());

module cpf3_trim_window_2d() {
    translate([0, 2.0])
        square([7.0, 16.0], center = true);
}

module cpf3_slot_profile_2d() {
    slot_core_w = 2.0;
    slot_core_h = 4.0;
    slot_stem_h = 8.0;
    side_curve_allowance = 0.4;
    slot_total_w = slot_core_w + side_curve_allowance;
    slot_bottom_r = 2.0;

    union() {
        intersection() {
            circle(r = slot_bottom_r, $fn = 96);
            square([slot_core_w, slot_core_h], center = true);
        }

        translate([-slot_total_w / 2, 0])
            square([slot_total_w, slot_stem_h], center = false);
    }
}

module cpf3_slot_bottom_debug_2d() {
    slot_core_w = 2.0;
    slot_core_h = 4.0;
    slot_bottom_r = 2.0;

    intersection() {
        circle(r = slot_bottom_r, $fn = 96);
        square([slot_core_w, slot_core_h], center = true);
    }
}

module cpf3_slot_bottom_wide_debug_2d() {
    slot_core_w = 2.0;
    slot_core_h = 4.0;
    side_curve_allowance = 0.4;
    slot_total_w = slot_core_w + side_curve_allowance;
    slot_bottom_r = 2.0;

    intersection() {
        circle(r = slot_bottom_r, $fn = 96);
        square([slot_total_w, slot_core_h], center = true);
    }
}

module cpf3_slot_stem_debug_2d() {
    slot_core_w = 2.0;
    slot_stem_h = 8.0;
    side_curve_allowance = 0.4;
    slot_total_w = slot_core_w + side_curve_allowance;

    translate([-slot_total_w / 2, 0])
        square([slot_total_w, slot_stem_h], center = false);
}

module cpf3_slot_tubes_debug_3d(th = 1.0) {
    for (side = [-1, 1]) {
        color([0.18, 0.82, 0.88, 0.85])
            translate([side * 1.2, -2.2, 0])
                rotate([-90, 0, 0])
                    cylinder(r = 0.4, h = 14.0, $fn = 48);
    }
}

module cpf3_slot_intersection_debug_2d() {
    intersection() {
        cpf3_slot_bottom_debug_2d();
        cpf3_slot_stem_debug_2d();
    }
}

module cpf3_slot_minus_tubes_debug_3d(th = 1.0) {
    difference() {
        linear_extrude(height = th * 1.2, center = true)
        union() {
            cpf3_slot_bottom_wide_debug_2d();
            cpf3_slot_stem_debug_2d();
        }

        for (side = [-1, 1]) {
            translate([side * 1.2, -2.2, 0])
                rotate([-90, 0, 0])
                    cylinder(r = 0.4, h = 14.0, $fn = 48);
        }
    }
}

module cpf3_outer_fill_2d() {
    tongue_w = 4.8;
    tongue_h = 8.0;
    tongue_bottom_y = 0.0;
    tip_r = 0.4;
    shoulder_fill_w = 0.8;
    fill_bottom_y = cpf3_tangent_point_y();
    shoulder_fill_h = cpf3_shoulder_center_y() - fill_bottom_y;
    shoulder_fill_top_y = fill_bottom_y;
    shoulder_fill_bottom_y = shoulder_fill_top_y - shoulder_fill_h;
    inner_wall_w = 0.2;

    intersection() {
        cpf3_trim_window_2d();

        union() {
            translate([0, cpf3_body_center_y()])
                circle(r = cpf3_body_r(), $fn = 96);

            hull() {
                translate([-tongue_w / 2 + tip_r, tongue_bottom_y + tip_r])
                    circle(r = tip_r, $fn = 48);
                translate([-tongue_w / 2 + tip_r, tongue_bottom_y + tongue_h - tip_r])
                    circle(r = tip_r, $fn = 48);
                translate([tongue_w / 2 - tip_r, tongue_bottom_y + tip_r])
                    circle(r = tip_r, $fn = 48);
                translate([tongue_w / 2 - tip_r, tongue_bottom_y + tongue_h - tip_r])
                    circle(r = tip_r, $fn = 48);
            }

            translate([tongue_w / 2, shoulder_fill_bottom_y])
                square([shoulder_fill_w, shoulder_fill_h], center = false);
            translate([-tongue_w / 2 - shoulder_fill_w, shoulder_fill_bottom_y])
                square([shoulder_fill_w, shoulder_fill_h], center = false);

            translate([tongue_w / 2 - inner_wall_w, tongue_bottom_y])
                square([inner_wall_w, shoulder_fill_top_y - tongue_bottom_y], center = false);
            translate([-tongue_w / 2, tongue_bottom_y])
                square([inner_wall_w, shoulder_fill_top_y - tongue_bottom_y], center = false);
        }
    }
}

module cpf3_body_circle_fill_2d() {
    intersection() {
        cpf3_trim_window_2d();
        translate([0, cpf3_body_center_y()])
            circle(r = cpf3_body_r(), $fn = 96);
    }
}

module cpf3_tab_fill_2d() {
    tongue_w = 4.8;
    tongue_h = 8.0;
    tongue_bottom_y = 0.0;
    tip_r = 0.4;

    intersection() {
        cpf3_trim_window_2d();

        hull() {
            translate([-tongue_w / 2 + tip_r, tongue_bottom_y + tip_r])
                circle(r = tip_r, $fn = 48);
            translate([-tongue_w / 2 + tip_r, tongue_bottom_y + tongue_h - tip_r])
                circle(r = tip_r, $fn = 48);
            translate([tongue_w / 2 - tip_r, tongue_bottom_y + tip_r])
                circle(r = tip_r, $fn = 48);
            translate([tongue_w / 2 - tip_r, tongue_bottom_y + tongue_h - tip_r])
                circle(r = tip_r, $fn = 48);
        }
    }
}

module cpf3_transition_fill_2d() {
    tongue_w = 4.8;
    tongue_bottom_y = 0.0;
    tip_r = 0.4;

    intersection() {
        cpf3_trim_window_2d();

        hull() {
            translate([0, cpf3_body_center_y()])
                circle(r = cpf3_body_r(), $fn = 96);
            translate([-tongue_w / 2 + tip_r, tongue_bottom_y + tip_r])
                circle(r = tip_r, $fn = 48);
            translate([tongue_w / 2 - tip_r, tongue_bottom_y + tip_r])
                circle(r = tip_r, $fn = 48);
        }
    }
}

module cpf3_shoulder_fill_2d() {
    tongue_w = 4.8;
    tongue_bottom_y = 0.0;
    shoulder_fill_w = 0.8;
    fill_top_y = cpf3_tangent_point_y();
    shoulder_fill_h = cpf3_shoulder_center_y() - cpf3_tangent_point_y();
    shoulder_fill_bottom_y = fill_top_y - shoulder_fill_h;
    inner_wall_w = 0.2;

    intersection() {
        cpf3_trim_window_2d();

        union() {
            translate([tongue_w / 2, shoulder_fill_bottom_y])
                square([shoulder_fill_w, shoulder_fill_h], center = false);
            translate([-tongue_w / 2 - shoulder_fill_w, shoulder_fill_bottom_y])
                square([shoulder_fill_w, shoulder_fill_h], center = false);

            translate([tongue_w / 2 - inner_wall_w, tongue_bottom_y])
                square([inner_wall_w, fill_top_y - tongue_bottom_y], center = false);
            translate([-tongue_w / 2, tongue_bottom_y])
                square([inner_wall_w, fill_top_y - tongue_bottom_y], center = false);
        }
    }
}

module cpf3_outer_profile_2d() {
    difference() {
        cpf3_outer_fill_2d();

        translate([cpf3_shoulder_center_x(), cpf3_shoulder_center_y()])
            circle(r = cpf3_shoulder_r(), $fn = 96);
        translate([-cpf3_shoulder_center_x(), cpf3_shoulder_center_y()])
            circle(r = cpf3_shoulder_r(), $fn = 96);
    }
}

module cpf3_slot_negative_3d(th = 1.0) {
    difference() {
        linear_extrude(height = th + 0.1, center = true)
            cpf3_slot_profile_2d();

        for (side = [-1, 1]) {
            translate([side * 1.2, -2.2, 0])
                rotate([-90, 0, 0])
                    cylinder(r = 0.4, h = 14.0, $fn = 48);
        }
    }
}

module part_cpf3(th = 1.0) {
    color([0.18, 0.42, 0.78])
    difference() {
        linear_extrude(height = th, center = true)
            cpf3_outer_profile_2d();

        cpf3_slot_negative_3d(th);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf3();
}
