// DRW-005 Sheet 3 recreation (Common Parts cp-f1 to cp-f6).
// Refactored to use standalone part modules.
// SPDX-License-Identifier: MIT

use <../parts/cpf1_fork.scad>
use <../parts/cpf2_fork.scad>
use <../parts/cpf3_fork.scad>
use <../parts/cpf4_fork.scad>
use <../parts/cpf5_fork.scad>
use <../parts/cpf6_fork.scad>

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

module drw005_sheet3() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Common Parts (cp-f1 to cp-f6)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 3 OF 3", sz = 2.9);

    // Top row forks.
    color([0.35, 0.27, 0.20]) translate([46, 246, 16]) rotate([68, 0, 26]) scale([2.0, 2.0, 2.0]) part_cpf1();
    color([0.35, 0.27, 0.20]) translate([148, 246, 16]) rotate([68, 0, 26]) scale([2.0, 2.0, 2.0]) part_cpf2();
    color([0.35, 0.27, 0.20]) translate([260, 246, 16]) rotate([68, 0, 26]) scale([2.0, 2.0, 2.0]) part_cpf3();
    color([0.35, 0.27, 0.20]) translate([356, 246, 16]) rotate([68, 0, 26]) scale([2.0, 2.0, 2.0]) part_cpf4();

    // Bottom row forks.
    color([0.35, 0.27, 0.20]) translate([154, 96, 16]) rotate([68, 0, 28]) scale([2.4, 2.4, 2.4]) part_cpf5();
    color([0.35, 0.27, 0.20]) translate([320, 104, 16]) rotate([68, 0, 28]) scale([2.2, 2.2, 2.2]) part_cpf6();

    // Labels.
    color("black") {
        translate([60, 258, 0]) linear_extrude(height = th) label("cp-f1 x 4", sz = 3.0, bold = true);
        translate([162, 258, 0]) linear_extrude(height = th) label("cp-f2", sz = 3.0, bold = true);
        translate([274, 258, 0]) linear_extrude(height = th) label("cp-f3", sz = 3.0, bold = true);
        translate([370, 258, 0]) linear_extrude(height = th) label("cp-f4", sz = 3.0, bold = true);
        translate([172, 114, 0]) linear_extrude(height = th) label("cp-f5 x 3", sz = 3.0, bold = true);
        translate([333, 120, 0]) linear_extrude(height = th) label("cp-f6 x 2", sz = 3.0, bold = true);
    }

    // 2D guide profiles.
    color([0.92, 0.92, 0.92]) {
        translate([38, 182, 0]) linear_extrude(height = th) projection(cut = true) part_cpf1();
        translate([140, 182, 0]) linear_extrude(height = th) projection(cut = true) part_cpf2();
        translate([252, 182, 0]) linear_extrude(height = th) projection(cut = true) part_cpf3();
        translate([348, 182, 0]) linear_extrude(height = th) projection(cut = true) part_cpf4();
        translate([96, 48, 0]) linear_extrude(height = th) projection(cut = true) part_cpf5();
        translate([246, 48, 0]) linear_extrude(height = th) projection(cut = true) part_cpf6();
    }
    color("black") {
        translate([38, 182, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpf1();
        translate([140, 182, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpf2();
        translate([252, 182, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpf3();
        translate([348, 182, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpf4();
        translate([96, 48, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpf5();
        translate([246, 48, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_cpf6();
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw005_sheet3();
}
