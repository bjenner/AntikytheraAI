// DRW-002 Sheet 1 recreation (assembly scene).
// Uses existing b-series parts only.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b0_gear.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b1_main_wheel.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b2_gear_ring.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b3_gear.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b4_rivet_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b5_post.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b6_clip.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b7_hub.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b8_rivet_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b9_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b10_disc.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b11_carrier_block.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b12_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b13_roller.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b14_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b15_wire_link.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b16_rivet.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b17_standoff_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b18_link_plate.scad>
use <./drw002_b9_subassembly.scad>

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
    drw002_b9_subassembly();
}

module b_drive_cluster() {
    // Main axle and wheel-side gear train.
    color([0.50, 0.42, 0.34]) rotate([90, 0, 90]) translate([0, 0, 6.95]) part_b7();
    color([0.20, 0.20, 0.20]) translate([5.5, 0, 0]) rotate([90, 0, 90]) translate([0, 0, 3.1]) part_b8();
    color([0.20, 0.20, 0.20]) translate([-5.5, 0, 0]) rotate([90, 0, 90]) translate([0, 0, 1.75]) part_b9();

    color([0.45, 0.30, 0.18]) translate([10, 0, 0]) rotate([90, 0, 90]) part_b0();
    color([0.45, 0.30, 0.18]) translate([15, 0, 0]) rotate([90, 0, 90]) part_b2();
    color([0.45, 0.30, 0.18]) translate([19.2, 0, 0]) rotate([90, 0, 90]) part_b3();

    // Rivets on b2.
    color([0.25, 0.25, 0.25])
    for (a = [0, 90, 180, 270])
        rotate([0, 0, a]) translate([10, 0, 16.8]) part_b4();
}

module b_center_stack_preview() {
    axis_rot = [0, 0, 270];
    bronze = [0.45, 0.30, 0.18];
    steel = [0.25, 0.25, 0.25];

    color(bronze)
        translate([0, 0, 130]) rotate(axis_rot) part_b2();

    color(bronze) {
        for (sx = [-4, 4])
            translate([0, 0, 125.2]) rotate([180, 0, axis_rot[2] + 90]) translate([sx, 0, -3.95]) part_b8();
        translate([0, 0, 128.0]) rotate(axis_rot) part_b10();
    }

    color(bronze)
        translate([-5.9, 0, 120]) rotate(axis_rot) part_b9();

    color(bronze)
        translate([0, 0, 132.2]) rotate([180, 0, axis_rot[2] + 90]) translate([0, 0, 6.95]) part_b7();

    color(bronze)
        translate([0, 0, 117.5]) rotate(axis_rot) part_b3();
}

module b_simple_assembly() {
    b18_angle_deg = 12;
    b1_spoke_holes = [
        [10, 0],
        [0, 10],
        [-10, 0],
        [0, -10]
    ];
    b1_rim_holes = [
        [41.7, -41.7],
        [-44.5, -38.7],
        [-48.3, 33.8],
        [41.7, 41.7]
    ];
    b1_side_holes = [
        [sqrt(59 * 59 - 4.6 * 4.6), 4.6],
        [sqrt(59 * 59 - 19.8 * 19.8), 19.8],
        [-sqrt(59 * 59 - 4.6 * 4.6), -4.6],
        [-sqrt(59 * 59 - 19.8 * 19.8), -19.8]
    ];

    color([0.45, 0.30, 0.18]) rotate([180, 0, 0]) part_b1();

    color([0.45, 0.30, 0.18]) {
        translate([0, 0, 14.8])
            rotate([0, 0, b18_angle_deg])
                part_b18();

        for (p = b1_rim_holes)
            translate([p[0], p[1], 13.9])
                rotate([180, 0, 0])
                    part_b5();
    }

    color([0.28, 0.28, 0.28])
        for (p = b1_side_holes)
            translate([p[0], p[1], 8.6])
                rotate([180, 0, 0])
                    part_b17();

    color([0.28, 0.28, 0.28])
        for (p = b1_spoke_holes)
            translate([p[0], p[1], -1])
                part_b4();
}

module b_assembly() {
    // Main plate.
    color([0.45, 0.30, 0.18]) part_b1();

    // Superior/internal plate.
    color([0.45, 0.30, 0.18]) translate([0, 0, 22]) translate([62, 12, 0.8]) part_b18();

    // Plate posts (b17) and standoffs (b5).
    color([0.45, 0.30, 0.18]) {
        for (a = [35, 145, 215, 325])
            rotate([0, 0, a]) translate([55, 0, 2.0]) translate([0, 0, 14.9]) part_b5();
    }
    color([0.28, 0.28, 0.28]) {
        for (a = [0, 90, 180, 270])
            rotate([0, 0, a]) translate([62, 0, 2.0]) translate([0, 0, 7.35]) part_b17();
    }

    // Center drive cluster.
    translate([0, 0, 6]) b_drive_cluster();

    // Roller subsystem off-axis.
    translate([24, -22, 8]) rotate([0, 0, -25]) roller_subassembly();

    // Node clip piece mounted near rim.
    color([0.45, 0.30, 0.18]) translate([44, 12, 22]) translate([0, 0, 3.65]) part_b6();

    // b10 inner discs.
    color([0.45, 0.30, 0.18]) {
        translate([-16, 10, 3]) translate([0, 0, 1.0]) part_b10();
        translate([-16, 10, 5.3]) translate([0, 0, 1.0]) part_b10();
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

    // Top-left side profile uses the simpler plate/post assembly.
    translate([122, 228, 16]) rotate([90, 0, 0]) scale([0.90, 0.90, 0.90]) b_simple_assembly();

    // Bottom-left top view reuses the simpler plate/post assembly.
    translate([122, 88, 16]) rotate([0, 0, 0]) scale([0.90, 0.90, 0.90]) b_simple_assembly();

    // Bottom-right view starts from the simple assembly, with the center drive
    // stack parked nearby for orientation checks before fitting.
    translate([322, 120, 16]) rotate([90, 0, 180]) scale([0.90, 0.90, 0.90]) {
        rotate([0, 0, 180]) b_simple_assembly();
        translate([0, 0, -132]) b_center_stack_preview();
    }
}

module drw002_b_assembly() {
    rotate([90, 0, 180]) {
        rotate([0, 0, 180]) b_simple_assembly();
        translate([0, 0, -132]) b_center_stack_preview();
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet1();
}
