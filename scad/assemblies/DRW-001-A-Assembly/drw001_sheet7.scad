// DRW-001 Sheet 7 recreation (a1 gear assembly).
// SPDX-License-Identifier: MIT

use <./drw001_a1_subassembly.scad>
use <./drw001_a8_subassembly.scad>

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

    // Main assembly composition matching sheet style.
    // Right: a8 subassembly (disc + axle).
    translate([242, 52, 18]) rotate([90, 0, 92]) scale([1.25, 1.25, 1.25]) drw001_a8_subassembly();

    // Left: a1 subassembly.
    translate([112, 141, 18]) rotate([0, 90, 0]) scale([1.15, 1.15, 1.15]) drw001_a1_subassembly();

    // Coupling shaft between subassemblies.
    color([0.40, 0.30, 0.20]) translate([150, 139, 18]) rotate([0, 90, 0]) cylinder(d = 10, h = 70, center = false);
    color([0.40, 0.30, 0.20]) translate([197, 139, 18]) rotate([0, 90, 0]) cylinder(d = 12, h = 23, center = false);

    // Callouts and leaders.
    color("black") translate([144, 95, 0]) linear_extrude(height = th) label("a1 gear assembly", sz = 3.3);
    color("black") translate([58, 157, 0]) linear_extrude(height = th) label("a1 sub assembly", sz = 3.2);
    color("black") translate([294, 72, 0]) linear_extrude(height = th) label("a8 sub assembly", sz = 3.2);
    color("black") translate([56, 228, 0]) linear_extrude(height = th) label("Tight friction fit a6 to a8", sz = 3.2);

    color("black")
    linear_extrude(height = th) {
        line2d([106, 158], [118, 160], 0.24); // a1 subassembly leader
        line2d([281, 73], [262, 50], 0.24);   // a8 leader
        line2d([122, 228], [145, 228], 0.24); // friction text horizontal
        line2d([145, 228], [160, 142], 0.24); // friction text to interface
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet7();
}
