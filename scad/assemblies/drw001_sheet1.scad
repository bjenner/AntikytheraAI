// DRW-001 Sheet 1 recreation (assembly overview).
// Uses existing parts only.
// SPDX-License-Identifier: MIT

use <../parts/a1.scad>
use <../parts/a2_ring.scad>
use <../parts/a3_pin.scad>
use <../parts/a4_block.scad>
use <../parts/a5_ring.scad>
use <../parts/a6_bush.scad>
use <../parts/a7_block.scad>
use <../parts/a8_rivet_pin.scad>
use <../parts/a9_axle.scad>
use <../parts/a10_disc.scad>

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

module a1_subassembly() {
    color([0.45, 0.30, 0.18]) rotate([90, 0, 0]) part_a1(body_d = 30, thickness = 2.0, bore_d = 4, spoke_count = 0);
    color([0.28, 0.23, 0.20]) translate([0, -0.8, 0]) rotate([90, 0, 0]) part_a2();
    color([0.55, 0.46, 0.40]) translate([0, -1.6, 0]) rotate([90, 0, 0]) part_a3(d = 6, h = 9);
    color([0.45, 0.30, 0.18]) translate([0, -2.2, 0]) rotate([0, 0, 0]) part_a4(w = 9, d = 6, h = 9, bore_d = 5);
}

module a8_subassembly() {
    color([0.45, 0.30, 0.18]) part_a10();
    color([0.52, 0.43, 0.34]) translate([0, 0, 2]) part_a9();
    color([0.25, 0.25, 0.25]) translate([6, 0, 3.5]) rotate([90, 0, 0]) part_a8();
    color([0.25, 0.25, 0.25]) translate([-6, 0, 3.5]) rotate([90, 0, 0]) part_a8();
}

module a1_gear_assembly() {
    // Central shaft and left disc.
    color([0.45, 0.30, 0.18]) translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(d = 11, h = 76, center = false);
    color([0.45, 0.30, 0.18]) translate([-4, 0, 0]) rotate([0, 90, 0]) cylinder(d = 125, h = 2, center = true);

    // Right-side mount cluster.
    color([0.45, 0.30, 0.18]) translate([64, -4, -8]) part_a7();
    color([0.38, 0.30, 0.22]) translate([78, 0, 0]) rotate([0, 90, 0]) part_a6();
    color([0.28, 0.23, 0.20]) translate([89, 0, 0]) rotate([0, 90, 0]) part_a5();
    color([0.45, 0.30, 0.18]) translate([95, -5, -7]) part_a4();

    // Gear cluster nose.
    color([0.45, 0.30, 0.18]) translate([104, 0, 0]) rotate([0, 90, 0]) part_a1(body_d = 30, thickness = 2, bore_d = 4, spoke_count = 0);
}

module drw001_sheet1() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (assembly)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 1 OF 7", sz = 2.9);

    // Three-view layout similar to source.
    // Top-left perspective.
    translate([68, 182, 18]) rotate([0, 0, 0]) scale([0.62, 0.62, 0.62]) a1_gear_assembly();

    // Top-right face-on disc with center mechanism.
    translate([260, 178, 16]) rotate([90, 0, 0]) scale([0.72, 0.72, 0.72]) a8_subassembly();

    // Bottom-left oblique.
    translate([108, 67, 18]) rotate([35, 0, 20]) scale([0.72, 0.72, 0.72]) a1_gear_assembly();
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet1();
}
