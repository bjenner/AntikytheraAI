// part_id: cp-f6
// name: Fork 3W 10L 6D 10T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cpf6_slot_profile_2d() {
    slot_offset_y = 2.9;

    translate([0, slot_offset_y])
    union() {
        intersection() {
            circle(r = 5.0, $fn = 96);
            rotate([0, 0, 90])
                square([10.0, 3.5], center = true);
        }

        translate([-1.75, 0])
            square([3.5, 8.0], center = false);
    }
}

module cpf6_outer_fill_2d() {
    tongue_w = 6.6;
    tongue_h = 6.0;
    tongue_bottom_y = 2.9;
    shoulder_fill_w = 2.0;
    shoulder_fill_h = 2.0;

    union() {
        circle(r = 5.0, $fn = 96);

        translate([-tongue_w / 2, tongue_bottom_y])
            square([tongue_w, tongue_h], center = false);

        translate([tongue_w / 2, tongue_bottom_y])
            square([shoulder_fill_w, shoulder_fill_h], center = false);
        translate([-tongue_w / 2 - shoulder_fill_w, tongue_bottom_y])
            square([shoulder_fill_w, shoulder_fill_h], center = false);
    }
}

module cpf6_outer_profile_2d() {
    tongue_w = 6.6;
    shoulder_r = 3.0;
    shoulder_center_y = 4.9;
    shoulder_center_x = tongue_w / 2 + shoulder_r;

    difference() {
        cpf6_outer_fill_2d();

        translate([shoulder_center_x, shoulder_center_y])
            circle(r = shoulder_r, $fn = 96);
        translate([-shoulder_center_x, shoulder_center_y])
            circle(r = shoulder_r, $fn = 96);
    }
}

module cpf6_slot_negative_3d(th = 1.0) {
    difference() {
        linear_extrude(height = th + 0.1, center = true)
            cpf6_slot_profile_2d();

        for (side = [-1, 1]) {
            translate([side * 1.75, -4.9, 0])
                rotate([-90, 0, 0])
                    cylinder(r = 0.5, h = 14.0, $fn = 48);
        }
    }
}

module part_cpf6(th = 1.0) {
    color([0.18, 0.42, 0.78])
    difference() {
        linear_extrude(height = th, center = true)
            cpf6_outer_profile_2d();

        cpf6_slot_negative_3d(th);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf6();
}
