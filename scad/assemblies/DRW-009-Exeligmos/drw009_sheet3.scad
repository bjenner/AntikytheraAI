// DRW-009 Sheet 3 recreation (g2 to h1, h2 to i1 gear clearances).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-009-Exeligmos/g2_pinion.scad>
use <../../parts/DRW-009-Exeligmos/h1_gear.scad>
use <../../parts/DRW-009-Exeligmos/h2_pinion.scad>
use <../../parts/DRW-009-Exeligmos/i1_gear.scad>
use <../../parts/DRW-009-Exeligmos/h3_hub.scad>
use <../../parts/DRW-009-Exeligmos/i2_hub.scad>

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

module base_plate_ref_2d(w = 332, h = 194) {
    difference() {
        square([w, h], center = true);
        for (sx = [-1, 1], sy = [-1, 1]) {
            translate([sx * (w / 2 - 7.5), sy * (h / 2 - 7.5)]) circle(d = 4.0, $fn = 24);
        }
        for (x = [-30, 0, 30], y = [-40, 0, 40]) {
            translate([x + 48, y]) circle(d = 3.2, $fn = 22);
        }
    }
}

module clearance_cluster_2d() {
    // Centers set to reflect callouts: h2-i1 ~16.30, g2-h1 ~18.14
    i1c = [0, -16.3];
    h2c = [0, 0];
    h1c = [18.1, 0];
    g2c = [18.1, 18.1];

    // dashed guide circles
    color([0, 0, 0, 1]) {
        translate(i1c) outline2d(0.25) circle(r = 12.50, $fn = 120);
        translate(h2c) outline2d(0.25) circle(r = 3.60, $fn = 96);
        translate(h1c) outline2d(0.25) circle(r = 13.99, $fn = 140);
        translate(g2c) outline2d(0.25) circle(r = 4.96, $fn = 96);
    }

    // projected gear edges (solid)
    translate(i1c) outline2d(0.33) projection(cut = true) part_i1();
    translate(h2c) outline2d(0.33) projection(cut = true) part_h2();
    translate(h1c) outline2d(0.33) projection(cut = true) part_h1();
    translate(g2c) outline2d(0.33) projection(cut = true) part_g2();
}

module section_stack() {
    color([0.44, 0.30, 0.18]) part_i1();
    color([0.36, 0.28, 0.22]) part_i2();
    color([0.48, 0.31, 0.18]) translate([0, 0, 0.2]) part_h2();
    color([0.44, 0.30, 0.18]) translate([0, 0, 1.6]) part_h1();
    color([0.36, 0.28, 0.22]) translate([0, 0, 1.8]) part_h3();
    color([0.48, 0.31, 0.18]) translate([0, 0, 3.6]) part_g2();
}

module drw009_sheet3() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Exeligmos  (g2 to h1, h2 to i1 gear clearance)", sz = 2.6);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 3 OF 6", sz = 2.9);

    // Main rectangle and internal field.
    color([0.95, 0.95, 0.95]) translate([210, 160, 0]) linear_extrude(height = th) base_plate_ref_2d();
    color("black") translate([210, 160, 0.01]) linear_extrude(height = th) outline2d(0.30) base_plate_ref_2d();

    // Cluster placement like source (left-center inside rectangle)
    color("black") translate([146, 148, 0.02]) linear_extrude(height = th) clearance_cluster_2d();

    // left-side stacked section strip
    color([0.93, 0.93, 0.93])
    translate([28, 148, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([0, 90, 0]) scale([1.0, 1.0, 1.4]) section_stack();
    color("black")
    translate([28, 148, 0.01]) linear_extrude(height = th)
        outline2d(0.30) projection(cut = true) rotate([0, 90, 0]) scale([1.0, 1.0, 1.4]) section_stack();

    // right section E-E
    color([0.93, 0.93, 0.93])
    translate([382, 148, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([0, 90, 0]) scale([1.1, 1.1, 1.1]) section_stack();
    color("black")
    translate([382, 148, 0.01]) linear_extrude(height = th)
        outline2d(0.30) projection(cut = true) rotate([0, 90, 0]) scale([1.1, 1.1, 1.1]) section_stack();

    color("black") {
        translate([361, 121, 0]) linear_extrude(height = th) label("SECTION E-E", sz = 4.0, bold = true);
        translate([368, 111, 0]) linear_extrude(height = th) label("SCALE 1:1", sz = 3.5, bold = true);

        translate([91, 190, 0]) linear_extrude(height = th) label("g2 to h1 gear centers", sz = 3.0);
        translate([91, 183, 0]) linear_extrude(height = th) label("3.95+0.2+13.99=R18.14=D36.28", sz = 2.7);
        translate([106, 176, 0]) linear_extrude(height = th) label("36.07", sz = 2.7);
        translate([61, 73, 0]) linear_extrude(height = th) label("h2 to i1 gear centers", sz = 3.0);
        translate([61, 66, 0]) linear_extrude(height = th) label("12.50+0.2+3.60=R16.30=D32.60", sz = 2.7);
        translate([101, 59, 0]) linear_extrude(height = th) label("16.30", sz = 2.7);

        translate([77, 29, 0]) linear_extrude(height = th) label("h2 to i1 0.2mm gear clearance", sz = 3.0);
        translate([129, 216, 0]) linear_extrude(height = th) label("g2 to h1 0.2mm gear clearance", sz = 3.0);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw009_sheet3();
}
