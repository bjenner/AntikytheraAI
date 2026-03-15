// DRW-001 Sheet 7 recreation (a1 gear assembly).
// SPDX-License-Identifier: MIT

use <./drw001_a1_subassembly.scad>
use <./drw001_a8_subassembly.scad>
use <./drw001_a1_gear_assembly.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.3) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.4) {
    difference() {
        offset(r = w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module drw001_sheet7() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (a1 gear assembly)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 7 OF 7", sz = 2.9);

    // Main sheet is a single side-view assembly composition.
    translate([246, 144, 18])
        rotate([0, 180, 0])
            scale([1.32, 1.32, 1.32])
                drw001_a1_gear_assembly(a6_roll_deg = 360);

    // Callouts and leaders closely following the source page.
    color("black") translate([145, 94, 0]) linear_extrude(height = th) label("a1 gear assembly", sz = 3.3);
    color("black") translate([60, 160, 0]) linear_extrude(height = th) label("a1 sub assembly", sz = 3.1);
    color("black") translate([291, 71, 0]) linear_extrude(height = th) label("a8 sub assembly", sz = 3.1);
    color("black") translate([42, 232, 0]) linear_extrude(height = th) label("Tight friction fit a6 to a8", sz = 3.1);

    color("black")
    linear_extrude(height = th) {
        line2d([99, 161], [116, 165], 0.24);
        line2d([286, 72], [262, 55], 0.24);
        line2d([115, 232], [132, 232], 0.24);
        line2d([132, 232], [148, 160], 0.24);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet7();
}
