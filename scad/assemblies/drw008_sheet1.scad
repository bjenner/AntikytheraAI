// DRW-008 Sheet 1 — Date (assembly overview).
// Source: Date_page1.png
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

module line2d(a = [0, 0], b = [10, 0], w = 0.3) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.38) {
    difference() {
        offset(r =  w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center",
         font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

// ---- Date pointer sub-assembly ----
// dat1 arm with dat3+dat2 on one end, dat5+dat6 on the other.
module date_pointer_subassembly() {
    bronze = [0.50, 0.32, 0.14];
    blue   = [0.18, 0.36, 0.72];

    // dat1 pointer arm.
    color(bronze) part_dat1();

    // dat4 large post (pressed into dat1 hole, +Y arm end).
    color(bronze) translate([63.5, 0, 1.0]) rotate([0, 0, 0]) part_dat4();
    // dat3 ball on dat4.
    color(blue)   translate([63.5, 0, 1.0 + 17.4]) part_dat3();

    // dat6 small post (-Y arm end).
    color(bronze) translate([-63.5, 0, 1.0]) part_dat6();
    // dat5 small ball on dat6.
    color(blue)   translate([-63.5, 0, 1.0 + 17.4]) part_dat5();

    // dat2 pin at hub.
    color(bronze) translate([0, 0, 1.0]) part_dat2();
}

// ---- Assembled friction ring pair with rivets ----
module date_ring_assembly() {
    bronze = [0.50, 0.32, 0.14];
    // dat8 inner (bottom).
    color(bronze) part_dat8();
    // dat7 outer (top, sits on dat8).
    color([0.42, 0.27, 0.12]) translate([0, 0, 1.45]) part_dat7();
    // cp3 rivets × 4.
    for (a = [0, 90, 180, 270])
        color([0.35, 0.28, 0.20])
        rotate([0, 0, a]) translate([17.0 / 2, 0, -0.5]) part_cp3();
}

// ---- Full assembled date dial ----
module date_assembly() {
    bronze = [0.50, 0.32, 0.14];
    dk     = [0.30, 0.19, 0.08];

    // dat9 base plate.
    color(bronze) part_dat9();

    // dat10 spoked wheel on top of base plate.
    color(dk) translate([0, 0, 2.5]) part_dat10();

    // Friction ring assembly centred on dat10 hub.
    translate([0, 0, 4.8]) date_ring_assembly();

    // Pointer arm floating above ring assembly.
    color(bronze) translate([0, 0, 7.5]) date_pointer_subassembly();
}

module drw008_sheet1() {
    W = 420; H = 297; B = 8; th = 0.12;

    // Border.
    color("black") linear_extrude(height = th)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W-2*B, H-2*B], center = false);
    }

    // Title block.
    color("black") linear_extrude(height = th) {
        outline2d(0.4) translate([285, 8]) square([127, 34], center = false);
        line2d([285, 20], [412, 20], 0.28);
        line2d([285, 30], [412, 30], 0.28);
        line2d([325, 8],  [325, 42], 0.28);
        line2d([376, 8],  [376, 42], 0.28);
    }
    color("black") translate([289, 37, 0]) linear_extrude(height = th)
        label("PROJECT   Antikithera Mechanism", sz = 3.1, bold = true);
    color("black") translate([289, 25, 0]) linear_extrude(height = th)
        label("DWG NO   Date      (assembly)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 1 OF 5", sz = 2.9);

    // Assembly view: dat9 base plate with dat10 + rings + pointer on top.
    // Centred and scaled to fit the sheet.
    translate([175, 160, 0]) scale([0.85, 0.85, 0.85])
        date_assembly();

    // Scale label.
    color("black") translate([B + 2, B + 2, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 3.5, bold = true);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw008_sheet1();
}
