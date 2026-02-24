// DRW-001 Sheet 6 recreation (a7 to a10 focus).
// SPDX-License-Identifier: MIT

use <../parts/a7_block.scad>
use <../parts/a8_rivet_pin.scad>
use <../parts/a9_axle.scad>
use <../parts/a10_disc.scad>

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

module label(s, sz = 3.1, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module a8_subassembly() {
    // Disc + axle + two rivet pins (simplified placement).
    color([0.45, 0.30, 0.18]) part_a10();
    color([0.52, 0.43, 0.34]) translate([0, 0, 2]) part_a9();
    color([0.25, 0.25, 0.25]) translate([6, 0, 3.5]) rotate([90, 0, 0]) part_a8();
    color([0.25, 0.25, 0.25]) translate([-6, 0, 3.5]) rotate([90, 0, 0]) part_a8();
}

module drw001_sheet6() {
    w = 420;
    h = 297;
    b = 8;
    th = 0.12;

    // Border.
    color("black")
    linear_extrude(height = th)
    difference() {
        square([w, h], center = false);
        translate([b, b]) square([w - 2 * b, h - 2 * b], center = false);
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (a7 to a10)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 6 OF 7", sz = 2.9);

    // Orthographic outlines from parts.
    color([0.90, 0.90, 0.90]) translate([80, 86, 0]) linear_extrude(height = th) projection(cut = true) part_a7();
    color("black") translate([80, 86, 0.01]) linear_extrude(height = th) outline2d(0.35) projection(cut = true) part_a7();
    color("black") translate([50, 106, 0]) linear_extrude(height = th) label("a7", sz = 3.2, bold = true);

    color([0.90, 0.90, 0.90]) translate([126, 246, 0]) linear_extrude(height = th) projection(cut = true) part_a8();
    color("black") translate([126, 246, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a8();
    color("black") translate([141, 250, 0]) linear_extrude(height = th) label("a8 x 2", sz = 3.0, bold = true);

    color([0.90, 0.90, 0.90]) translate([204, 235, 0]) linear_extrude(height = th) projection(cut = true) part_a9();
    color("black") translate([204, 235, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a9();
    color("black") translate([218, 232, 0]) linear_extrude(height = th) label("a9", sz = 3.0, bold = true);

    color([0.90, 0.90, 0.90]) translate([335, 124, 0]) linear_extrude(height = th) projection(cut = true) part_a10();
    color("black") translate([335, 124, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a10();
    color("black") translate([266, 104, 0]) linear_extrude(height = th) label("a10", sz = 3.0, bold = true);

    // Big isometric part previews.
    color([0.45, 0.30, 0.18]) translate([83, 76, 16]) rotate([0, 0, 0]) scale([1, 1, 1]) part_a7();
    color([0.52, 0.43, 0.34]) translate([232, 210, 16]) rotate([0, 0, 0]) scale([1, 1, 1]) part_a9();
    color([0.45, 0.30, 0.18]) translate([235, 50, 18]) rotate([68, 0, 12]) scale([0.45, 0.45, 0.45]) part_a10();

    // a8 subassembly area.
    translate([142, 50, 18]) rotate([90, 0, 35]) scale([0.75, 0.75, 0.75]) a8_subassembly();
    color("black") translate([154, 20, 0]) linear_extrude(height = th) label("a8 sub assembly", sz = 3.2);

    // Simple callout leaders to match sheet feel.
    color("black") linear_extrude(height = th) {
        line2d([92, 110], [112, 120], 0.24);   // a7 leader
        line2d([206, 218], [186, 126], 0.24);  // a9 leader
        line2d([258, 108], [247, 88], 0.24);   // a10 leader
        line2d([180, 105], [170, 74], 0.24);   // subassembly leader
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet6();
}
