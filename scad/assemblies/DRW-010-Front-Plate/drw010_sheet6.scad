// DRW-010 Sheet 6 recreation (Front plate fp3 Zodiac dial).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-010-Front-Plate/fp1_front_plate.scad>
use <../../parts/DRW-010-Front-Plate/fp3_zodiac_dial.scad>

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

module drw010_sheet6() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (fp3 Zodiac Dial)", sz = 2.9);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 6 OF 9", sz = 2.9);

    // 2D views (left).
    color([0.93, 0.93, 0.93]) translate([97, 98, 0]) linear_extrude(height = th) projection(cut = true) part_fp3();
    color("black") translate([97, 98, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_fp3();

    color([0.93, 0.93, 0.93]) translate([90, 220, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp3();
    color("black") translate([90, 220, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_fp3();

    // Isometric ring view.
    color([0.33, 0.26, 0.21]) translate([246, 213, 8]) rotate([68, 0, 25]) scale([1.0, 1.0, 1.0]) part_fp3();
    color("black") translate([246, 248, 0]) linear_extrude(height = th) label("fp3", sz = 3.1, bold = true);

    // fp1 sub-assembly preview with fp3 fitted.
    color([0.43, 0.30, 0.18]) translate([307, 133, 10]) rotate([70, 0, -14]) scale([1.05, 1.05, 1.05]) part_fp1();
    color([0.20, 0.20, 0.20]) translate([307, 133, 11.8]) rotate([70, 0, -14]) scale([1.05, 1.05, 1.05]) part_fp3();

    color("black") translate([320, 159, 0]) linear_extrude(height = th) label("fp1", sz = 3.1, bold = true);
    color("black") translate([285, 95, 0]) linear_extrude(height = th) label("Rivet fp1 to fp2 using 4 soft bronze pins", sz = 2.8);
    color("black") translate([330, 56, 0]) linear_extrude(height = th) label("fp1 sub assembly", sz = 2.9);
    color("black") translate([343, 199, 0]) linear_extrude(height = th) label("Zodiac vertical orientation", sz = 2.8);

    // Key dimensions.
    color("black") {
        translate([90, 232, 0]) linear_extrude(height = th) label("\u2300144.8", sz = 3.0);
        translate([90, 220, 0]) linear_extrude(height = th) label("\u2300148.0", sz = 3.0);
        translate([154, 118, 0]) linear_extrude(height = th) label("\u2300148.0", sz = 3.0);
        translate([119, 117, 0]) linear_extrude(height = th) label("\u2300132.0", sz = 3.0);
        translate([154, 234, 0]) linear_extrude(height = th) label("45\u00b0", sz = 3.0);
        translate([185, 250, 0]) linear_extrude(height = th) label("0.4", sz = 2.8);
        translate([183, 236, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw010_sheet6();
}
