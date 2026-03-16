// DRW-002 Sheet 8 recreation (b7 to b10).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b7_hub.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b8_rivet_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b9_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b10_disc.scad>
use <./drw002_b7_subassembly.scad>

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

module drw002_sheet8() {
    W = 420;
    H = 297;
    B = 8;
    th = 0.12;

    // Border.
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (b7 to b10)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 8 OF 10", sz = 2.9);

    // Top-row part isometrics.
    color([0.45, 0.30, 0.18]) translate([56, 234, 16]) rotate([28, 0, -28]) scale([1.6, 1.6, 1.6]) translate([0, 0, 6.95]) part_b7();
    color([0.2, 0.2, 0.2]) translate([162, 246, 16]) rotate([0, 90, 0]) part_b8();
    color([0.2, 0.2, 0.2]) translate([214, 246, 16]) rotate([0, 90, 0]) part_b9();
    color([0.45, 0.30, 0.18]) translate([318, 238, 16]) rotate([74, 0, 20]) scale([1.6, 1.6, 1.6]) part_b10();

    // b7 orthographic callout views (left-center).
    color([0.93, 0.93, 0.93]) translate([62, 165, 0]) linear_extrude(height = th) projection(cut = true) part_b7();
    color("black") translate([62, 165, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = true) part_b7();

    color([0.93, 0.93, 0.93]) translate([62, 92, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_b7();
    color("black") translate([62, 92, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = true) rotate([90, 0, 0]) part_b7();

    // b10 orthographic linework (right-mid).
    color([0.93, 0.93, 0.93]) translate([278, 112, 0]) linear_extrude(height = th) b10_profile_2d();
    color("black") translate([278, 112, 0.01]) linear_extrude(height = th) outline2d(0.32) b10_profile_2d();

    // Combined subassembly render.
    translate([186, 56, 16]) rotate([20, 0, -20]) scale([2.0, 2.0, 2.0]) drw002_b7_subassembly();
    color("black") translate([166, 50, 0]) linear_extrude(height = th) label("Rivet b8 and b9 to b7.", sz = 3.0);

    // Labels + leaders.
    color("black") translate([76, 272, 0]) linear_extrude(height = th) label("b7", sz = 3.1, bold = true);
    color("black") translate([171, 272, 0]) linear_extrude(height = th) label("b8 x 2", sz = 3.1, bold = true);
    color("black") translate([223, 272, 0]) linear_extrude(height = th) label("b9 x 2", sz = 3.1, bold = true);
    color("black") translate([328, 272, 0]) linear_extrude(height = th) label("b10", sz = 3.1, bold = true);

    color("black")
    linear_extrude(height = th) {
        line2d([87, 270], [74, 248], 0.24);
        line2d([178, 270], [162, 249], 0.24);
        line2d([231, 270], [214, 249], 0.24);
        line2d([337, 270], [320, 246], 0.24);
        line2d([212, 50], [205, 63], 0.24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet8();
}
