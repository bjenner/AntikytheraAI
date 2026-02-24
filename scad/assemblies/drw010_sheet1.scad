// DRW-010 Sheet 1 recreation (Front plate assembly).
// SPDX-License-Identifier: MIT

use <../parts/fp1_front_plate.scad>
use <../parts/fp2_front_panel_dial_frame.scad>
use <../parts/fp3_zodiac_dial.scad>
use <../parts/fp4_egyptian_dial.scad>
use <../parts/fp5_rivet.scad>
use <../parts/fp6_post.scad>
use <../parts/fp7_post.scad>
use <../parts/fp8_post.scad>
use <../parts/fp9_bush.scad>
use <../parts/fp10_zodiac_pointer.scad>
use <../parts/dat9_base_plate.scad>
use <../parts/dat10_spoked_wheel.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.3) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.35) {
    difference() {
        offset(r = w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module label(s, sz = 2.9, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module front_plate_stack() {
    bronze = [0.40, 0.29, 0.18];
    dark = [0.17, 0.17, 0.17];

    // Rear/front panel stack.
    color(bronze) translate([0, 0, 0]) part_fp1();
    color(bronze) translate([0, 0, 26]) part_fp2();
    color(dark)   translate([0, 0, 28]) part_fp3();
    color(bronze) translate([0, 0, 57]) part_fp1();
    color(dark)   translate([0, 0, 59]) part_fp4();
    color(bronze) translate([0, 0, 86]) part_fp2();

    // Frame posts.
    for (sx = [-1, 1], sy = [-1, 1]) {
        px = sx * 78;
        py = sy * 78;
        color(bronze) translate([px, py, 88]) part_fp6();
        color(bronze) translate([px + sx * 2, py + sy * 2, 60]) part_fp7();
        color(bronze) translate([px - sx * 2, py - sy * 2, 28]) part_fp8();
    }

    // Pointer assembly at the center.
    color(bronze) translate([0, 0, 88]) part_fp10();
    color(bronze) translate([0, 0, 89.1]) part_fp9();
    color(bronze) translate([0, 0, 60.2]) part_fp5();
}

module lower_inset_stack() {
    bronze = [0.40, 0.29, 0.18];
    dark = [0.18, 0.18, 0.18];

    color(bronze) part_dat9();
    color(bronze) translate([0, 0, 33]) part_fp2();
    color(bronze) translate([0, 0, 66]) part_fp2();

    for (sx = [-1, 1], sy = [-1, 1]) {
        translate([sx * 78, sy * 78, 0]) color(bronze) part_fp8();
        translate([sx * 78, sy * 78, 33]) color(bronze) part_fp8();
    }

    color(bronze) translate([0, 0, 67.5]) part_dat10();
    color(dark) translate([0, 0, 70]) cylinder(d = 15, h = 2.5, $fn = 64);
}

module drw010_sheet1() {
    W = 420;
    H = 297;
    B = 8;
    th = 0.12;

    color("black")
    linear_extrude(height = th)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W - 2 * B, H - 2 * B], center = false);
    }

    // Title block
    color("black")
    linear_extrude(height = th) {
        outline2d(0.4) translate([285, 8]) square([127, 34], center = false);
        line2d([285, 20], [412, 20], 0.28);
        line2d([285, 30], [412, 30], 0.28);
        line2d([325, 8], [325, 42], 0.28);
        line2d([376, 8], [376, 42], 0.28);
    }
    color("black") translate([289, 37, 0]) linear_extrude(height = th) label("PROJECT   Antikithera Mechanism", sz = 3.1, bold = true);
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (assembly)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 1 OF 9", sz = 2.9);

    // Main perspective assembly.
    translate([118, 68, 0]) rotate([70, 0, 23]) scale([0.85, 0.85, 0.85]) front_plate_stack();

    // Lower-right inset assembly.
    translate([310, 45, 0]) rotate([72, 0, 14]) scale([0.45, 0.45, 0.45]) lower_inset_stack();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw010_sheet1();
}
