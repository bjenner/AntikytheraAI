// part_id: sp5
// name: SP5 superior plate
// source_drawing_ids: DRW-022;DRW-056
// units: mm
// revision: 0.2-drw022
// SPDX-License-Identifier: MIT

module sp5_quadrant_window(r_inner = 20.0, r_outer = 59.0, neck_half = 7.5, fillet_r = 3.0) {
    // Window profile based on DRW-022: R59 outer, R20 inner, 15 mm neck gap.
    if (fillet_r > 0) {
        offset(r = fillet_r)
            offset(delta = -fillet_r)
                intersection() {
                    difference() {
                        circle(r = r_outer, $fn = 180);
                        circle(r = r_inner, $fn = 180);
                    }
                    translate([neck_half, neck_half]) square([r_outer, r_outer], center = false);
                }
    } else {
        intersection() {
            difference() {
                circle(r = r_outer, $fn = 180);
                circle(r = r_inner, $fn = 180);
            }
            translate([neck_half, neck_half]) square([r_outer, r_outer], center = false);
        }
    }
}

module part_sp5(
    size = 184.0,
    thickness = 2.0,
    corner_hole_d = 5.0,
    corner_offset = 7.5,
    center_bore_d = 20.2,
    rivet_hole_d = 3.0,
    rivet_radius = 13.0,
    window_outer_r = 59.0,
    window_inner_r = 20.0,
    window_neck_half = 7.5,
    window_fillet_r = 3.0
) {
    difference() {
        translate([-size / 2, -size / 2, 0]) cube([size, size, thickness], center = false);

        // Corner mounting holes.
        for (sx = [-1, 1], sy = [-1, 1]) {
            translate([sx * (size / 2 - corner_offset), sy * (size / 2 - corner_offset), -0.1])
                cylinder(d = corner_hole_d, h = thickness + 0.2, center = false);
        }

        // Main center bore.
        translate([0, 0, -0.1]) cylinder(d = center_bore_d, h = thickness + 0.2, center = false);

        // SP6 rivet pattern used to mount SP1/SP7 to SP5.
        for (a = [0, 90, 180, 270]) {
            rotate([0, 0, a]) translate([rivet_radius, 0, -0.1])
                cylinder(d = rivet_hole_d, h = thickness + 0.2, center = false);
        }

        // Four primary cutout windows.
        translate([0, 0, -0.1])
            linear_extrude(height = thickness + 0.2)
                for (sx = [-1, 1], sy = [-1, 1]) {
                    mirror([sx < 0 ? 1 : 0, sy < 0 ? 1 : 0, 0])
                        sp5_quadrant_window(
                            r_inner = window_inner_r,
                            r_outer = window_outer_r,
                            neck_half = window_neck_half,
                            fillet_r = window_fillet_r
                        );
                }
    }
}

module part_sp5_draw() {
    color("silver")
        linear_extrude(height = 0.01)
            difference() {
                square([184, 184], center = true);
                circle(d = 20.2, $fn = 180);
                for (a = [0, 90, 180, 270]) {
                    rotate([0, 0, a]) translate([13, 0]) circle(d = 3, $fn = 80);
                }
                for (sx = [-1, 1], sy = [-1, 1]) {
                    translate([sx * (92 - 7.5), sy * (92 - 7.5)]) circle(d = 5, $fn = 80);
                }
                for (sx = [-1, 1], sy = [-1, 1]) {
                    mirror([sx < 0 ? 1 : 0, sy < 0 ? 1 : 0, 0])
                        sp5_quadrant_window();
                }
            }
}

module part_sp5_print() {
    part_sp5();
}

module part_sp5_asm() {
    part_sp5();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_sp5();
}
