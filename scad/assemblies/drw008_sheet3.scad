// DRW-008 Sheet 3 recreation (date axle clearances).
// SPDX-License-Identifier: MIT

use <../parts/dat1_pointer.scad>
use <../parts/dat2_pin.scad>
use <../parts/dat3_ball_tip.scad>
use <../parts/dat4_post.scad>
use <../parts/dat5_ball_tip_small.scad>
use <../parts/dat6_post_small.scad>
use <../parts/dat7_ring.scad>
use <../parts/dat8_ring.scad>
use <../parts/dat9_base_plate.scad>
use <../parts/dat10_spoked_wheel.scad>
use <../parts/sp2_gear_axle_subassembly.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.3) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.38) {
    difference() {
        offset(r = w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module date_pointer_stack() {
    color([0.44, 0.30, 0.18]) linear_extrude(height = 1.0) dat1_profile_2d();
    color([0.42, 0.28, 0.17]) translate([0, 0, 0.2]) part_dat7();
    color([0.38, 0.25, 0.15]) translate([0, 0, 2.25]) part_dat8();

    translate([-63.5, 0, 0.8]) {
        color([0.22, 0.22, 0.22]) part_dat6();
        color([0.12, 0.24, 0.88]) translate([0, 0, 18.0]) part_dat5();
    }

    translate([63.5, 0, 0.8]) {
        color([0.22, 0.22, 0.22]) part_dat4();
        color([0.12, 0.24, 0.88]) translate([0, 0, 18.0]) part_dat3();
        color([0.18, 0.18, 0.18]) translate([0, 1.2, 17.8]) rotate([90, 15, 0]) part_dat2();
    }
}

module date_sheet3_stack_3d() {
    color([0.43, 0.29, 0.18]) part_dat9();
    color([0.40, 0.27, 0.16]) translate([0, 0, 2.0]) part_dat10();
    color([0.36, 0.24, 0.14]) translate([0, 0, 3.8]) date_pointer_stack();
    color([0.37, 0.27, 0.18]) translate([0, 0, 2.5]) scale([0.70, 0.70, 0.70]) part_sp2();
}

module drw008_sheet3() {
    W = 420;
    H = 297;
    B = 8;
    th = 0.12;

    // Border.
    color("black")
    linear_extrude(height = th)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W - 2 * B, H - 2 * B], center = false);
    }

    // Title block.
    color("black")
    linear_extrude(height = th) {
        outline2d(0.4) translate([285, 8]) square([127, 34], center = false);
        line2d([285, 20], [412, 20], 0.28);
        line2d([285, 30], [412, 30], 0.28);
        line2d([325, 8], [325, 42], 0.28);
        line2d([376, 8], [376, 42], 0.28);
    }
    color("black") translate([289, 37, 0]) linear_extrude(height = th) label("PROJECT   Antikithera Mechanism", sz = 3.1, bold = true);
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Date      (axle clearances)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 3 OF 5", sz = 2.9);

    // Main slanted assembly view.
    translate([154, 187, 12]) rotate([70, 0, -10]) scale([0.86, 0.86, 0.86]) date_sheet3_stack_3d();

    // Section D-D style side projection.
    color([0.93, 0.93, 0.93])
    translate([349, 141, 0]) linear_extrude(height = th)
    projection(cut = true)
    rotate([90, 0, 0]) scale([0.85, 0.85, 0.85]) date_sheet3_stack_3d();

    color("black")
    translate([349, 141, 0.01]) linear_extrude(height = th)
    outline2d(0.30)
    projection(cut = true)
    rotate([90, 0, 0]) scale([0.85, 0.85, 0.85]) date_sheet3_stack_3d();

    // Notes and callouts.
    color("black") translate([176, 33, 0]) linear_extrude(height = th)
        label("Fit sp2 between Superior plant plate and date pointer. Solder date Pointer to date axle", sz = 2.7);

    color("black") translate([343, 56, 0]) linear_extrude(height = th) label("SECTION D-D", sz = 4.8, bold = true);
    color("black") translate([344, 44, 0]) linear_extrude(height = th) label("SCALE 1:1.25", sz = 4.4, bold = true);

    // D leader marks.
    color("black") linear_extrude(height = th) {
        line2d([184, 235], [184, 93], 0.25);
        translate([180, 238]) text("D", size = 7, font = "Liberation Sans:style=Bold");
        translate([180, 83]) text("D", size = 7, font = "Liberation Sans:style=Bold");
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw008_sheet3();
}
