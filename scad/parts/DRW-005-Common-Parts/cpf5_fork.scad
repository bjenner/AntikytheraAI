// part_id: cp-f5
// name: Fork 3W 12D 12L 12T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

function cpf5_shoulder_center_x() = 6.0;
function cpf5_shoulder_r() = 3.0;
function cpf5_body_r() = 6.0;
function cpf5_shoulder_center_y() =
    sqrt(pow(cpf5_body_r() + cpf5_shoulder_r(), 2) - pow(cpf5_shoulder_center_x(), 2));
function cpf5_tangent_point_y() =
    cpf5_body_r() * cpf5_shoulder_center_y() / (cpf5_body_r() + cpf5_shoulder_r());

module cpf5_slot_profile_2d() {
    slot_offset_y = 4.2;
    slot_stem_h = 13.2;

    translate([0, slot_offset_y])
    union() {
        intersection() {
            circle(r = 6.0, $fn = 96);
            rotate([0, 0, 90])
                square([12.0, 3.0], center = true);
        }

        translate([-1.5, 0])
            square([3.0, slot_stem_h], center = false);
    }
}

module cpf5_slot_bottom_debug_2d() {
    slot_offset_y = 4.2;

    translate([0, slot_offset_y])
        intersection() {
            circle(r = 6.0, $fn = 96);
            rotate([0, 0, 90])
                square([12.0, 3.0], center = true);
        }
}

module cpf5_slot_stem_debug_2d() {
    slot_offset_y = 4.2;
    slot_stem_h = 13.2;

    translate([-1.5, slot_offset_y])
        square([3.0, slot_stem_h], center = false);
}

module cpf5_slot_edge_pieces_debug_2d() {
    tongue_w = 6.0;
    tongue_bottom_y = 3.0;
    inner_wall_w = 0.25;
    fill_bottom_y = cpf5_tangent_point_y();

    translate([tongue_w / 2 - inner_wall_w, tongue_bottom_y])
        square([inner_wall_w, fill_bottom_y - tongue_bottom_y], center = false);
    translate([-tongue_w / 2, tongue_bottom_y])
        square([inner_wall_w, fill_bottom_y - tongue_bottom_y], center = false);
}

module cpf5_slot_tubes_debug_3d(th = 1.0) {
    for (side = [-1, 1]) {
        color([0.18, 0.82, 0.88, 0.85])
            translate([side * 1.5, -2.2, 0])
                rotate([-90, 0, 0])
                    cylinder(r = 0.5, h = 21.0, $fn = 48);
    }
}

module cpf5_outer_fill_2d() {
    tongue_w = 6.0;
    tongue_h = 13.2;
    tongue_bottom_y = 3.0;
    tip_r = 0.5;
    shoulder_fill_w = 3.0;
    fill_bottom_y = cpf5_tangent_point_y();
    shoulder_fill_h = cpf5_shoulder_center_y() - fill_bottom_y;
    inner_wall_w = 0.25;

    union() {
        circle(r = cpf5_body_r(), $fn = 96);

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

        translate([tongue_w / 2, fill_bottom_y])
            square([shoulder_fill_w, shoulder_fill_h], center = false);
        translate([-tongue_w / 2 - shoulder_fill_w, fill_bottom_y])
            square([shoulder_fill_w, shoulder_fill_h], center = false);

        // Extend the fork walls downward so the slot sides stay filled
        // until they meet the shoulder blend, matching the drawing.
        translate([tongue_w / 2 - inner_wall_w, tongue_bottom_y])
            square([inner_wall_w, fill_bottom_y - tongue_bottom_y], center = false);
        translate([-tongue_w / 2, tongue_bottom_y])
            square([inner_wall_w, fill_bottom_y - tongue_bottom_y], center = false);
    }
}

module cpf5_outer_profile_2d() {
    shoulder_r = cpf5_shoulder_r();
    shoulder_center_y = cpf5_shoulder_center_y();
    shoulder_center_x = cpf5_shoulder_center_x();

    difference() {
        cpf5_outer_fill_2d();

        translate([shoulder_center_x, shoulder_center_y])
            circle(r = shoulder_r, $fn = 96);
        translate([-shoulder_center_x, shoulder_center_y])
            circle(r = shoulder_r, $fn = 96);
    }
}

module cpf5_slot_negative_3d(th = 1.0) {
    difference() {
        linear_extrude(height = th + 0.1, center = true)
            cpf5_slot_profile_2d();

        for (side = [-1, 1]) {
            translate([side * 1.5, -2.2, 0])
                rotate([-90, 0, 0])
                    cylinder(r = 0.5, h = 21.0, $fn = 48);
        }
    }
}

module part_cpf5(th = 1.0) {
    color([0.18, 0.42, 0.78])
    difference() {
        linear_extrude(height = th, center = true)
            cpf5_outer_profile_2d();

        cpf5_slot_negative_3d(th);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf5();
}
