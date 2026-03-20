// part_id: cp-f1
// name: Fork 1.5W 3D 5L 6T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf1_base_blank_2d() {
    body_w = 6.0;
    body_side_y = -3.0;
    body_top_y = 5.0;
    corner_r = 2.0;
    corner_center_x = 1.0;
    corner_center_y = -3.0;

    union() {
        translate([-body_w / 2, body_side_y])
            square([body_w, body_top_y - body_side_y], center = false);

        hull() {
            translate([-corner_center_x, corner_center_y])
                circle(r = corner_r, $fn = 48);
            translate([corner_center_x, corner_center_y])
                circle(r = corner_r, $fn = 48);
        }
    }
}

module cpf1_profile_2d(center = true) {
    stem_w = 1.5 + 1.3 + 1.3;
    stem_half_w = stem_w / 2;
    body_top_y = 5.0;
    corner_r = 2.0;
    corner_center_y = -3.0;
    y_center = (body_top_y - (corner_center_y - corner_r)) / 2 + (corner_center_y - corner_r);

    translate([0, center ? -y_center : 0])
    union() {
        difference() {
            cpf1_base_blank_2d();

            translate([-10, -1.0])
                square([20, 10], center = false);
        }

        translate([-stem_half_w, 2.0])
            square([stem_w, body_top_y - 2.0], center = false);

        translate([-1.0, 2.0])
            circle(r = 2.0, $fn = 48);
        translate([1.0, 2.0])
            circle(r = 2.0, $fn = 48);
    }
}

module part_cpf1(th = 1.0) {
    linear_extrude(height = th)
        cpf1_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf1();
}
