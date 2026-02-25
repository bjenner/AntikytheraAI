// DRW-013 Sheet 5 recreation (Mars, mar3, mar4, mar8, mar9, mar10).
// SPDX-License-Identifier: MIT

use <../parts/mar3_gear.scad>
use <../parts/mar4_gear.scad>
use <../parts/mar8_rivet_pin.scad>
use <../parts/mar9_hub.scad>
use <../parts/mar10_disc.scad>

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

module mar34_subassembly() {
    color([0.44, 0.32, 0.20]) part_mar4();
    color([0.42, 0.30, 0.18]) translate([0, 0, 1.0]) part_mar3();
    color([0.44, 0.32, 0.20]) translate([13.5, -3.0, 1.0]) part_mar8();
}

module mar34_pointer_assembly() {
    color([0.42, 0.30, 0.18]) part_mar3();
    color([0.44, 0.32, 0.20]) translate([0, 0, 1.6]) part_mar4();
    color([0.32, 0.27, 0.24]) translate([0, 0, 2.6]) part_mar10();
    color([0.33, 0.27, 0.23]) translate([0, 0, 4.6]) part_mar9();
}

module drw013_sheet5() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Mars   (mar3, mar4, mar8 to mar10)", sz = 2.7);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 5 OF 7", sz = 2.9);

    // Top row previews.
    color([0.42, 0.30, 0.18]) translate([62, 230, 8]) rotate([68, 0, 25]) scale([1.45, 1.45, 1.45]) part_mar3();
    color([0.44, 0.32, 0.20]) translate([141, 230, 8]) rotate([68, 0, 24]) scale([1.45, 1.45, 1.45]) part_mar4();
    color([0.44, 0.32, 0.20]) translate([197, 236, 8]) rotate([90, 0, 25]) part_mar8();
    color([0.32, 0.27, 0.24]) translate([333, 215, 8]) rotate([68, 0, 20]) scale([1.7, 1.7, 1.7]) part_mar10();
    color("black") {
        translate([50, 246, 0]) linear_extrude(height = th) label("mar3", sz = 3.0, bold = true);
        translate([131, 246, 0]) linear_extrude(height = th) label("mar4", sz = 3.0, bold = true);
        translate([195, 246, 0]) linear_extrude(height = th) label("mar8", sz = 3.0, bold = true);
        translate([336, 246, 0]) linear_extrude(height = th) label("mar10", sz = 3.0, bold = true);
    }

    // Top-right subassembly and note.
    translate([258, 190, 0]) rotate([72, 0, 20]) scale([1.2, 1.2, 1.2]) mar34_subassembly();
    color("black") {
        translate([248, 204, 0]) linear_extrude(height = th) label("Rivet mar8 to mar4", sz = 2.6);
        translate([292, 237, 0]) linear_extrude(height = th) label("Note: Align mar9 slot with to mar10 center before riveting", sz = 2.2);
        translate([312, 227, 0]) linear_extrude(height = th) label("Friction press fit mar9 to mar10", sz = 2.4);
        translate([243, 150, 0]) linear_extrude(height = th) label("mar3-mar4 assembly", sz = 2.8);
    }

    // 2D orthographic views.
    color([0.93, 0.93, 0.93]) translate([49, 95, 0]) linear_extrude(height = th) projection(cut = true) part_mar3();
    color("black") translate([49, 95, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar3();

    color([0.93, 0.93, 0.93]) translate([132, 95, 0]) linear_extrude(height = th) projection(cut = true) part_mar4();
    color("black") translate([132, 95, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar4();

    color([0.93, 0.93, 0.93]) translate([140, 55, 0]) linear_extrude(height = th) projection(cut = true) part_mar10();
    color("black") translate([140, 55, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_mar10();

    color([0.33, 0.27, 0.23]) translate([89, 49, 8]) rotate([70, 0, 20]) part_mar9();
    color("black") translate([92, 66, 0]) linear_extrude(height = th) label("mar9", sz = 3.0, bold = true);

    // Main assembly view and section label.
    translate([339, 105, 0]) rotate([72, 0, 25]) scale([1.75, 1.75, 1.75]) mar34_pointer_assembly();
    color("black") {
        translate([265, 60, 0]) linear_extrude(height = th) label("mar3-mar4 assembly", sz = 3.0);
        translate([332, 64, 0]) linear_extrude(height = th) label("SECTION K-K", sz = 5.2, bold = true);
        translate([352, 53, 0]) linear_extrude(height = th) label("SCALE 2 : 1", sz = 3.7, bold = true);
        linear_extrude(height = th) {
            line2d([292, 125], [374, 80], 0.4);
            label("K", sz = 4.0, bold = true);
        }
    }

    // Key dimensions.
    color("black") {
        translate([80, 222, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
        translate([52, 125, 0]) linear_extrude(height = th) label("R20.33", sz = 2.8);
        translate([52, 116, 0]) linear_extrude(height = th) label("R19.08", sz = 2.8);
        translate([79, 137, 0]) linear_extrude(height = th) label("d4.5", sz = 2.8);
        translate([24, 173, 0]) linear_extrude(height = th) label("d4.5", sz = 2.8);

        translate([157, 125, 0]) linear_extrude(height = th) label("R19.58", sz = 2.8);
        translate([157, 116, 0]) linear_extrude(height = th) label("R18.50", sz = 2.8);
        translate([192, 124, 0]) linear_extrude(height = th) label("d17.5", sz = 2.8);
        translate([191, 83, 0]) linear_extrude(height = th) label("R13", sz = 2.8);
        translate([206, 83, 0]) linear_extrude(height = th) label("R17", sz = 2.8);

        translate([193, 224, 0]) linear_extrude(height = th) label("2.7", sz = 2.8);
        translate([188, 208, 0]) linear_extrude(height = th) label("d1.5", sz = 2.8);

        translate([102, 40, 0]) linear_extrude(height = th) label("R2.0", sz = 2.8);
        translate([121, 40, 0]) linear_extrude(height = th) label("R1.5", sz = 2.8);
        translate([132, 49, 0]) linear_extrude(height = th) label("d3.0", sz = 2.8);

        translate([143, 73, 0]) linear_extrude(height = th) label("d22", sz = 2.8);
        translate([166, 67, 0]) linear_extrude(height = th) label("d17.4", sz = 2.8);
        translate([149, 62, 0]) linear_extrude(height = th) label("d3.0", sz = 2.8);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw013_sheet5();
}
