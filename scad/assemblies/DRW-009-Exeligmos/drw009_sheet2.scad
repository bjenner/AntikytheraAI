// DRW-009 Sheet 2 recreation (Exeligmos parts list assembly view).
// Uses existing modeled parts; plate geometry is drawn in-sheet.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-009-Exeligmos/exe1_rivet_pin.scad>
use <../../parts/DRW-009-Exeligmos/h1_gear.scad>
use <../../parts/DRW-009-Exeligmos/h2_pinion.scad>
use <../../parts/DRW-009-Exeligmos/h3_hub.scad>
use <../../parts/DRW-009-Exeligmos/i1_gear.scad>
use <../../parts/DRW-009-Exeligmos/i2_hub.scad>
use <../../parts/DRW-005-Common-Parts/cp1_pointer_small.scad>

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

module balloon(id, p = [0, 0], r = 4.8) {
    color("black")
    linear_extrude(height = 0.12) {
        outline2d(0.30) translate(p) circle(r = r, $fn = 40);
        translate(p) text(id, size = 2.8, halign = "center", valign = "center", font = "Liberation Sans");
    }
}

module ip_plate_long(len = 360, w0 = 8, t = 2.0) {
    linear_extrude(height = t)
    polygon([
        [-len / 2, 0],
        [-len / 2 + 25, w0],
        [len / 2 - 25, w0],
        [len / 2, 0],
        [len / 2 - 25, -w0],
        [-len / 2 + 25, -w0]
    ]);
}

module drw009_sheet2() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Exeligmos   (parts list)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 2 OF 6", sz = 2.9);

    // Parts list table (simplified).
    color("black")
    linear_extrude(height = th) {
        outline2d(0.35) translate([300, 228]) square([108, 66], center = false);
        line2d([300, 284], [408, 284], 0.24);
        line2d([300, 274], [408, 274], 0.24);
        line2d([300, 264], [408, 264], 0.24);
        line2d([300, 254], [408, 254], 0.24);
    }
    color("black") {
        translate([305, 288, 0]) linear_extrude(height = th) label("PARTS LIST", sz = 3.6, bold = true);
        translate([305, 278, 0]) linear_extrude(height = th) label("exe1, h1, h2, h3, i1, i2, cp1", sz = 2.6);
        translate([305, 268, 0]) linear_extrude(height = th) label("7 parts to manufacture", sz = 2.6);
        translate([305, 258, 0]) linear_extrude(height = th) label("ip internal mounting plate", sz = 2.6);
    }

    // Long internal mounting plate.
    color([0.45, 0.30, 0.18])
    translate([182, 96, 9]) rotate([0, 0, -23]) scale([1.05, 1.05, 1.0]) ip_plate_long();

    // Exploded mini-cluster around center-right.
    base = [255, 148, 14];

    // lower line parts
    color([0.44, 0.30, 0.18]) translate(base + [26, -26, 0]) rotate([90, 0, 0]) scale([1.2, 1.2, 1.2]) part_h1();
    color([0.48, 0.31, 0.18]) translate(base + [15, -10, 0]) rotate([90, 0, 0]) scale([1.2, 1.2, 1.2]) part_h2();
    color([0.36, 0.28, 0.22]) translate(base + [10, -6, 1]) rotate([90, 0, 0]) scale([1.2, 1.2, 1.2]) part_h3();

    color([0.44, 0.30, 0.18]) translate(base + [-6, -4, 0]) rotate([90, 0, 0]) scale([1.1, 1.1, 1.1]) part_i1();
    color([0.36, 0.28, 0.22]) translate(base + [-12, -8, 1]) rotate([90, 0, 0]) scale([1.1, 1.1, 1.1]) part_i2();

    color([0.36, 0.27, 0.20]) translate(base + [0, 24, 12]) rotate([60, 0, -12]) scale([1.8, 1.8, 1.8]) part_cp1();
    color([0.25, 0.25, 0.25]) translate(base + [14, 27, 12]) rotate([20, 65, 20]) scale([1.6, 1.6, 1.6]) part_exe1();

    // Balloons and leaders.
    balloon("cp1", [238, 192]);
    balloon("exe1", [252, 193]);
    balloon("i1", [233, 159]);
    balloon("i2", [233, 144]);
    balloon("h3", [319, 154]);
    balloon("h2", [319, 137]);
    balloon("h1", [319, 120]);

    color("black")
    linear_extrude(height = th) {
        line2d([238, 188], [251, 165], 0.22);
        line2d([252, 189], [268, 175], 0.22);
        line2d([233, 155], [246, 150], 0.22);
        line2d([233, 140], [241, 143], 0.22);
        line2d([319, 150], [281, 147], 0.22);
        line2d([319, 133], [276, 139], 0.22);
        line2d([319, 116], [271, 125], 0.22);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw009_sheet2();
}
