// DRW-002 Sheet 6 recreation (b0 to b4).
// SPDX-License-Identifier: MIT

use <../parts/b0_gear.scad>
use <../parts/b1_main_wheel.scad>
use <../parts/b2_gear_ring.scad>
use <../parts/b3_gear.scad>
use <../parts/b4_rivet_pin.scad>
use <drw002_b2_subassembly.scad>

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

module drw002_sheet6() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (b0 to b4)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 6 OF 10", sz = 2.9);

    // b1 large wheel technical views.
    color([0.93, 0.93, 0.93])
    translate([82, 184, 0]) linear_extrude(height = th) b1_wheel_2d();
    color("black")
    translate([82, 184, 0.01]) linear_extrude(height = th) outline2d(0.28) b1_wheel_2d();

    color([0.93, 0.93, 0.93])
    translate([88, 40, 0]) linear_extrude(height = th) b1_wheel_2d();
    color("black")
    translate([88, 40, 0.01]) linear_extrude(height = th) outline2d(0.28) b1_wheel_2d();

    // b1 iso.
    color([0.45, 0.30, 0.18])
    translate([178, 76, 16]) rotate([72, 0, 30]) scale([0.95, 0.95, 0.95]) part_b1();
    color("black") translate([195, 168, 0]) linear_extrude(height = th) label("b1 sheet metal cut patern", sz = 2.8);

    // b0 and b3 gears (top-right).
    color([0.90, 0.90, 0.90]) translate([218, 220, 0]) linear_extrude(height = th) b0_gear_2d();
    color("black") translate([218, 220, 0.01]) linear_extrude(height = th) outline2d(0.28) b0_gear_2d();
    color([0.45, 0.30, 0.18]) translate([246, 246, 16]) rotate([66, 0, 35]) part_b0();

    color([0.90, 0.90, 0.90]) translate([292, 220, 0]) linear_extrude(height = th) b3_gear_2d();
    color("black") translate([292, 220, 0.01]) linear_extrude(height = th) outline2d(0.28) b3_gear_2d();
    color([0.45, 0.30, 0.18]) translate([334, 244, 16]) rotate([66, 0, 35]) part_b3();

    // b2 and b4 lower-right.
    color([0.93, 0.93, 0.93]) translate([314, 116, 0]) linear_extrude(height = th) b2_gear_2d();
    color("black") translate([314, 116, 0.01]) linear_extrude(height = th) outline2d(0.30) b2_gear_2d();
    translate([332, 58, 16]) rotate([66, 0, 26]) scale([1.4, 1.4, 1.4]) drw002_b2_subassembly();

    color([0.25, 0.25, 0.25]) translate([276, 84, 16]) rotate([90, 0, 0]) part_b4();
    color("black") translate([264, 80, 0]) linear_extrude(height = th) label("b4 x 4", sz = 3.0, bold = true);
    color("black") translate([251, 70, 0]) linear_extrude(height = th) label("Rivet b4 x 2 to b2", sz = 2.8);

    // Labels.
    color("black") translate([213, 248, 0]) linear_extrude(height = th) label("b0 sheet metal cut pattern", sz = 2.7);
    color("black") translate([314, 250, 0]) linear_extrude(height = th) label("b3", sz = 3.0, bold = true);
    color("black") translate([335, 92, 0]) linear_extrude(height = th) label("b2", sz = 3.0, bold = true);
    color("black") translate([337, 50, 0]) linear_extrude(height = th) label("b2 sub assembly", sz = 2.8);

    // Leaders.
    color("black") linear_extrude(height = th) {
        line2d([278, 82], [277, 91], 0.24);
        line2d([262, 70], [274, 81], 0.24);
        line2d([339, 91], [334, 74], 0.24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet6();
}
