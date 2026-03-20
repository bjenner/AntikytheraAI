// part_id: cp-f4
// name: Fork 2W 8D 8L 7T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

function cpf4_body_r() = 4.0;
function cpf4_shoulder_r() = 4.0;
function cpf4_shoulder_center_x() = 6.5;
function cpf4_shoulder_center_y() =
    sqrt(pow(cpf4_body_r() + cpf4_shoulder_r(), 2) - pow(cpf4_shoulder_center_x(), 2));
function cpf4_tangent_point_y() =
    cpf4_body_r() * cpf4_shoulder_center_y() / (cpf4_body_r() + cpf4_shoulder_r());

module cpf4_slot_profile_2d() {
    slot_offset_y = 2.8;
    slot_stem_h = 8.4;

    translate([0, slot_offset_y])
    union() {
        intersection() {
            circle(r = cpf4_body_r(), $fn = 96);
            rotate([0, 0, 90])
                square([8.0, 2.0], center = true);
        }

        translate([-1.0, 0])
            square([2.0, slot_stem_h], center = false);
    }
}

module cpf4_outer_fill_2d() {
    tongue_w = 5.0;
    tongue_h = 8.2;
    tongue_bottom_y = 2.0;
    tip_r = 0.4;
    shoulder_fill_w = 1.5;
    fill_bottom_y = cpf4_tangent_point_y();
    shoulder_fill_h = cpf4_shoulder_center_y() - fill_bottom_y;
    inner_wall_w = 0.2;

    union() {
        circle(r = cpf4_body_r(), $fn = 96);

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

        translate([tongue_w / 2 - inner_wall_w, tongue_bottom_y])
            square([inner_wall_w, fill_bottom_y - tongue_bottom_y], center = false);
        translate([-tongue_w / 2, tongue_bottom_y])
            square([inner_wall_w, fill_bottom_y - tongue_bottom_y], center = false);
    }
}

module cpf4_outer_profile_2d() {
    difference() {
        cpf4_outer_fill_2d();

        translate([cpf4_shoulder_center_x(), cpf4_shoulder_center_y()])
            circle(r = cpf4_shoulder_r(), $fn = 96);
        translate([-cpf4_shoulder_center_x(), cpf4_shoulder_center_y()])
            circle(r = cpf4_shoulder_r(), $fn = 96);
    }
}

module cpf4_slot_negative_3d(th = 1.0) {
    difference() {
        linear_extrude(height = th + 0.1, center = true)
            cpf4_slot_profile_2d();

        for (side = [-1, 1]) {
            translate([side * 1.0, -2.0, 0])
                rotate([-90, 0, 0])
                    cylinder(r = 0.4, h = 16.0, $fn = 48);
        }
    }
}

module part_cpf4(th = 1.0) {
    color([0.18, 0.42, 0.78])
    difference() {
        linear_extrude(height = th, center = true)
            cpf4_outer_profile_2d();

        cpf4_slot_negative_3d(th);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf4();
}
