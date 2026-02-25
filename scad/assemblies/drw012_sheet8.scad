// DRW-012 Sheet 8 recreation (Jupiter pointer parts jup13 to jup19).
// SPDX-License-Identifier: MIT

use <../parts/jup13_pointer_arm.scad>
use <../parts/jup14_orb_large.scad>
use <../parts/jup15_orb_rod_large.scad>
use <../parts/jup16_orb_small.scad>
use <../parts/jup17_orb_rod_small.scad>
use <../parts/jup18_pointer_ring_outer.scad>
use <../parts/jup19_pointer_ring_inner.scad>
use <../parts/cp5_spacer.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.3) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.35) {
    difference() {
        offset(r = w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module jupiter_pointer_assembly() {
    color([0.42, 0.30, 0.18]) part_jup13();
    color([0.28, 0.24, 0.22]) translate([0, 0, 1.0]) part_jup19();
    color([0.42, 0.30, 0.18]) translate([0, 0, 2.0]) part_jup18();
    color([0.42, 0.30, 0.18]) {
        translate([-51.5, 0, 1.0]) part_jup15();
        translate([51.5, 0, 1.0]) part_jup17();
    }
    color([0.82, 0.82, 0.84]) {
        translate([-51.5, 0, 16.0]) part_jup14();
        translate([51.5, 0, 16.0]) part_jup16();
    }
}

module drw012_sheet8() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Jupiter   (jup13 to jup19)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 8 OF 9", sz = 2.9);

    // Top row: jup14/16 and jup19.
    color([0.82, 0.82, 0.84]) translate([55, 246, 10]) scale([1.4, 1.4, 1.4]) part_jup14();
    color([0.82, 0.82, 0.84]) translate([140, 246, 10]) scale([1.4, 1.4, 1.4]) part_jup16();
    color([0.28, 0.24, 0.22]) translate([233, 232, 8]) rotate([68, 0, 20]) scale([1.25, 1.25, 1.25]) part_jup19();
    color("black") translate([32, 262, 0]) linear_extrude(height = th) label("jup14", sz = 2.9, bold = true);
    color("black") translate([117, 262, 0]) linear_extrude(height = th) label("jup16", sz = 2.9, bold = true);
    color("black") translate([216, 230, 0]) linear_extrude(height = th) label("jup19", sz = 2.9, bold = true);

    // Middle row: rods and pointer assembly.
    color([0.40, 0.30, 0.22]) translate([58, 170, 8]) rotate([90, 0, 0]) part_jup15();
    color([0.40, 0.30, 0.22]) translate([140, 170, 8]) rotate([90, 0, 0]) part_jup17();
    color("black") translate([31, 186, 0]) linear_extrude(height = th) label("jup15", sz = 2.9, bold = true);
    color("black") translate([117, 186, 0]) linear_extrude(height = th) label("jup17", sz = 2.9, bold = true);

    translate([335, 162, 0]) rotate([70, 0, 22]) scale([0.82, 0.82, 0.82]) jupiter_pointer_assembly();
    color("black") translate([311, 122, 0]) linear_extrude(height = th) label("Jupiter pointer assembly", sz = 2.9);
    color("black") translate([296, 186, 0]) linear_extrude(height = th) label("Friction rotating fit pointer sub assembly then", sz = 2.6);
    color("black") translate([300, 176, 0]) linear_extrude(height = th) label("rivet jup18 to jup19 with cp5 x 4", sz = 2.6);

    // Bottom row: jup13 and jup18.
    color([0.42, 0.30, 0.18]) translate([134, 90, 8]) rotate([70, 0, 20]) scale([0.95, 0.95, 0.95]) part_jup13();
    color([0.34, 0.27, 0.23]) translate([247, 89, 8]) rotate([68, 0, 22]) scale([1.2, 1.2, 1.2]) part_jup18();
    color("black") translate([123, 118, 0]) linear_extrude(height = th) label("jup13", sz = 2.9, bold = true);
    color("black") translate([226, 102, 0]) linear_extrude(height = th) label("jup18", sz = 2.9, bold = true);

    // 2D callout block (right-lower).
    color([0.93, 0.93, 0.93]) translate([342, 66, 0]) linear_extrude(height = th) projection(cut = true) part_jup18();
    color("black") translate([342, 66, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup18();

    // Key dims.
    color("black") {
        translate([31, 210, 0]) linear_extrude(height = th) label("\u23001.5", sz = 2.8);
        translate([56, 222, 0]) linear_extrude(height = th) label("\u23005", sz = 2.8);
        translate([114, 215, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);
        translate([136, 215, 0]) linear_extrude(height = th) label("\u23003", sz = 2.8);
        translate([62, 131, 0]) linear_extrude(height = th) label("Fitted 14.3", sz = 2.8);
        translate([144, 131, 0]) linear_extrude(height = th) label("Fitted 14.4", sz = 2.8);
        translate([82, 104, 0]) linear_extrude(height = th) label("51.5", sz = 2.8);
        translate([124, 104, 0]) linear_extrude(height = th) label("R14", sz = 2.8);
        translate([139, 104, 0]) linear_extrude(height = th) label("\u230021.5", sz = 2.8);
        translate([138, 94, 0]) linear_extrude(height = th) label("\u230019.5", sz = 2.8);
        translate([166, 105, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);
        translate([223, 210, 0]) linear_extrude(height = th) label("\u230021.5", sz = 2.8);
        translate([223, 200, 0]) linear_extrude(height = th) label("\u230019.5", sz = 2.8);
        translate([223, 190, 0]) linear_extrude(height = th) label("\u230015.5", sz = 2.8);
        translate([223, 180, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw012_sheet8();
}
