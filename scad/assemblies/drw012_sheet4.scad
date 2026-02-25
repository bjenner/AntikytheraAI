// DRW-012 Sheet 4 recreation (Jupiter: jup1 with mar1 pairing context).
// SPDX-License-Identifier: MIT

use <../parts/jup1_gear.scad>
use <../parts/mar1_gear.scad>
use <../parts/jup10_hub.scad>

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

module jup1_mar1_subassembly() {
    color([0.42, 0.30, 0.18]) part_jup1();
    color([0.40, 0.29, 0.18]) translate([0, 0, 1.6]) part_mar1();
    color([0.36, 0.31, 0.27]) translate([0, 0, 3.2]) part_jup10(); // provisional stand-in for sp10 from this sheet callout
}

module drw012_sheet4() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Jupiter   (jup1)", sz = 2.9);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 4 OF 9", sz = 2.9);

    // Left: jup1 isometric and 2D.
    color([0.42, 0.30, 0.18]) translate([62, 210, 8]) rotate([68, 0, 25]) scale([1.9, 1.9, 1.9]) part_jup1();
    color("black") translate([82, 248, 0]) linear_extrude(height = th) label("jup1", sz = 3.0, bold = true);

    color([0.93, 0.93, 0.93]) translate([57, 87, 0]) linear_extrude(height = th) projection(cut = true) part_jup1();
    color("black") translate([57, 87, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup1();

    color([0.93, 0.93, 0.93]) translate([31, 114, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_jup1();
    color("black") translate([31, 114, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup1();

    // Mid-top: jup1+mar1 stacked preview.
    color([0.42, 0.30, 0.18]) translate([195, 212, 8]) rotate([68, 0, 24]) scale([1.65, 1.65, 1.65]) part_jup1();
    color([0.40, 0.29, 0.18]) translate([195, 212, 10.8]) rotate([68, 0, 24]) scale([1.65, 1.65, 1.65]) part_mar1();
    color("black") translate([195, 248, 0]) linear_extrude(height = th) label("jup1", sz = 3.0, bold = true);
    color("black") translate([210, 245, 0]) linear_extrude(height = th) label("mar1", sz = 3.0, bold = true);

    // Right: larger paired gears and exploded stack to sp2 reference.
    color([0.42, 0.30, 0.18]) translate([350, 160, 0]) scale([2.0, 2.0, 2.0]) part_jup1();
    color([0.40, 0.29, 0.18]) translate([350, 160, 1.9]) scale([2.0, 2.0, 2.0]) part_mar1();

    translate([225, 35, 0]) rotate([70, 0, 22]) scale([1.5, 1.5, 1.5]) jup1_mar1_subassembly();
    color("black") translate([176, 58, 0]) linear_extrude(height = th) label("jup1-mar1 sub", sz = 2.8);
    color("black") translate([176, 50, 0]) linear_extrude(height = th) label("assembly", sz = 2.8);
    color("black") translate([166, 95, 0]) linear_extrude(height = th) label("sp10", sz = 2.8, bold = true);

    color([0.42, 0.30, 0.18]) translate([292, 103, 0]) rotate([70, 0, 24]) scale([1.65, 1.65, 1.65]) part_jup1();
    color([0.40, 0.29, 0.18]) translate([292, 103, 3.2]) rotate([70, 0, 24]) scale([1.65, 1.65, 1.65]) part_mar1();
    color("black") translate([273, 118, 0]) linear_extrude(height = th) label("jup1-mar1 sub assembly", sz = 2.8);
    color("black") translate([279, 77, 0]) linear_extrude(height = th) label("sp2 sub assembly", sz = 2.8);

    // Sheet dimensions shown in source.
    color("black") {
        translate([40, 101, 0]) linear_extrude(height = th) label("R13.09", sz = 2.8);
        translate([40, 91, 0]) linear_extrude(height = th) label("R11.84", sz = 2.8);
        translate([97, 101, 0]) linear_extrude(height = th) label("\u23007.0", sz = 2.8);
        translate([130, 58, 0]) linear_extrude(height = th) label("R.5", sz = 2.8);
        translate([31, 135, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw012_sheet4();
}
