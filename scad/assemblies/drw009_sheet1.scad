// DRW-009 Sheet 1 recreation (Exeligmos assembly view).
// Assembly-only sheet; no new standalone parts.
// SPDX-License-Identifier: MIT

use <../parts/i1_gear.scad>
use <../parts/i2_hub.scad>
use <../parts/h1_gear.scad>
use <../parts/h2_pinion.scad>
use <../parts/h3_hub.scad>
use <../parts/g2_pinion.scad>
use <../parts/exe1_rivet_pin.scad>
use <../parts/cp1_pointer_small.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.28) {
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

module exeligmos_plate_2d(w = 332, h = 140, corner = 2.5) {
    difference() {
        minkowski() {
            square([w - 2 * corner, h - 2 * corner], center = true);
            circle(r = corner, $fn = 24);
        }
        // perimeter mounting holes
        for (sx = [-1, 1], sy = [-1, 1]) {
            translate([sx * (w / 2 - 9), sy * (h / 2 - 9)]) circle(d = 3.0, $fn = 24);
        }
        for (x = [-55, -15, 25, 65]) {
            translate([x, h / 2 - 8]) circle(d = 2.4, $fn = 20);
            translate([x - 10, -h / 2 + 8]) circle(d = 2.4, $fn = 20);
        }
        // central and local cluster holes
        circle(d = 6.0, $fn = 30);
        translate([-8, -5]) circle(d = 2.0, $fn = 20);
        translate([-4, -1]) circle(d = 2.0, $fn = 20);
        translate([2, 3]) circle(d = 2.0, $fn = 20);
        translate([12, 8]) circle(d = 2.4, $fn = 20);
        translate([26, 6]) circle(d = 2.8, $fn = 20);
        translate([38, 5]) circle(d = 3.0, $fn = 20);
        translate([44, -2]) circle(d = 2.2, $fn = 20);
        translate([54, -10]) circle(d = 2.6, $fn = 20);
    }
}

module exeligmos_assembly_cluster() {
    // i1 + i2 group
    color([0.44, 0.30, 0.18]) part_i1();
    color([0.36, 0.28, 0.22]) part_i2();

    // h1/h2/h3 stacked with small offset at neighboring center
    translate([18.14, 0, 0]) {
        color([0.44, 0.30, 0.18]) part_h1();
        color([0.36, 0.28, 0.22]) part_h3();
        color([0.48, 0.31, 0.18]) translate([0, 0, 0.25]) part_h2();
        color([0.48, 0.31, 0.18]) translate([0, 18.14, 1.8]) part_g2();
    }

    // pointer + rivet above cluster
    color([0.36, 0.27, 0.20]) translate([0, 24, 7.8]) rotate([0, 0, -90]) part_cp1();
    color([0.22, 0.22, 0.22]) translate([0, 26, 8.6]) part_exe1();
}

module drw009_sheet1() {
    W = 420;
    H = 297;
    B = 8;
    th = 0.12;

    // Border
    color("black")
    linear_extrude(height = th)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W - 2 * B, H - 2 * B], center = false);
    }

    // Title block
    color("black")
    linear_extrude(height = th) {
        outline2d(0.4) translate([285, 8]) square([127, 34], center = false);
        line2d([285, 20], [412, 20], 0.28);
        line2d([285, 30], [412, 30], 0.28);
        line2d([325, 8], [325, 42], 0.28);
        line2d([376, 8], [376, 42], 0.28);
    }
    color("black") translate([289, 37, 0]) linear_extrude(height = th) label("PROJECT   Antikithera Mechanism", sz = 3.1, bold = true);
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Exeligmos   (assembly)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 1 OF 6", sz = 2.9);

    // Main assembled plate and cluster
    translate([210, 145, 10]) rotate([66, 0, -8]) {
        color([0.45, 0.30, 0.18]) linear_extrude(height = 2.0) exeligmos_plate_2d();
        color([0.42, 0.29, 0.18]) translate([70, 22, 2.0]) rotate([0, 0, 10]) scale([1.05, 1.05, 1.05]) exeligmos_assembly_cluster();
    }
}
