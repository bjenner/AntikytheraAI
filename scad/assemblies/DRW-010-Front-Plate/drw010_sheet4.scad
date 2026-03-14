// DRW-010 Sheet 4 recreation (Front plate fp1 outer plate).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-010-Front-Plate/fp1_front_plate.scad>

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

module drw010_sheet4() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (fp1 Front Plate Outer)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 4 OF 9", sz = 2.9);

    // Engineering top view.
    color([0.93, 0.93, 0.93]) translate([211, 148, 0]) linear_extrude(height = th) projection(cut = true) part_fp1();
    color("black") translate([211, 148, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_fp1();

    // Side strip for thickness.
    color([0.93, 0.93, 0.93]) translate([55, 250, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp1();
    color("black") translate([55, 250, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_fp1();

    // Small 3D preview like source.
    color([0.44, 0.31, 0.19]) translate([218, 20, 8]) rotate([72, 0, 16]) scale([0.32, 0.32, 0.32]) part_fp1();
    color("black") translate([229, 38, 0]) linear_extrude(height = th) label("fp1", sz = 3.0, bold = true);

    // Key dimensions.
    color("black") {
        translate([196, 250, 0]) linear_extrude(height = th) label("318.3", sz = 3.0);
        translate([288, 250, 0]) linear_extrude(height = th) label("84.5", sz = 3.0);
        translate([64, 200, 0]) linear_extrude(height = th) label("84.5", sz = 3.0);
        translate([356, 150, 0]) linear_extrude(height = th) label("184.0", sz = 3.0);
        translate([155, 158, 0]) linear_extrude(height = th) label("\u2300132.0", sz = 3.0);
        translate([181, 251, 0]) linear_extrude(height = th) label("\u23005.0", sz = 3.0);
        translate([190, 241, 0]) linear_extrude(height = th) label("7.50", sz = 3.0);
        translate([188, 68, 0]) linear_extrude(height = th) label("7.50", sz = 3.0);
        translate([385, 252, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
        translate([165, 200, 0]) linear_extrude(height = th) label("0.4", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw010_sheet4();
}
