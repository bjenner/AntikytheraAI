// DRW-010 Sheet 2 recreation (Front plate parts list assembly).
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
use <../parts/cpf2_fork.scad>

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

module drw010_sheet2() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (parts list)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 2 OF 9", sz = 2.9);

    // Parts table (simplified)
    color("black")
    linear_extrude(height = th) {
        outline2d(0.34) translate([290, 208]) square([120, 80], center = false);
        for (y = [276, 269, 262, 255, 248, 241, 234, 227, 220, 213]) {
            line2d([290, y], [410, y], 0.2);
        }
    }
    color("black") translate([293, 284, 0]) linear_extrude(height = th) label("PARTS LIST", sz = 3.1, bold = true);
    color("black") translate([294, 273, 0]) linear_extrude(height = th) label("fp1..fp10, cp-f2", sz = 2.6);

    bronze = [0.40, 0.29, 0.18];
    dark = [0.22, 0.22, 0.22];

    // Exploded stack similar to source view.
    translate([210, 74, 0]) {
        color(bronze) translate([0, 0, 0]) part_fp1();
        color(bronze) translate([0, 0, 26]) part_fp2();
        color(dark)   translate([0, 0, 28]) part_fp3();
        color(bronze) translate([0, 0, 58]) part_fp1();
        color([0.16, 0.16, 0.16]) translate([0, 0, 60]) part_fp4();
        color(bronze) translate([0, 0, 86]) part_fp2();
    }

    // Posts on top frame.
    for (sx = [-1, 1], sy = [-1, 1]) {
        px = 210 + sx * 78;
        py = 74 + sy * 78;
        color(bronze) translate([px, py, 88]) part_fp6();
        color(bronze) translate([px + sx * 2, py + sy * 2, 60]) part_fp7();
        color(bronze) translate([px - sx * 2, py - sy * 2, 28]) part_fp8();
    }

    // Pointer stack and accessories.
    color(bronze) translate([210, 150, 122]) part_fp10();
    color(bronze) translate([210, 150, 123.2]) part_fp9();
    color(bronze) translate([210, 150, 61.5]) part_fp5();

    for (i = [0 : 4]) {
        color(bronze)
        translate([140 + i * 18, 28 + (i % 2) * 7, 22 + i * 2]) rotate([0, 0, 20 + 8 * i]) part_cpf2();
    }

    // Short callout labels.
    color("black") {
        translate([63, 262, 0]) linear_extrude(height = th) label("fp1", sz = 2.8, bold = true);
        translate([78, 262, 0]) linear_extrude(height = th) label("fp2", sz = 2.8, bold = true);
        translate([93, 262, 0]) linear_extrude(height = th) label("fp3", sz = 2.8, bold = true);
        translate([108, 262, 0]) linear_extrude(height = th) label("fp4", sz = 2.8, bold = true);
        translate([123, 262, 0]) linear_extrude(height = th) label("fp5", sz = 2.8, bold = true);
        translate([138, 262, 0]) linear_extrude(height = th) label("fp6", sz = 2.8, bold = true);
        translate([153, 262, 0]) linear_extrude(height = th) label("fp7", sz = 2.8, bold = true);
        translate([168, 262, 0]) linear_extrude(height = th) label("fp8", sz = 2.8, bold = true);
        translate([183, 262, 0]) linear_extrude(height = th) label("fp9", sz = 2.8, bold = true);
        translate([198, 262, 0]) linear_extrude(height = th) label("fp10", sz = 2.8, bold = true);
        translate([218, 262, 0]) linear_extrude(height = th) label("cp-f2", sz = 2.8, bold = true);
    }
}
