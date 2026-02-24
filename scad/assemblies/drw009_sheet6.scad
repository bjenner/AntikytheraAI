// DRW-009 Sheet 6 recreation (Exeligmos i1, i2).
// SPDX-License-Identifier: MIT

use <../parts/i1_gear.scad>
use <../parts/i2_hub.scad>

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

module i1_2d() {
    projection(cut = true) part_i1();
}

module i2_side_2d() {
    projection(cut = true) rotate([0, 90, 0]) part_i2();
}

module i2_top_2d() {
    projection(cut = true) part_i2();
}

module i1_i2_subassembly() {
    color([0.44, 0.30, 0.18]) part_i1();
    color([0.36, 0.28, 0.22]) translate([0, 0, 0]) part_i2();
}

module drw009_sheet6() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Exeligmos   (i1 , i2)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 6 OF 6", sz = 2.9);

    // 3D isolated parts
    color([0.44, 0.30, 0.18]) translate([78, 217, 14]) rotate([68, 0, 30]) scale([1.9, 1.9, 1.9]) part_i1();
    color("black") translate([93, 233, 0]) linear_extrude(height = th) label("i1", sz = 3.1, bold = true);

    color([0.36, 0.28, 0.22]) translate([206, 213, 14]) rotate([66, 0, 25]) scale([1.8, 1.8, 1.8]) part_i2();
    color("black") translate([221, 220, 0]) linear_extrude(height = th) label("i2", sz = 3.1, bold = true);

    // 2D gear view and side strip
    color([0.93, 0.93, 0.93]) translate([84, 118, 0]) linear_extrude(height = th) i1_2d();
    color("black") translate([84, 118, 0.01]) linear_extrude(height = th) outline2d(0.30) i1_2d();

    color([0.93, 0.93, 0.93]) translate([45, 118, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_i1();
    color("black") translate([45, 118, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rotate([90, 0, 0]) part_i1();

    // i2 dimension area
    color([0.93, 0.93, 0.93]) translate([195, 133, 0]) linear_extrude(height = th) i2_side_2d();
    color("black") translate([195, 133, 0.01]) linear_extrude(height = th) outline2d(0.30) i2_side_2d();
    color([0.93, 0.93, 0.93]) translate([194, 87, 0]) linear_extrude(height = th) i2_top_2d();
    color("black") translate([194, 87, 0.01]) linear_extrude(height = th) outline2d(0.30) i2_top_2d();

    color("black") {
        translate([100, 151, 0]) linear_extrude(height = th) label("R13.39", sz = 3.0);
        translate([102, 143, 0]) linear_extrude(height = th) label("R12.50", sz = 3.0);
        translate([128, 118, 0]) linear_extrude(height = th) label("\u23006.0", sz = 3.0);
        translate([162, 148, 0]) linear_extrude(height = th) label("\u23006.0", sz = 3.0);
        translate([162, 87, 0]) linear_extrude(height = th) label("\u23002.0", sz = 3.0);
        translate([180, 81, 0]) linear_extrude(height = th) label("\u23002.90", sz = 3.0);
        translate([155, 95, 0]) linear_extrude(height = th) label("\u23003.9", sz = 3.0);
    }

    // Sub-assembly view
    translate([319, 116, 16]) rotate([68, 0, 18]) scale([2.2, 2.2, 2.2]) i1_i2_subassembly();
    color("black") translate([333, 149, 0]) linear_extrude(height = th) label("Tight press fit i1 to i2", sz = 3.0);
    color("black") translate([315, 90, 0]) linear_extrude(height = th) label("i1 sub assembly", sz = 3.0);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw009_sheet6();
}
