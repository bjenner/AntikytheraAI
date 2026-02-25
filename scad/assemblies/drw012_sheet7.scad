// DRW-012 Sheet 7 recreation (Jupiter, jup4/jup9/cp-f6 context).
// SPDX-License-Identifier: MIT

use <../parts/jup4_gear.scad>
use <../parts/jup9_rivet_pin.scad>
use <../parts/jup11_sleeve.scad>
use <../parts/cpf6_fork.scad>

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

module jup4_subassembly() {
    color([0.42, 0.30, 0.18]) part_jup4();
    color([0.42, 0.30, 0.18]) translate([0, 0, 1.0]) part_cpf6();
    color([0.30, 0.26, 0.24]) translate([0, 0, 2.0]) part_jup11();
    color([0.34, 0.30, 0.27]) translate([8.2 * cos(-102), 8.2 * sin(-102), 1.0]) part_jup9();
}

module drw012_sheet7() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Jupiter   (jup4, jup9, cp-f6)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 7 OF 9", sz = 2.9);

    // Top previews.
    color([0.42, 0.30, 0.18]) translate([62, 210, 9]) rotate([68, 0, 25]) scale([1.7, 1.7, 1.7]) part_jup4();
    color("black") translate([78, 232, 0]) linear_extrude(height = th) label("jup4", sz = 3.0, bold = true);

    color([0.34, 0.30, 0.27]) translate([160, 136, 8]) scale([1.7, 1.7, 1.7]) part_jup9();
    color("black") translate([154, 156, 0]) linear_extrude(height = th) label("jup9", sz = 3.0, bold = true);

    // 2D gear views.
    color([0.93, 0.93, 0.93]) translate([56, 88, 0]) linear_extrude(height = th) projection(cut = true) part_jup4();
    color("black") translate([56, 88, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup4();

    color([0.93, 0.93, 0.93]) translate([30, 114, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_jup4();
    color("black") translate([30, 114, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup4();

    // Main section-style assembly.
    translate([338, 142, 0]) rotate([70, 0, 24]) scale([1.15, 1.15, 1.15]) jup4_subassembly();
    color("black") translate([309, 180, 0]) linear_extrude(height = th) label("F", sz = 8.5, bold = true);
    color("black") translate([368, 148, 0]) linear_extrude(height = th) label("F", sz = 8.5, bold = true);
    color("black") translate([357, 104, 0]) linear_extrude(height = th) label("jup10", sz = 2.8, bold = true);
    color("black") translate([353, 97, 0]) linear_extrude(height = th) label("jup11", sz = 2.8, bold = true);

    color([0.93, 0.93, 0.93]) translate([300, 102, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([90, 0, 0]) jup4_subassembly();
    color("black") translate([300, 102, 0.01]) linear_extrude(height = th)
        outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) jup4_subassembly();

    color("black") translate([348, 216, 0]) linear_extrude(height = th) label("SECTION F-F", sz = 4.6, bold = true);
    color("black") translate([355, 206, 0]) linear_extrude(height = th) label("SCALE 2 : 1", sz = 3.4, bold = true);

    // Subassembly view.
    translate([145, 16, 0]) rotate([70, 0, 22]) scale([1.05, 1.05, 1.05]) jup4_subassembly();
    color("black") translate([117, 94, 0]) linear_extrude(height = th) label("jup3-jup4 sub assembly", sz = 2.8);
    color("black") translate([197, 61, 0]) linear_extrude(height = th) label("cp-f6", sz = 2.8, bold = true);
    color("black") translate([209, 180, 0]) linear_extrude(height = th) label("Rivet jup9 to jup4", sz = 2.8);

    // Dimension annotations.
    color("black") {
        translate([44, 101, 0]) linear_extrude(height = th) label("R14.43", sz = 2.8);
        translate([44, 91, 0]) linear_extrude(height = th) label("R15.47", sz = 2.8);
        translate([98, 100, 0]) linear_extrude(height = th) label("\u230010.0", sz = 2.8);
        translate([94, 67, 0]) linear_extrude(height = th) label("\u23001.5", sz = 2.8);
        translate([94, 58, 0]) linear_extrude(height = th) label("\u23003.5", sz = 2.8);
        translate([67, 50, 0]) linear_extrude(height = th) label("12.2", sz = 2.8);
        translate([130, 82, 0]) linear_extrude(height = th) label("-8.2", sz = 2.8);
        translate([150, 136, 0]) linear_extrude(height = th) label("2.7", sz = 2.8);
        translate([145, 125, 0]) linear_extrude(height = th) label("\u23001.5", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw012_sheet7();
}
