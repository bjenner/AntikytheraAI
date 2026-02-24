// DRW-010 Sheet 9 recreation (Front plate, fp9 to fp10).
// SPDX-License-Identifier: MIT

use <../parts/fp9_bush.scad>
use <../parts/fp10_zodiac_pointer.scad>

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

module drw010_sheet9() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (fp9 to fp10)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 9 OF 9", sz = 2.9);

    // Isometric part views.
    color([0.29, 0.24, 0.20])
    translate([50, 235, 14]) rotate([68, 0, 26]) scale([2.2, 2.2, 2.2]) part_fp9();
    color("black") translate([59, 248, 0]) linear_extrude(height = th) label("fp9", sz = 3.2, bold = true);

    color([0.42, 0.30, 0.18])
    translate([175, 230, 11]) rotate([70, 0, 20]) scale([1.5, 1.5, 1.5]) part_fp10();
    color("black") translate([176, 185, 0]) linear_extrude(height = th) label("fp10 sheet metal cut pattern", sz = 2.8);

    color([0.42, 0.30, 0.18])
    translate([177, 92, 10]) rotate([70, 0, -20]) scale([1.5, 1.5, 1.5]) part_fp10();

    // fp9 engineering views.
    color([0.93, 0.93, 0.93]) translate([48, 145, 0]) linear_extrude(height = th) projection(cut = true) part_fp9();
    color("black") translate([48, 145, 0.01]) linear_extrude(height = th) outline2d(0.28) projection(cut = true) part_fp9();
    color([0.93, 0.93, 0.93]) translate([47, 80, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp9();
    color("black") translate([47, 80, 0.01]) linear_extrude(height = th) outline2d(0.28) projection(cut = true) rotate([90, 0, 0]) part_fp9();

    // fp10 engineering views.
    color([0.93, 0.93, 0.93]) translate([162, 153, 0]) linear_extrude(height = th) projection(cut = true) part_fp10();
    color("black") translate([162, 153, 0.01]) linear_extrude(height = th) outline2d(0.28) projection(cut = true) part_fp10();
    color([0.93, 0.93, 0.93]) translate([162, 68, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp10();
    color("black") translate([162, 68, 0.01]) linear_extrude(height = th) outline2d(0.28) projection(cut = true) rotate([90, 0, 0]) part_fp10();

    // Subassembly callout view.
    color([0.29, 0.24, 0.20]) translate([311, 117, 10]) rotate([0, 0, -20]) scale([2.2, 2.2, 2.2]) part_fp9();
    color([0.42, 0.30, 0.18]) translate([311, 117, 17]) rotate([0, 0, -20]) scale([2.2, 2.2, 2.2]) part_fp10();
    color("black") translate([295, 168, 0]) linear_extrude(height = th) label("Tight press fit fp10 to fp9", sz = 3.0);
    color("black") translate([300, 95, 0]) linear_extrude(height = th) label("Zodiac angle measurement pointer assembly", sz = 3.0);

    // Minimal key dimensions shown on source sheet.
    color("black") {
        translate([70, 166, 0]) linear_extrude(height = th) label("\u230015.5", sz = 3.0);
        translate([82, 153, 0]) linear_extrude(height = th) label("\u230010.0", sz = 3.0);
        translate([82, 140, 0]) linear_extrude(height = th) label("\u23007.0", sz = 3.0);
        translate([66, 108, 0]) linear_extrude(height = th) label("5.8", sz = 2.8);
        translate([90, 104, 0]) linear_extrude(height = th) label("6.8", sz = 2.8);
        translate([83, 92, 0]) linear_extrude(height = th) label("1.0", sz = 2.8);
        translate([206, 194, 0]) linear_extrude(height = th) label("\u230010.0", sz = 3.0);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw010_sheet9();
}
