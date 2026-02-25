// DRW-013 Sheet 4 recreation (Mars, mar1, mar2, mar6, mar7).
// SPDX-License-Identifier: MIT

use <../parts/mar1_gear.scad>
use <../parts/mar2_gear.scad>
use <../parts/mar6_hub.scad>
use <../parts/mar7_axle.scad>

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

module mar2_subassembly() {
    color([0.42, 0.30, 0.18]) part_mar2();
    color([0.44, 0.32, 0.20]) translate([0, 0, 1.0]) part_mar6();
    color([0.33, 0.27, 0.23]) translate([0, 0, 3.0]) part_mar7();
}

module drw013_sheet4() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Mars   (mar1, mar2, mar6, mar7)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 4 OF 7", sz = 2.9);

    // Top row part previews.
    color([0.42, 0.30, 0.18]) translate([49, 235, 8]) rotate([68, 0, 25]) scale([1.45, 1.45, 1.45]) part_mar1();
    color([0.42, 0.30, 0.18]) translate([207, 235, 8]) rotate([68, 0, 25]) scale([1.45, 1.45, 1.45]) part_mar2();
    color([0.44, 0.32, 0.20]) translate([296, 231, 8]) rotate([68, 0, 20]) scale([1.45, 1.45, 1.45]) part_mar6();
    color([0.33, 0.27, 0.23]) translate([364, 229, 8]) rotate([68, 0, 25]) scale([1.35, 1.35, 1.35]) part_mar7();
    color("black") {
        translate([49, 247, 0]) linear_extrude(height = th) label("mar1", sz = 3.0, bold = true);
        translate([207, 247, 0]) linear_extrude(height = th) label("mar2", sz = 3.0, bold = true);
        translate([296, 247, 0]) linear_extrude(height = th) label("mar6", sz = 3.0, bold = true);
        translate([364, 247, 0]) linear_extrude(height = th) label("mar7", sz = 3.0, bold = true);
    }

    // 2D views.
    color([0.93, 0.93, 0.93]) translate([52, 130, 0]) linear_extrude(height = th) projection(cut = true) part_mar1();
    color("black") translate([52, 130, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar1();

    color([0.93, 0.93, 0.93]) translate([207, 130, 0]) linear_extrude(height = th) projection(cut = true) part_mar2();
    color("black") translate([207, 130, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar2();

    color([0.93, 0.93, 0.93]) translate([298, 146, 0]) linear_extrude(height = th) projection(cut = true) part_mar6();
    color("black") translate([298, 146, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar6();

    color([0.93, 0.93, 0.93]) translate([357, 146, 0]) linear_extrude(height = th) projection(cut = true) part_mar7();
    color("black") translate([357, 146, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar7();

    // Subassembly blocks.
    translate([225, 72, 0]) rotate([75, 0, 20]) scale([1.55, 1.55, 1.55]) mar2_subassembly();
    color("black") translate([230, 93, 0]) linear_extrude(height = th) label("mar2 sub assembly", sz = 2.9);
    color("black") translate([205, 118, 0]) linear_extrude(height = th) label("Tight press fit mar2 to mar6", sz = 2.7);

    translate([336, 74, 0]) rotate([75, 0, 22]) scale([1.55, 1.55, 1.55]) mar2_subassembly();
    color("black") translate([292, 157, 0]) linear_extrude(height = th) label("mar2 sub assembly with mar7 axle", sz = 2.8);

    // Section markers.
    color("black") {
        translate([102, 111, 0]) linear_extrude(height = th) label("SECTION D-D", sz = 5.0, bold = true);
        translate([116, 100, 0]) linear_extrude(height = th) label("SCALE 2:1", sz = 4.0, bold = true);
        translate([234, 17, 0]) linear_extrude(height = th) label("SECTION F-F", sz = 5.0, bold = true);
        translate([248, 6, 0]) linear_extrude(height = th) label("SCALE 2:1", sz = 4.0, bold = true);
        translate([335, 38, 0]) linear_extrude(height = th) label("SECTION H-H", sz = 5.0, bold = true);
        translate([349, 27, 0]) linear_extrude(height = th) label("SCALE 2:1", sz = 4.0, bold = true);
    }

    // Key dimensions and callouts.
    color("black") {
        translate([83, 171, 0]) linear_extrude(height = th) label("R11.14", sz = 2.8);
        translate([83, 180, 0]) linear_extrude(height = th) label("R9.89", sz = 2.8);
        translate([103, 170, 0]) linear_extrude(height = th) label("d7.0", sz = 2.8);

        translate([228, 180, 0]) linear_extrude(height = th) label("R11.70", sz = 2.8);
        translate([228, 171, 0]) linear_extrude(height = th) label("R10.44", sz = 2.8);
        translate([228, 137, 0]) linear_extrude(height = th) label("d5.5", sz = 2.8);

        translate([289, 182, 0]) linear_extrude(height = th) label("d7", sz = 2.8);
        translate([289, 173, 0]) linear_extrude(height = th) label("d5.5", sz = 2.8);
        translate([289, 164, 0]) linear_extrude(height = th) label("d4.0", sz = 2.8);
        translate([286, 197, 0]) linear_extrude(height = th) label("6.0", sz = 2.8);

        translate([353, 182, 0]) linear_extrude(height = th) label("d3.9", sz = 2.8);
        translate([353, 173, 0]) linear_extrude(height = th) label("d3.0", sz = 2.8);
        translate([351, 197, 0]) linear_extrude(height = th) label("8.1", sz = 2.8);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw013_sheet4();
}
