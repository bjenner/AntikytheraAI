// DRW-002 Sheet 1 recreation (assembly scene).
// Uses existing b-series parts only.
// SPDX-License-Identifier: MIT

use <../parts/b0_gear.scad>
use <../parts/b1_main_wheel.scad>
use <../parts/b2_gear_ring.scad>
use <../parts/b3_gear.scad>
use <../parts/b4_rivet_pin.scad>
use <../parts/b5_post.scad>
use <../parts/b6_clip.scad>
use <../parts/b7_hub.scad>
use <../parts/b8_rivet_pin.scad>
use <../parts/b9_pin.scad>
use <../parts/b10_disc.scad>
use <../parts/b11_carrier_block.scad>
use <../parts/b12_pin.scad>
use <../parts/b13_roller.scad>
use <../parts/b14_pin.scad>
use <../parts/b15_wire_link.scad>
use <../parts/b16_rivet.scad>
use <../parts/b17_standoff_pin.scad>
use <../parts/b18_link_plate.scad>

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

module roller_subassembly() {
    color([0.40, 0.29, 0.19]) part_b11();
    color([0.45, 0.34, 0.23]) {
        translate([5.2, 20.0, 11.2]) part_b12();
        translate([10.8, 20.0, 11.2]) part_b12();
    }
    color([0.35, 0.25, 0.18]) translate([16, 12, 8.6]) part_b13();
    color([0.70, 0.70, 0.70]) translate([8.0, 6.0, 9.0]) rotate([90, 0, 0]) part_b14();
    color([0.72, 0.72, 0.72]) translate([8.0, 8.0, 6.4]) rotate([0, 90, -20]) part_b15();
    color([0.25, 0.25, 0.25]) translate([12.0, 5.0, 2.2]) rotate([90, 0, 0]) part_b16();
}

module b_drive_cluster() {
    // Main axle and wheel-side gear train.
    color([0.50, 0.42, 0.34]) rotate([90, 0, 90]) part_b7();
    color([0.20, 0.20, 0.20]) translate([5.5, 0, 0]) rotate([90, 0, 90]) part_b8();
    color([0.20, 0.20, 0.20]) translate([-5.5, 0, 0]) rotate([90, 0, 90]) part_b9();

    color([0.45, 0.30, 0.18]) translate([10, 0, 0]) rotate([90, 0, 90]) part_b0();
    color([0.45, 0.30, 0.18]) translate([15, 0, 0]) rotate([90, 0, 90]) part_b2();
    color([0.45, 0.30, 0.18]) translate([19.2, 0, 0]) rotate([90, 0, 90]) part_b3();

    // Rivets on b2.
    color([0.25, 0.25, 0.25])
    for (a = [0, 90, 180, 270])
        rotate([0, 0, a]) translate([10, 0, 16.8]) part_b4();
}

module b_assembly() {
    // Main plate.
    color([0.45, 0.30, 0.18]) part_b1();

    // Superior/internal plate.
    color([0.45, 0.30, 0.18]) translate([0, 0, 22]) part_b18();

    // Plate posts (b17) and standoffs (b5).
    color([0.45, 0.30, 0.18]) {
        for (a = [35, 145, 215, 325])
            rotate([0, 0, a]) translate([55, 0, 2.0]) part_b5();
    }
    color([0.28, 0.28, 0.28]) {
        for (a = [0, 90, 180, 270])
            rotate([0, 0, a]) translate([62, 0, 2.0]) part_b17();
    }

    // Center drive cluster.
    translate([0, 0, 6]) b_drive_cluster();

    // Roller subsystem off-axis.
    translate([24, -22, 8]) rotate([0, 0, -25]) roller_subassembly();

    // Node clip piece mounted near rim.
    color([0.45, 0.30, 0.18]) translate([44, 12, 22]) part_b6();

    // b10 inner discs.
    color([0.45, 0.30, 0.18]) {
        translate([-16, 10, 3]) part_b10();
        translate([-16, 10, 5.3]) part_b10();
    }
}

module drw002_sheet1() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (assembly)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 1 OF 10", sz = 2.9);

    // Top-left side profile.
    translate([70, 214, 16]) rotate([90, 0, 0]) scale([0.95, 0.95, 0.95]) b_assembly();

    // Top-right tilted side view.
    translate([310, 214, 16]) rotate([20, 0, -58]) scale([0.90, 0.90, 0.90]) b_assembly();

    // Bottom-left top view.
    translate([138, 90, 16]) rotate([0, 0, 0]) scale([1.05, 1.05, 1.05]) b_assembly();

    // Bottom-right perspective view.
    translate([305, 56, 16]) rotate([68, 0, 26]) scale([0.92, 0.92, 0.92]) b_assembly();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet1();
}
