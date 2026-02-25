// DRW-013 Sheet 7 recreation (Mars, mar5 to mar11).
// SPDX-License-Identifier: MIT

use <../parts/mar5_gear.scad>
use <../parts/mar11_sleeve.scad>

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

module mars_pointer() {
    color([0.42, 0.30, 0.18]) {
        translate([-58, -1.1, 0]) cube([116, 2.2, 1.3], center = false);
        translate([-2.0, -3.2, 0]) linear_extrude(height = 1.3)
            difference() {
                circle(d = 22, $fn = 96);
                circle(d = 14, $fn = 88);
            }
    }
    color([0.44, 0.32, 0.20]) {
        translate([-52.5, -1.0, 1.3]) cylinder(d = 2.4, h = 8.4, $fn = 28);
        translate([52.5, -1.0, 1.3]) cylinder(d = 2.4, h = 8.4, $fn = 28);
    }
    color([0.70, 0.05, 0.05]) {
        translate([-52.5, -1.0, 9.7]) sphere(d = 5.2, $fn = 32);
        translate([52.5, -1.0, 9.7]) sphere(d = 5.2, $fn = 32);
    }
}

module mars_pointer_assembly() {
    mars_pointer();
    color([0.32, 0.27, 0.24]) translate([0, 0, -21.8]) part_mar11();
    color([0.42, 0.30, 0.18]) translate([0, 0, -23.4]) part_mar5();
}

module drw013_sheet7() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Mars   (mar5 to mar11)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 7 OF 7", sz = 2.9);

    // Part previews.
    color([0.42, 0.30, 0.18]) translate([66, 214, 9]) rotate([68, 0, 25]) scale([1.7, 1.7, 1.7]) part_mar5();
    color("black") translate([79, 246, 0]) linear_extrude(height = th) label("mar5", sz = 3.0, bold = true);

    color([0.32, 0.27, 0.24]) translate([141, 230, 10]) rotate([68, 0, 24]) scale([1.6, 1.6, 1.6]) part_mar11();
    color("black") translate([157, 257, 0]) linear_extrude(height = th) label("mar11", sz = 3.0, bold = true);

    // 2D views.
    color([0.93, 0.93, 0.93]) translate([61, 86, 0]) linear_extrude(height = th) projection(cut = true) part_mar5();
    color("black") translate([61, 86, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar5();

    color([0.93, 0.93, 0.93]) translate([41, 138, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_mar5();
    color("black") translate([41, 138, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_mar5();

    color([0.93, 0.93, 0.93]) translate([147, 145, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_mar11();
    color("black") translate([147, 145, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_mar11();
    color([0.93, 0.93, 0.93]) translate([145, 112, 0]) linear_extrude(height = th) projection(cut = true) part_mar11();
    color("black") translate([145, 112, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar11();

    // Main assembly and section.
    translate([305, 160, 0]) rotate([70, 0, 18]) scale([1.0, 1.0, 1.0]) mars_pointer_assembly();
    color("black") translate([275, 72, 0]) linear_extrude(height = th) label("Mars pointer assembly", sz = 2.9);
    color("black") translate([271, 201, 0]) linear_extrude(height = th) label("Tight press fit mar11 to Mars pointer sub", sz = 2.7);
    color("black") translate([280, 192, 0]) linear_extrude(height = th) label("assembly after fitted to superior", sz = 2.7);
    color("black") translate([291, 183, 0]) linear_extrude(height = th) label("planet plate assembly", sz = 2.7);

    color([0.93, 0.93, 0.93]) translate([333, 107, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([90, 0, 0]) part_mar11();
    color("black") translate([333, 107, 0.01]) linear_extrude(height = th)
        outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_mar11();
    color("black") translate([340, 86, 0]) linear_extrude(height = th) label("SECTION L-L", sz = 4.4, bold = true);
    color("black") translate([352, 76, 0]) linear_extrude(height = th) label("SCALE 2 : 1", sz = 3.3, bold = true);

    // Subassembly inset.
    translate([114, 18, 0]) rotate([70, 0, 22]) scale([1.0, 1.0, 1.0]) {
        color([0.32, 0.27, 0.24]) part_mar11();
        color([0.42, 0.30, 0.18]) translate([0, 0, -1.6]) part_mar5();
    }
    color("black") translate([95, 26, 0]) linear_extrude(height = th) label("mar5 sub assembly", sz = 2.8);
    color("black") translate([96, 78, 0]) linear_extrude(height = th) label("Very tight press fit mar11 to mar5", sz = 2.6);

    // Key dimensions.
    color("black") {
        translate([44, 101, 0]) linear_extrude(height = th) label("R19.58", sz = 2.8);
        translate([44, 91, 0]) linear_extrude(height = th) label("R18.50", sz = 2.8);
        translate([102, 98, 0]) linear_extrude(height = th) label("\u230012.5", sz = 2.8);

        translate([146, 145, 0]) linear_extrude(height = th) label("21.8", sz = 2.8);
        translate([142, 136, 0]) linear_extrude(height = th) label("Fitted ?", sz = 2.8);
        translate([145, 112, 0]) linear_extrude(height = th) label("\u230011.50", sz = 2.8);
        translate([168, 112, 0]) linear_extrude(height = th) label("\u230012.85", sz = 2.8);
        translate([170, 103, 0]) linear_extrude(height = th) label("\u230012.5", sz = 2.8);
        translate([33, 135, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
        translate([138, 135, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
        translate([138, 125, 0]) linear_extrude(height = th) label("2.0", sz = 2.8);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw013_sheet7();
}
