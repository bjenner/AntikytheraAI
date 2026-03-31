// DRW-001 Sheet 1 recreation (assembly overview).
// Uses reusable DRW-001 assembly modules.
// SPDX-License-Identifier: MIT

use <./drw001_a1_gear_assembly.scad>
use <./drw001_a8_subassembly.scad>

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

module drw001_sheet1() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (assembly)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 1 OF 7", sz = 2.9);

    // Three-view layout similar to source.
    // Top-left perspective.
    translate([68, 182, 18])
        scale([0.62, 0.62, 0.62])
            drw001_a1_gear_assembly();

    // Top-right face-on disc with center mechanism.
    translate([260, 178, 16])
        rotate([90, 0, 0])
            scale([0.72, 0.72, 0.72])
                drw001_a8_subassembly();

    // Bottom-left oblique.
    translate([108, 67, 18])
        rotate([35, 0, 20])
            scale([0.72, 0.72, 0.72])
                drw001_a1_gear_assembly();
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet1();
}
