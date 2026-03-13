// part_id: b5
// name: B5 fitted post
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module rounded_rect_2d(w = 4.5, d = 4.0, r = 0.5) {
    hull() {
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([sx * (w / 2 - r), sy * (d / 2 - r)])
                    circle(r = r, $fn = 24);
    }
}

// Main body axis is +Z.
module part_b5(
    body_w = 4.5,
    body_d = 7.0,
    body_r = 0.5,
    body_h = 23.6,
    top_stub_d = 4.0,
    top_stub_h = 2.0,
    bottom_stub_d = 4.0,
    bottom_stub_h = 4.2,
    bottom_chamfer_r = 0.3,
    lower_recess_d = 3.9,
    lower_recess_z = 1.2,
    lower_recess_h = 1.0,
    lower_slot_w = 4.0,
    lower_slot_d = 7.0,
    lower_slot_h = 1.0,
    lower_slot_offset = 3.0
) {
    difference() {
        union() {
            // Main fitted post body with rounded corners.
            translate([0, 0, bottom_stub_h])
                linear_extrude(height = body_h)
                    rounded_rect_2d(w = body_w, d = body_d, r = body_r);

            // Bottom cylinder with small lower chamfer.
            translate([0, 0, bottom_chamfer_r])
                cylinder(d = bottom_stub_d, h = bottom_stub_h - bottom_chamfer_r, center = false, $fn = 42);
            cylinder(d1 = bottom_stub_d - 2 * bottom_chamfer_r, d2 = bottom_stub_d, h = bottom_chamfer_r, center = false, $fn = 42);

            // Top locating peg.
            translate([0, 0, bottom_stub_h + body_h])
                cylinder(d = top_stub_d, h = top_stub_h, center = false, $fn = 42);
        }

        // Annular recess in lower cylinder.
        difference() {
            translate([0, 0, lower_recess_z])
                cylinder(d = bottom_stub_d + 1, h = lower_recess_h, center = false, $fn = 42);
            translate([0, 0, lower_recess_z])
                cylinder(d = lower_recess_d, h = lower_recess_h, center = false, $fn = 42);
        }
     
        // Opposed slot cuts in the recessed band.
        for (sx = [-1, 1])
            echo("here: " + "51")
            color("green")
            translate([sx * lower_slot_offset, 0, lower_recess_z+lower_slot_h/2])
                cube([lower_slot_w, lower_slot_d, lower_slot_h], center = true);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b5();
}
