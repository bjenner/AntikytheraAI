// DRW-002 Sheet 9 recreation (b11 to b16, plus b9/b10 library continuity).
// SPDX-License-Identifier: MIT

use <../parts/b9_pin.scad>
use <../parts/b10_disc.scad>
use <../parts/b11_carrier_block.scad>
use <../parts/b12_pin.scad>
use <../parts/b13_roller.scad>
use <../parts/b14_pin.scad>
use <../parts/b15_wire_link.scad>
use <../parts/b16_rivet.scad>
use <../parts/b17_standoff_pin.scad>

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

module b9_subassembly() {
    // Core block.
    color([0.40, 0.29, 0.19]) translate([0, 0, 0]) part_b11();

    // Two b12 guide pins on top.
    color([0.45, 0.34, 0.23]) {
        translate([5.2, 20.0, 11.2]) rotate([0, 0, 0]) part_b12();
        translate([10.8, 20.0, 11.2]) rotate([0, 0, 0]) part_b12();
    }

    // Lateral roller b13 riveted to b12 axis region.
    color([0.35, 0.25, 0.18]) translate([16, 12, 8.6]) rotate([0, 0, 0]) part_b13();

    // Fine pin and rivet near lower side.
    color([0.70, 0.70, 0.70]) translate([8.0, 6.0, 9.0]) rotate([90, 0, 0]) part_b14();
    color([0.25, 0.25, 0.25]) translate([12.0, 5.0, 2.2]) rotate([90, 0, 0]) part_b16();

    // Wire link.
    color([0.72, 0.72, 0.72]) translate([8.0, 8.0, 6.4]) rotate([0, 90, -20]) part_b15();

    // Reference rivet from b17 note (sheet 10 linkage callout).
    color([0.15, 0.15, 0.15]) translate([13.8, 4.8, 1.0]) rotate([0, 90, 0]) cylinder(d = 1.5, h = 2.0, center = false);
}

module drw002_sheet9() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (b11 to b16)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 9 OF 10", sz = 2.9);

    // Part previews across top row.
    color([0.45, 0.30, 0.18]) translate([54, 242, 16]) rotate([18, 0, -25]) scale([1.15, 1.15, 1.15]) part_b11();
    color([0.45, 0.30, 0.18]) translate([165, 246, 16]) rotate([0, 0, 0]) scale([1.0, 1.0, 1.0]) part_b12();
    color([0.35, 0.25, 0.18]) translate([224, 246, 16]) rotate([0, 0, 0]) scale([1.0, 1.0, 1.0]) part_b13();
    color([0.75, 0.75, 0.75]) translate([276, 246, 16]) rotate([0, 90, 0]) scale([1.0, 1.0, 1.0]) part_b14();
    color([0.75, 0.75, 0.75]) translate([334, 246, 16]) rotate([0, 90, 0]) scale([1.1, 1.1, 1.1]) part_b15();

    // b11 orthographic linework (left-center) from part projection.
    color([0.93, 0.93, 0.93])
    translate([64, 180, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([90, 0, 0]) part_b11();

    color("black")
    translate([64, 180, 0.01]) linear_extrude(height = th)
        outline2d(0.32) projection(cut = true) rotate([90, 0, 0]) part_b11();

    // b16 detail view (right-mid).
    color([0.25, 0.25, 0.25]) translate([336, 136, 16]) rotate([20, -10, 22]) part_b16();
    color("black") translate([324, 148, 0]) linear_extrude(height = th) label("b16", sz = 3.0, bold = true);

    // Bottom assembly views.
    translate([200, 40, 16]) rotate([22, 0, -28]) scale([1.2, 1.2, 1.2]) b9_subassembly();
    translate([285, 58, 16]) rotate([35, 0, -35]) scale([1.25, 1.25, 1.25]) b9_subassembly();

    color("black") translate([215, 36, 0]) linear_extrude(height = th) label("b9 sub assembly", sz = 3.2);

    color("black") translate([226, 111, 0]) linear_extrude(height = th) label("Rivet b13 to b12", sz = 2.9);
    color("black") translate([286, 66, 0]) linear_extrude(height = th) label("b16", sz = 2.9, bold = true);
    color("black") translate([272, 96, 0]) linear_extrude(height = th) label("b14", sz = 2.9, bold = true);
    color("black") translate([309, 68, 0]) linear_extrude(height = th) label("Rivet b17 with b16 to b12", sz = 2.8);

    // Leaders.
    color("black")
    linear_extrude(height = th) {
        line2d([74, 268], [90, 255], 0.24);      // b11
        line2d([176, 268], [167, 250], 0.24);    // b12
        line2d([232, 278], [224, 252], 0.24);    // b13
        line2d([286, 268], [276, 251], 0.24);    // b14
        line2d([338, 275], [334, 251], 0.24);    // b15
        line2d([248, 111], [223, 90], 0.24);     // rivet b13->b12 note
        line2d([281, 95], [293, 85], 0.24);      // b14 note
        line2d([318, 68], [307, 77], 0.24);      // b17+b16 note
    }

    // Library continuity previews for b9 and b10 (to complete b9..b16 set).
    color([0.30, 0.30, 0.30]) translate([26, 84, 16]) rotate([90, 0, 0]) part_b9();
    color([0.45, 0.30, 0.18]) translate([36, 84, 16]) rotate([75, 0, 20]) scale([0.85, 0.85, 0.85]) part_b10();
    color("black") translate([20, 70, 0]) linear_extrude(height = th) label("b9", sz = 2.8);
    color("black") translate([35, 70, 0]) linear_extrude(height = th) label("b10", sz = 2.8);
}
