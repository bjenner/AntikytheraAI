// DRW-010 Sheet 5 recreation (Front plate fp2 front panel dial frame).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-010-Front-Plate/fp2_front_panel_dial_frame.scad>

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

module drw010_sheet5() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Front Plate   (fp2 Front Panel Dial frame)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 5 OF 9", sz = 2.9);

    // 3D preview on left.
    color([0.42, 0.30, 0.18]) translate([85, 116, 11]) rotate([66, 0, 8]) scale([1.1, 1.1, 1.1]) part_fp2();
    color("black") translate([76, 190, 0]) linear_extrude(height = th) label("fp2", sz = 3.2, bold = true);

    // 2D engineering top view.
    color([0.93, 0.93, 0.93]) translate([278, 149, 0]) linear_extrude(height = th) projection(cut = true) part_fp2();
    color("black") translate([278, 149, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_fp2();

    // Side/thickness strip.
    color([0.93, 0.93, 0.93]) translate([392, 148, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_fp2();
    color("black") translate([392, 148, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_fp2();

    // Key dimensions.
    color("black") {
        translate([213, 250, 0]) linear_extrude(height = th) label("7.50", sz = 3.0);
        translate([243, 246, 0]) linear_extrude(height = th) label("84.5", sz = 3.0);
        translate([322, 246, 0]) linear_extrude(height = th) label("184.0", sz = 3.0);
        translate([190, 150, 0]) linear_extrude(height = th) label("184.0", sz = 3.0);
        translate([208, 210, 0]) linear_extrude(height = th) label("\u23005.0", sz = 3.0);
        translate([212, 130, 0]) linear_extrude(height = th) label("7.50", sz = 3.0);
        translate([356, 138, 0]) linear_extrude(height = th) label("7.50", sz = 3.0);
        translate([236, 122, 0]) linear_extrude(height = th) label("\u2300163.4", sz = 3.0);
        translate([250, 147, 0]) linear_extrude(height = th) label("4", sz = 2.8);
        translate([261, 147, 0]) linear_extrude(height = th) label("3", sz = 2.8);
        translate([257, 258, 0]) linear_extrude(height = th) label("0.4", sz = 2.8);
        translate([383, 245, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw010_sheet5();
}
