// DRW-012 Sheet 6 recreation (Jupiter: jup3, jup10, jup11).
// SPDX-License-Identifier: MIT

use <../parts/jup3_gear.scad>
use <../parts/jup10_hub.scad>
use <../parts/jup11_sleeve.scad>

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

module jup3_jup4_axle_subassembly() {
    color([0.42, 0.30, 0.18]) part_jup3();
    color([0.34, 0.30, 0.27]) translate([0, 0, 1.6]) part_jup10();
    color([0.34, 0.30, 0.27]) translate([0, 0, 6.7]) part_jup11(outer_d = 13.0, inner_d = 4.0, height = 2.5, lip_h = 1.1, lip_d = 9.9);
}

module drw012_sheet6() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Jupiter   (jup3, jup10 to jup11)", sz = 2.9);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 6 OF 9", sz = 2.9);

    // Top row previews.
    color([0.42, 0.30, 0.18]) translate([60, 210, 9]) rotate([68, 0, 25]) scale([1.9, 1.9, 1.9]) part_jup3();
    color([0.34, 0.30, 0.27]) translate([120, 223, 9]) rotate([68, 0, 22]) scale([1.6, 1.6, 1.6]) part_jup10();
    color([0.34, 0.30, 0.27]) translate([370, 223, 9]) rotate([68, 0, 22]) scale([1.6, 1.6, 1.6])
        part_jup11(outer_d = 13.0, inner_d = 4.0, height = 2.5, lip_h = 1.1, lip_d = 9.9);
    color("black") translate([80, 247, 0]) linear_extrude(height = th) label("jup3", sz = 3.0, bold = true);
    color("black") translate([126, 257, 0]) linear_extrude(height = th) label("jup10", sz = 3.0, bold = true);
    color("black") translate([372, 257, 0]) linear_extrude(height = th) label("jup11", sz = 3.0, bold = true);

    // Left-center 2D gear views.
    color([0.93, 0.93, 0.93]) translate([57, 87, 0]) linear_extrude(height = th) projection(cut = true) part_jup3();
    color("black") translate([57, 87, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup3();

    color([0.93, 0.93, 0.93]) translate([29, 114, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_jup3();
    color("black") translate([29, 114, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup3();

    // Right side section and assembly.
    color([0.33, 0.29, 0.25]) translate([326, 138, 0]) rotate([70, 0, 22]) scale([1.5, 1.5, 1.5]) jup3_jup4_axle_subassembly();
    color("black") translate([306, 166, 0]) linear_extrude(height = th) label("C", sz = 8.0, bold = true);
    color("black") translate([342, 133, 0]) linear_extrude(height = th) label("C", sz = 8.0, bold = true);
    color("black") translate([333, 90, 0]) linear_extrude(height = th) label("Press fit jup10 to jup11", sz = 2.8);
    color("black") translate([311, 50, 0]) linear_extrude(height = th) label("jup3-jup4 axle sub assembly", sz = 2.8);

    color([0.93, 0.93, 0.93]) translate([250, 86, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([90, 0, 0]) jup3_jup4_axle_subassembly();
    color("black") translate([250, 86, 0.01]) linear_extrude(height = th)
        outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) jup3_jup4_axle_subassembly();
    color("black") translate([238, 58, 0]) linear_extrude(height = th) label("SECTION C-C", sz = 4.5, bold = true);
    color("black") translate([248, 48, 0]) linear_extrude(height = th) label("SCALE 4 : 1", sz = 3.5, bold = true);

    // Key dimensions.
    color("black") {
        translate([40, 101, 0]) linear_extrude(height = th) label("R12.53", sz = 2.8);
        translate([40, 91, 0]) linear_extrude(height = th) label("R11.28", sz = 2.8);
        translate([97, 96, 0]) linear_extrude(height = th) label("\u23006.5", sz = 2.8);
        translate([131, 78, 0]) linear_extrude(height = th) label("6.55", sz = 2.8);
        translate([132, 64, 0]) linear_extrude(height = th) label("3.3", sz = 2.8);
        translate([96, 58, 0]) linear_extrude(height = th) label("R.8", sz = 2.8);
        translate([29, 135, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);

        translate([176, 236, 0]) linear_extrude(height = th) label("\u23006.4", sz = 2.8);
        translate([154, 218, 0]) linear_extrude(height = th) label("\u23004.0", sz = 2.8);
        translate([176, 146, 0]) linear_extrude(height = th) label("\u23004.1", sz = 2.8);
        translate([278, 146, 0]) linear_extrude(height = th) label("-0.05mm friction press fit clearance", sz = 2.4);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw012_sheet6();
}
