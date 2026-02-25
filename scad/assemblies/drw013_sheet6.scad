// DRW-013 Sheet 6 recreation (Mars, mar12 to mar18, cp5).
// SPDX-License-Identifier: MIT

use <../parts/mar12_pointer_arm.scad>
use <../parts/mar13_orb_large.scad>
use <../parts/mar14_orb_rod_large.scad>
use <../parts/mar15_orb_small.scad>
use <../parts/mar16_orb_rod_small.scad>
use <../parts/mar17_pointer_ring_outer.scad>
use <../parts/mar18_pointer_ring_inner.scad>
use <../parts/cp5_spacer.scad>

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

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module mars_pointer_subassembly() {
    color([0.42, 0.30, 0.18]) part_mar12();
    color([0.33, 0.27, 0.23]) translate([0, 0, 1.0]) part_mar18();
    color([0.33, 0.27, 0.23]) translate([0, 0, 2.0]) part_mar17();
    color([0.44, 0.32, 0.20]) {
        translate([-45.5, 0, 1.0]) part_mar14();
        translate([45.5, 0, 1.0]) part_mar16();
    }
    color([0.70, 0.05, 0.05]) {
        translate([-45.5, 0, 11.4]) part_mar13();
        translate([45.5, 0, 11.4]) part_mar15();
    }
}

module drw013_sheet6() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Mars   (mar12 to mar18, cp5)", sz = 2.9);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 6 OF 7", sz = 2.9);

    // Top previews.
    color([0.42, 0.30, 0.18]) translate([237, 235, 8]) rotate([68, 0, 20]) scale([1.15, 1.15, 1.15]) part_mar12();
    color([0.33, 0.27, 0.23]) translate([356, 232, 8]) rotate([68, 0, 20]) scale([1.35, 1.35, 1.35]) part_mar18();
    color([0.33, 0.27, 0.23]) translate([280, 181, 8]) rotate([68, 0, 20]) scale([1.35, 1.35, 1.35]) part_mar17();
    color("black") translate([271, 248, 0]) linear_extrude(height = th) label("mar12", sz = 3.0, bold = true);
    color("black") translate([369, 248, 0]) linear_extrude(height = th) label("mar18", sz = 3.0, bold = true);
    color("black") translate([286, 202, 0]) linear_extrude(height = th) label("mar17", sz = 3.0, bold = true);

    // Left-side orthographic and detail cluster.
    color([0.93, 0.93, 0.93]) translate([108, 192, 0]) linear_extrude(height = th) projection(cut = true) part_mar12();
    color("black") translate([108, 192, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar12();
    color([0.93, 0.93, 0.93]) translate([6, 224, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_mar12();
    color("black") translate([6, 224, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_mar12();

    color([0.70, 0.05, 0.05]) translate([44, 143, 8]) scale([1.3, 1.3, 1.3]) part_mar13();
    color([0.44, 0.32, 0.20]) translate([96, 130, 8]) part_mar14();
    color([0.70, 0.05, 0.05]) translate([138, 142, 8]) scale([1.1, 1.1, 1.1]) part_mar15();
    color([0.44, 0.32, 0.20]) translate([193, 126, 8]) part_mar16();
    color([0.44, 0.32, 0.20]) translate([250, 104, 8]) rotate([0, 90, 0]) part_cp5();

    color("black") {
        translate([45, 160, 0]) linear_extrude(height = th) label("mar13", sz = 2.8, bold = true);
        translate([96, 165, 0]) linear_extrude(height = th) label("mar14", sz = 2.8, bold = true);
        translate([140, 160, 0]) linear_extrude(height = th) label("mar15", sz = 2.8, bold = true);
        translate([193, 165, 0]) linear_extrude(height = th) label("mar16", sz = 2.8, bold = true);
        translate([252, 153, 0]) linear_extrude(height = th) label("cp5", sz = 2.8, bold = true);
    }

    // Ring detail views.
    color([0.93, 0.93, 0.93]) translate([258, 94, 0]) linear_extrude(height = th) projection(cut = true) part_mar17();
    color("black") translate([258, 94, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar17();

    color([0.93, 0.93, 0.93]) translate([343, 152, 0]) linear_extrude(height = th) projection(cut = true) part_mar18();
    color("black") translate([343, 152, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar18();

    color([0.93, 0.93, 0.93]) translate([343, 94, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_mar18();
    color("black") translate([343, 94, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_mar18();

    // Bottom assembly.
    translate([110, 18, 0]) rotate([70, 0, 22]) scale([1.05, 1.05, 1.05]) mars_pointer_subassembly();
    color("black") translate([117, 46, 0]) linear_extrude(height = th) label("Tight press fit orb's and rivet pins to mar12", sz = 2.7);
    color("black") translate([307, 24, 0]) linear_extrude(height = th) label("Mars pointer assembly", sz = 3.0);

    // Key dimensions.
    color("black") {
        translate([87, 263, 0]) linear_extrude(height = th) label("95", sz = 2.8);
        translate([83, 254, 0]) linear_extrude(height = th) label("45\u00b0", sz = 2.8);
        translate([84, 219, 0]) linear_extrude(height = th) label("\u230020.0", sz = 2.8);
        translate([98, 200, 0]) linear_extrude(height = th) label("R13.3", sz = 2.8);
        translate([123, 161, 0]) linear_extrude(height = th) label("\u230018.0", sz = 2.8);
        translate([10, 207, 0]) linear_extrude(height = th) label("\u23001.5", sz = 2.8);
        translate([205, 209, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);

        translate([37, 121, 0]) linear_extrude(height = th) label("\u23001.5", sz = 2.8);
        translate([57, 121, 0]) linear_extrude(height = th) label("\u23005", sz = 2.8);
        translate([94, 122, 0]) linear_extrude(height = th) label("\u23001.5", sz = 2.8);
        translate([127, 121, 0]) linear_extrude(height = th) label("\u23003", sz = 2.8);
        translate([126, 112, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);
        translate([191, 139, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);
        translate([126, 86, 0]) linear_extrude(height = th) label("Fitted 10.4", sz = 2.8);
        translate([204, 66, 0]) linear_extrude(height = th) label("Fitted 10.4", sz = 2.8);

        translate([259, 126, 0]) linear_extrude(height = th) label("\u230024", sz = 2.8);
        translate([279, 126, 0]) linear_extrude(height = th) label("\u230014.0", sz = 2.8);
        translate([276, 116, 0]) linear_extrude(height = th) label("\u230012.5", sz = 2.8);

        translate([360, 208, 0]) linear_extrude(height = th) label("\u230020.0", sz = 2.8);
        translate([360, 199, 0]) linear_extrude(height = th) label("\u230018.0", sz = 2.8);
        translate([360, 190, 0]) linear_extrude(height = th) label("\u230014.0", sz = 2.8);
        translate([331, 174, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);
        translate([328, 149, 0]) linear_extrude(height = th) label("8.0", sz = 2.8);
        translate([343, 108, 0]) linear_extrude(height = th) label("45\u00b0", sz = 2.8);
        translate([341, 82, 0]) linear_extrude(height = th) label("1.0", sz = 2.8);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw013_sheet6();
}
