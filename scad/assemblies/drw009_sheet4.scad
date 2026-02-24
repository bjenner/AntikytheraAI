// DRW-009 Sheet 4 recreation (Exeligmos exe1 subassembly).
// SPDX-License-Identifier: MIT

use <../parts/exe1_rivet_pin.scad>
use <../parts/cp2_slider.scad>
use <../parts/h1_gear.scad>
use <../parts/h2_pinion.scad>
use <../parts/h3_hub.scad>

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

module exe1_subassembly() {
    color([0.36, 0.27, 0.20]) rotate([65, 0, 26]) part_cp2();
    color([0.40, 0.30, 0.20]) translate([0, 0, 0.8]) rotate([8, 72, 22]) part_exe1();
}

module exeligmos_context_stack() {
    color([0.44, 0.30, 0.18]) part_h1();
    color([0.36, 0.28, 0.22]) part_h3();
    color([0.48, 0.31, 0.18]) translate([0, 0, 0.2]) part_h2();
    color([0.36, 0.27, 0.20]) translate([0, 0, 9.2]) rotate([0, 0, -90]) part_cp2();
    color([0.30, 0.22, 0.16]) translate([0, 0, 9.8]) part_exe1();
}

module drw009_sheet4() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Exeligmos   (exe1)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 4 OF 6", sz = 2.9);

    // Left: exe1 detail part
    color([0.35, 0.26, 0.18]) translate([64, 214, 14]) rotate([20, 72, 20]) scale([1.9, 1.9, 1.9]) part_exe1();
    color("black") translate([25, 222, 0]) linear_extrude(height = th) label("exe1", sz = 3.0, bold = true);

    // Left-lower 2D views for exe1.
    color([0.93, 0.93, 0.93]) translate([42, 140, 0]) linear_extrude(height = th) projection(cut = true) rotate([0, 90, 0]) part_exe1();
    color("black") translate([42, 140, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rotate([0, 90, 0]) part_exe1();
    color([0.93, 0.93, 0.93]) translate([58, 112, 0]) linear_extrude(height = th) projection(cut = true) part_exe1();
    color("black") translate([58, 112, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_exe1();
    color("black") {
        translate([24, 151, 0]) linear_extrude(height = th) label("11.6", sz = 2.9);
        translate([34, 145, 0]) linear_extrude(height = th) label("10.0", sz = 2.9);
        translate([75, 117, 0]) linear_extrude(height = th) label("\u23001.5", sz = 2.9);
        translate([75, 107, 0]) linear_extrude(height = th) label("\u23002.0", sz = 2.9);
    }

    // Center: cp2 + exe1 subassembly
    translate([145, 172, 14]) exe1_subassembly();
    color("black") translate([112, 181, 0]) linear_extrude(height = th) label("Rivit exe2 to exe1", sz = 3.0);
    color("black") translate([112, 138, 0]) linear_extrude(height = th) label("exe1 sub assembly", sz = 3.0);

    // Right-center: context assembly with section-like view.
    translate([251, 137, 14]) rotate([90, 0, 0]) scale([2.2, 2.2, 2.2]) exeligmos_context_stack();
    color("black") translate([236, 120, 0]) linear_extrude(height = th) label("exe1 assembly", sz = 3.0);

    color([0.93, 0.93, 0.93])
    translate([318, 146, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([0, 90, 0]) exeligmos_context_stack();
    color("black")
    translate([318, 146, 0.01]) linear_extrude(height = th)
        outline2d(0.30) projection(cut = true) rotate([0, 90, 0]) exeligmos_context_stack();

    color("black") {
        translate([328, 168, 0]) linear_extrude(height = th) label("SECTION D-D", sz = 4.0, bold = true);
        translate([336, 158, 0]) linear_extrude(height = th) label("SCALE 2 : 1", sz = 3.6, bold = true);
    }
}
