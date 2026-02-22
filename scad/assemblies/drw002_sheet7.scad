// DRW-002 Sheet 7 recreation (b5 to b6).
// SPDX-License-Identifier: MIT

use <../parts/b5_post.scad>
use <../parts/b6_clip.scad>

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

module drw002_sheet7() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (b5 to b6)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 7 OF 10", sz = 2.9);

    // Isometric previews.
    color([0.45, 0.30, 0.18])
    translate([112, 190, 16])
        rotate([20, 0, -22])
            scale([2.1, 2.1, 2.1])
                part_b5();

    color([0.45, 0.30, 0.18])
    translate([318, 188, 16])
        rotate([22, 0, -25])
            scale([2.4, 2.4, 2.4])
                part_b6();

    // b5 orthographic details (left-center / bottom-left).
    color([0.93, 0.93, 0.93])
    translate([78, 96, 0]) linear_extrude(height = th) projection(cut = true) part_b5();
    color("black")
    translate([78, 96, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = true) part_b5();

    color([0.93, 0.93, 0.93])
    translate([80, 38, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_b5();
    color("black")
    translate([80, 38, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = true) rotate([90, 0, 0]) part_b5();

    // b6 orthographic details (right-center).
    color([0.93, 0.93, 0.93])
    translate([300, 98, 0]) linear_extrude(height = th) projection(cut = true) part_b6();
    color("black")
    translate([300, 98, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = true) part_b6();

    color([0.93, 0.93, 0.93])
    translate([314, 90, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_b6();
    color("black")
    translate([314, 90, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = true) rotate([90, 0, 0]) part_b6();

    // Notes and labels.
    color("black") translate([122, 245, 0]) linear_extrude(height = th) label("b5 x 4", sz = 3.1, bold = true);
    color("black") translate([324, 198, 0]) linear_extrude(height = th) label("b6", sz = 3.1, bold = true);
    color("black") translate([256, 114, 0]) linear_extrude(height = th) label("Fitted (not 2.5 for Venus pin and slot parallel to b1)?", sz = 2.6);

    // Leaders.
    color("black")
    linear_extrude(height = th) {
        line2d([137, 244], [121, 216], 0.24);
        line2d([331, 197], [317, 194], 0.24);
    }
}
