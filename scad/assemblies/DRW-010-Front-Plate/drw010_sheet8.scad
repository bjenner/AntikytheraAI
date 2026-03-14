// DRW-010 Sheet 8 recreation (Front plate fp6 to fp8).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-010-Front-Plate/fp6_post.scad>
use <../../parts/DRW-010-Front-Plate/fp7_post.scad>
use <../../parts/DRW-010-Front-Plate/fp8_post.scad>

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

module drw010_sheet8() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (fp6 to fp8)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 8 OF 9", sz = 2.9);

    // Isometric parts across the top.
    color([0.37, 0.28, 0.20]) translate([95, 188, 12]) rotate([72, 0, 10]) scale([2.1, 2.1, 2.1]) part_fp6();
    color("black") translate([111, 246, 0]) linear_extrude(height = th) label("fp6 x 4", sz = 3.1, bold = true);

    color([0.37, 0.28, 0.20]) translate([194, 202, 10]) rotate([72, 0, 15]) scale([2.2, 2.2, 2.2]) part_fp7();
    color("black") translate([208, 236, 0]) linear_extrude(height = th) label("fp7 x 4", sz = 3.1, bold = true);

    color([0.37, 0.28, 0.20]) translate([315, 202, 10]) rotate([72, 0, 15]) scale([2.2, 2.2, 2.2]) part_fp8();
    color("black") translate([325, 236, 0]) linear_extrude(height = th) label("fp8 x 4", sz = 3.1, bold = true);

    // 2D view blocks.
    color([0.93, 0.93, 0.93]) translate([84, 94, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp6();
    color("black") translate([84, 94, 0.01]) linear_extrude(height = th) outline2d(0.28) projection(cut = true) rotate([90, 0, 0]) part_fp6();

    color([0.93, 0.93, 0.93]) translate([190, 116, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp7();
    color("black") translate([190, 116, 0.01]) linear_extrude(height = th) outline2d(0.28) projection(cut = true) rotate([90, 0, 0]) part_fp7();

    color([0.93, 0.93, 0.93]) translate([310, 116, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp8();
    color("black") translate([310, 116, 0.01]) linear_extrude(height = th) outline2d(0.28) projection(cut = true) rotate([90, 0, 0]) part_fp8();

    // Key dimensions shown on source.
    color("black") {
        translate([54, 114, 0]) linear_extrude(height = th) label("63.0", sz = 3.0);
        translate([112, 116, 0]) linear_extrude(height = th) label("57.6", sz = 3.0);
        translate([95, 146, 0]) linear_extrude(height = th) label("\u230010", sz = 3.0);
        translate([110, 132, 0]) linear_extrude(height = th) label("\u23004.8", sz = 3.0);
        translate([179, 96, 0]) linear_extrude(height = th) label("Fitted 19.5", sz = 3.0);
        translate([292, 96, 0]) linear_extrude(height = th) label("Fitted 34.7", sz = 3.0);
        translate([193, 141, 0]) linear_extrude(height = th) label("\u23001.5", sz = 3.0);
        translate([309, 141, 0]) linear_extrude(height = th) label("\u23001.5", sz = 3.0);
        translate([188, 128, 0]) linear_extrude(height = th) label("\u23005.0", sz = 3.0);
        translate([307, 128, 0]) linear_extrude(height = th) label("\u23005.0", sz = 3.0);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw010_sheet8();
}
