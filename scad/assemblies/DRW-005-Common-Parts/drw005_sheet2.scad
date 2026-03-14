// DRW-005 Sheet 2 recreation (Common Parts cp-r1 to cp-r6).
// Refactored to use standalone part modules.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-005-Common-Parts/cpr1_rivet.scad>
use <../../parts/DRW-005-Common-Parts/cpr2_rivet.scad>
use <../../parts/DRW-005-Common-Parts/cpr3_rivet.scad>
use <../../parts/DRW-005-Common-Parts/cpr4_rivet.scad>
use <../../parts/DRW-005-Common-Parts/cpr5_rivet.scad>
use <../../parts/DRW-005-Common-Parts/cpr6_rivet.scad>

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

module drw005_sheet2() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Common Parts (cp-r1 to cp-r6)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 2 OF 3", sz = 2.9);

    // Top row rivets.
    translate([58, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) part_cpr1();
    translate([160, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) part_cpr2();
    translate([260, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) part_cpr3();
    translate([350, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) part_cpr4();

    // Bottom row rivets.
    translate([80, 108, 16]) rotate([65, 0, 20]) scale([2.4, 2.4, 2.4]) part_cpr5();
    translate([165, 106, 16]) rotate([65, 0, 20]) scale([2.6, 2.6, 2.6]) part_cpr6();

    // Labels.
    color("black") translate([72, 256, 0]) linear_extrude(height = th) label("cp-r1", sz = 3.0, bold = true);
    color("black") translate([176, 256, 0]) linear_extrude(height = th) label("cp-r2", sz = 3.0, bold = true);
    color("black") translate([276, 256, 0]) linear_extrude(height = th) label("cp-r3", sz = 3.0, bold = true);
    color("black") translate([366, 256, 0]) linear_extrude(height = th) label("cp-r4", sz = 3.0, bold = true);
    color("black") translate([96, 126, 0]) linear_extrude(height = th) label("cp-r5", sz = 3.0, bold = true);
    color("black") translate([182, 126, 0]) linear_extrude(height = th) label("cp-r6", sz = 3.0, bold = true);

    // 2D references.
    color([0.92, 0.92, 0.92]) {
        translate([48, 180, 0]) linear_extrude(height = th) projection(cut = true) part_cpr1();
        translate([145, 172, 0]) linear_extrude(height = th) projection(cut = true) part_cpr2();
        translate([245, 174, 0]) linear_extrude(height = th) projection(cut = true) part_cpr3();
        translate([336, 172, 0]) linear_extrude(height = th) projection(cut = true) part_cpr4();
        translate([66, 58, 0]) linear_extrude(height = th) projection(cut = true) part_cpr5();
        translate([156, 56, 0]) linear_extrude(height = th) projection(cut = true) part_cpr6();
    }

    color("black") {
        translate([48, 180, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpr1();
        translate([145, 172, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpr2();
        translate([245, 174, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpr3();
        translate([336, 172, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpr4();
        translate([66, 58, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpr5();
        translate([156, 56, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpr6();
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw005_sheet2();
}
