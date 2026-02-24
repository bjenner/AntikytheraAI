// DRW-009 Sheet 5 recreation (Exeligmos h1 to h3).
// SPDX-License-Identifier: MIT

use <../parts/h1_gear.scad>
use <../parts/h2_pinion.scad>
use <../parts/h3_hub.scad>

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

module h1_2d() { projection(cut = true) part_h1(); }
module h2_2d() { projection(cut = true) part_h2(); }
module h3_side_2d() { projection(cut = true) rotate([0, 90, 0]) part_h3(); }
module h3_top_2d() { projection(cut = true) part_h3(); }

module h1_subassembly() {
    color([0.44, 0.30, 0.18]) part_h1();
    color([0.36, 0.28, 0.22]) translate([0, 0, 0]) part_h3();
    color([0.48, 0.31, 0.18]) translate([0, 0, 0.2]) part_h2();
}

module drw009_sheet5() {
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

    color("black")
    linear_extrude(height = th) {
        outline2d(0.4) translate([285, 8]) square([127, 34], center = false);
        line2d([285, 20], [412, 20], 0.28);
        line2d([285, 30], [412, 30], 0.28);
        line2d([325, 8], [325, 42], 0.28);
        line2d([376, 8], [376, 42], 0.28);
    }
    color("black") translate([289, 37, 0]) linear_extrude(height = th) label("PROJECT   Antikithera Mechanism", sz = 3.1, bold = true);
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Exeligmos   (h1 to h3)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 5 OF 6", sz = 2.9);

    // 3D isolated parts
    color([0.44, 0.30, 0.18]) translate([78, 214, 14]) rotate([68, 0, 28]) scale([1.9, 1.9, 1.9]) part_h1();
    color("black") translate([95, 232, 0]) linear_extrude(height = th) label("h1", sz = 3.1, bold = true);

    color([0.48, 0.31, 0.18]) translate([182, 196, 14]) rotate([70, 0, 28]) scale([1.75, 1.75, 1.75]) part_h2();
    color("black") translate([197, 220, 0]) linear_extrude(height = th) label("h2", sz = 3.1, bold = true);

    color([0.36, 0.28, 0.22]) translate([250, 204, 14]) rotate([66, 0, 24]) scale([1.75, 1.75, 1.75]) part_h3();
    color("black") translate([286, 210, 0]) linear_extrude(height = th) label("h3", sz = 3.1, bold = true);

    // 2D drawing views
    color([0.93, 0.93, 0.93]) translate([84, 120, 0]) linear_extrude(height = th) h1_2d();
    color("black") translate([84, 120, 0.01]) linear_extrude(height = th) outline2d(0.30) h1_2d();

    color([0.93, 0.93, 0.93]) translate([45, 120, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_h1();
    color("black") translate([45, 120, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rotate([90, 0, 0]) part_h1();

    color([0.93, 0.93, 0.93]) translate([180, 120, 0]) linear_extrude(height = th) h2_2d();
    color("black") translate([180, 120, 0.01]) linear_extrude(height = th) outline2d(0.30) h2_2d();

    color([0.93, 0.93, 0.93]) translate([230, 135, 0]) linear_extrude(height = th) h3_side_2d();
    color("black") translate([230, 135, 0.01]) linear_extrude(height = th) outline2d(0.30) h3_side_2d();

    color([0.93, 0.93, 0.93]) translate([255, 74, 0]) linear_extrude(height = th) h3_top_2d();
    color("black") translate([255, 74, 0.01]) linear_extrude(height = th) outline2d(0.30) h3_top_2d();

    color("black") {
        translate([106, 151, 0]) linear_extrude(height = th) label("R13.99", sz = 3.0);
        translate([106, 143, 0]) linear_extrude(height = th) label("R12.98", sz = 3.0);
        translate([127, 123, 0]) linear_extrude(height = th) label("\u23004.0", sz = 3.0);
        translate([162, 116, 0]) linear_extrude(height = th) label("2.0", sz = 3.0);
        translate([224, 148, 0]) linear_extrude(height = th) label("18.3", sz = 2.9);
        translate([224, 140, 0]) linear_extrude(height = th) label("14.8", sz = 2.9);
        translate([242, 84, 0]) linear_extrude(height = th) label("\u23002.9", sz = 3.0);
        translate([262, 84, 0]) linear_extrude(height = th) label("\u23004.0", sz = 3.0);
        translate([280, 74, 0]) linear_extrude(height = th) label("\u230012", sz = 3.0);
    }

    // Subassembly
    translate([329, 116, 16]) rotate([69, 0, 16]) scale([2.2, 2.2, 2.2]) h1_subassembly();
    color("black") translate([335, 150, 0]) linear_extrude(height = th) label("Tight press fit h1 to h3", sz = 3.0);
    color("black") translate([335, 80, 0]) linear_extrude(height = th) label("h1 sub assembly", sz = 3.0);
    color("black") translate([334, 67, 0]) linear_extrude(height = th) label("Solder h2 to h3", sz = 3.0);
}
