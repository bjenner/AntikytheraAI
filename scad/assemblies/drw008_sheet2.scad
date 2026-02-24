// DRW-008 Sheet 2 recreation (Date parts list / exploded sub-assembly).
// Uses existing part files only.
// SPDX-License-Identifier: MIT

use <../parts/dat1_pointer.scad>
use <../parts/dat2_pin.scad>
use <../parts/dat3_ball_tip.scad>
use <../parts/dat4_post.scad>
use <../parts/dat5_ball_tip_small.scad>
use <../parts/dat6_post_small.scad>
use <../parts/dat7_ring.scad>
use <../parts/dat8_ring.scad>
use <../parts/dat9_base_plate.scad>
use <../parts/dat10_spoked_wheel.scad>
use <../parts/cp3_rivet.scad>
use <../parts/cp6_bush.scad>
use <../parts/cp7_bush.scad>

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

module balloon(txt, p = [0, 0], r = 4.8) {
    color("black")
    linear_extrude(height = 0.12) {
        outline2d(0.28) translate(p) circle(r = r, $fn = 40);
        translate([p[0], p[1] - 0.1]) text(txt, size = 2.6, halign = "center", valign = "center", font = "Liberation Sans");
    }
}

module date_pointer_sub() {
    color([0.44, 0.30, 0.18]) part_dat1();
    color([0.38, 0.25, 0.15]) translate([0, 0, 0.25]) part_dat7();
    color([0.36, 0.24, 0.14]) translate([0, 0, 2.30]) part_dat8();

    translate([-63.5, 0, 0.8]) {
        color([0.20, 0.20, 0.20]) part_dat6();
        color([0.11, 0.25, 0.90]) translate([0, 0, 18.0]) part_dat5();
    }

    translate([63.5, 0, 0.8]) {
        color([0.20, 0.20, 0.20]) part_dat4();
        color([0.11, 0.25, 0.90]) translate([0, 0, 18.0]) part_dat3();
        color([0.16, 0.16, 0.16]) translate([0, 1.0, 17.8]) rotate([90, 15, 0]) part_dat2();
    }
}

module drw008_sheet2() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Date      (parts list)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 2 OF 5", sz = 2.9);

    // Simplified parts table block.
    color("black")
    linear_extrude(height = th) {
        outline2d(0.35) translate([277, 207]) square([133, 84], center = false);
        line2d([277, 281], [410, 281], 0.25);
    }
    color("black") {
        translate([285, 286, 0]) linear_extrude(height = th) label("PARTS LIST", sz = 4.0, bold = true);
        translate([282, 276, 0]) linear_extrude(height = th) label("dat1..dat8, cp3, cp6, cp7", sz = 2.8);
        translate([282, 268, 0]) linear_extrude(height = th) label("Total parts to manufacture: 14", sz = 2.8);
    }

    // Main exploded stack similar to source composition.
    translate([152, 98, 10]) rotate([72, 0, -12]) scale([0.95, 0.95, 0.95]) {
        color([0.43, 0.29, 0.18]) part_dat9();
        color([0.44, 0.30, 0.18]) translate([0, 0, -28]) part_dat9();
        color([0.40, 0.27, 0.16]) translate([0, 0, -56]) scale([0.78, 0.78, 0.78]) part_dat10();

        translate([0, 0, 18]) date_pointer_sub();

        // cp6 / cp7 bush parts in exploded relation
        color([0.44, 0.30, 0.18]) translate([20, 9, 22]) part_cp6();
        color([0.44, 0.30, 0.18]) translate([28, 12, 24]) part_cp7();

        // cp3 rivets
        color([0.18, 0.18, 0.18]) {
            translate([-15, 8, 20]) part_cp3();
            translate([-10, 8, 20]) part_cp3();
            translate([-5, 8, 20]) part_cp3();
            translate([0, 8, 20]) part_cp3();
        }
    }

    // Callout balloons and leaders (approximate to source).
    balloon("dat1", [74, 235]);
    balloon("dat2", [89, 235]);
    balloon("dat3", [104, 235]);
    balloon("dat4", [119, 235]);
    balloon("dat5", [132, 235]);
    balloon("dat6", [145, 235]);
    balloon("dat7", [161, 235]);
    balloon("dat8", [176, 235]);
    balloon("cp3", [218, 228]);
    balloon("cp6", [244, 227]);
    balloon("cp7", [258, 226]);

    color("black")
    linear_extrude(height = th) {
        line2d([74, 231], [110, 150], 0.22);
        line2d([89, 231], [118, 165], 0.22);
        line2d([104, 231], [125, 176], 0.22);
        line2d([119, 231], [132, 182], 0.22);
        line2d([132, 231], [138, 185], 0.22);
        line2d([145, 231], [145, 188], 0.22);
        line2d([161, 231], [153, 187], 0.22);
        line2d([176, 231], [161, 185], 0.22);
        line2d([218, 224], [207, 178], 0.22);
        line2d([244, 223], [223, 180], 0.22);
        line2d([258, 222], [233, 185], 0.22);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw008_sheet2();
}
