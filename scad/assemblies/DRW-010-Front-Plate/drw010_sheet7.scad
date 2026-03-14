// DRW-010 Sheet 7 recreation (Front plate fp4 to fp5).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-010-Front-Plate/fp4_egyptian_dial.scad>
use <../../parts/DRW-010-Front-Plate/fp5_rivet.scad>

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

module drw010_sheet7() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (fp4 Egyptian Dial, fp5)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 7 OF 9", sz = 2.9);

    // 2D engineering views.
    color([0.93, 0.93, 0.93]) translate([115, 98, 0]) linear_extrude(height = th) projection(cut = true) part_fp4();
    color("black") translate([115, 98, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_fp4();

    color([0.93, 0.93, 0.93]) translate([84, 235, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp4();
    color("black") translate([84, 235, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_fp4();

    // 3D dial.
    color([0.34, 0.26, 0.20]) translate([262, 205, 10]) rotate([66, 0, 25]) scale([1.03, 1.03, 1.03]) part_fp4();
    color("black") translate([255, 247, 0]) linear_extrude(height = th) label("fp4", sz = 3.1, bold = true);

    // fp5 isolated.
    color([0.40, 0.31, 0.22]) translate([355, 224, 10]) rotate([75, 0, 20]) scale([2.0, 2.0, 2.0]) part_fp5();
    color("black") translate([370, 247, 0]) linear_extrude(height = th) label("fp5", sz = 3.1, bold = true);

    // fp4 + fp5 subassembly callout.
    color([0.34, 0.26, 0.20]) translate([286, 84, 7]) rotate([68, 0, 20]) scale([1.03, 1.03, 1.03]) part_fp4();
    color([0.40, 0.31, 0.22]) translate([326, 107, 15]) rotate([75, 0, 20]) scale([2.0, 2.0, 2.0]) part_fp5();
    color("black") translate([332, 118, 0]) linear_extrude(height = th) label("Rivet fp5 to fp4", sz = 2.9);
    color("black") translate([312, 49, 0]) linear_extrude(height = th) label("fp4 sub assembly", sz = 2.9);

    // Key dimensions from source.
    color("black") {
        translate([138, 255, 0]) linear_extrude(height = th) label("\u2300163.35", sz = 3.0);
        translate([140, 243, 0]) linear_extrude(height = th) label("144.9", sz = 3.0);
        translate([138, 231, 0]) linear_extrude(height = th) label("148.1", sz = 3.0);
        translate([138, 219, 0]) linear_extrude(height = th) label("163.4", sz = 3.0);
        translate([155, 160, 0]) linear_extrude(height = th) label("\u2300163.4", sz = 3.0);
        translate([202, 169, 0]) linear_extrude(height = th) label("R.75", sz = 3.0);
        translate([375, 170, 0]) linear_extrude(height = th) label("\u23005", sz = 3.0);
        translate([370, 158, 0]) linear_extrude(height = th) label("\u23003.5", sz = 3.0);
        translate([360, 146, 0]) linear_extrude(height = th) label("\u23002", sz = 3.0);
        translate([346, 146, 0]) linear_extrude(height = th) label("\u23001.5", sz = 3.0);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw010_sheet7();
}
