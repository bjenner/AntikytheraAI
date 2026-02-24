// DRW-005 Sheet 1 recreation (Common Parts cp1 to cp9).
// SPDX-License-Identifier: MIT

use <../parts/cp1_pointer_small.scad>
use <../parts/cp2_slider.scad>
use <../parts/cp3_rivet.scad>
use <../parts/cp4_stopper.scad>
use <../parts/cp5_spacer.scad>
use <../parts/cp6_bush.scad>
use <../parts/cp7_bush.scad>
use <../parts/cp8_pin.scad>
use <../parts/cp9_pin.scad>

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

module drw005_sheet1() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Common Parts (cp1 to cp9)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 1 OF 3", sz = 2.9);

    // CP1
    color([0.45, 0.30, 0.18]) translate([45, 248, 16]) rotate([70, 0, 24]) scale([1.9, 1.9, 1.9]) part_cp1();
    color("black") translate([58, 262, 0]) linear_extrude(height = th) label("cp1", sz = 3.0, bold = true);

    // CP2
    color([0.35, 0.28, 0.24]) translate([300, 226, 16]) rotate([58, 0, 32]) scale([1.8, 1.8, 1.8]) part_cp2();
    color("black") translate([305, 234, 0]) linear_extrude(height = th) label("cp2", sz = 3.0, bold = true);

    // CP3
    color([0.18, 0.18, 0.18]) translate([28, 92, 16]) rotate([20, 70, 20]) scale([2.0, 2.0, 2.0]) part_cp3();
    color("black") translate([35, 98, 0]) linear_extrude(height = th) label("cp3 x (4x8=36)", sz = 2.8, bold = true);

    // CP4
    color([0.40, 0.32, 0.25]) translate([108, 106, 16]) rotate([25, 70, -25]) scale([2.4, 2.4, 2.4]) part_cp4();
    color("black") translate([114, 120, 0]) linear_extrude(height = th) label("cp4", sz = 3.0, bold = true);

    // CP5
    color([0.45, 0.30, 0.18]) translate([206, 104, 16]) rotate([68, 0, 25]) scale([2.2, 2.2, 2.2]) part_cp5();
    color("black") translate([191, 153, 0]) linear_extrude(height = th) label("cp5", sz = 3.0, bold = true);

    // CP6
    color([0.45, 0.30, 0.18]) translate([375, 218, 16]) rotate([66, 0, 28]) scale([2.1, 2.1, 2.1]) part_cp6();
    color("black") translate([379, 235, 0]) linear_extrude(height = th) label("cp6 x 10", sz = 3.0, bold = true);

    // CP7
    color([0.45, 0.30, 0.18]) translate([283, 126, 16]) rotate([66, 0, 28]) scale([2.1, 2.1, 2.1]) part_cp7();
    color("black") translate([287, 138, 0]) linear_extrude(height = th) label("cp7 x 6", sz = 3.0, bold = true);

    // CP8
    color([0.25, 0.25, 0.25]) translate([350, 128, 16]) rotate([90, 0, 0]) scale([2.2, 2.2, 2.2]) part_cp8();
    color("black") translate([353, 138, 0]) linear_extrude(height = th) label("cp8 x 2", sz = 3.0, bold = true);

    // CP9
    color([0.18, 0.18, 0.18]) translate([383, 128, 16]) rotate([90, 0, 0]) scale([2.2, 2.2, 2.2]) part_cp9();
    color("black") translate([378, 138, 0]) linear_extrude(height = th) label("cp9 x 10", sz = 3.0, bold = true);

    // A few 2D profile references, matching the sheet style.
    color([0.93, 0.93, 0.93]) translate([44, 196, 0]) linear_extrude(height = th) cp1_profile_2d();
    color("black") translate([44, 196, 0.01]) linear_extrude(height = th) outline2d(0.30) cp1_profile_2d();

    color([0.93, 0.93, 0.93]) translate([195, 26, 0]) linear_extrude(height = th) projection(cut = true) part_cp5();
    color("black") translate([195, 26, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cp5();

    color([0.93, 0.93, 0.93]) translate([360, 28, 0]) linear_extrude(height = th) projection(cut = true) part_cp7();
    color("black") translate([360, 28, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cp7();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw005_sheet1();
}
