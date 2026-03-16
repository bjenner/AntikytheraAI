// DRW-002 Sheet 10 recreation (b17 to b18).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b17_standoff_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b18_link_plate.scad>

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

module drw002_sheet10() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (b17 to b18)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 10 OF 10", sz = 2.9);

    // Top engineering view for b18.
    color([0.90, 0.90, 0.90])
    translate([68, 190, 0])
        linear_extrude(height = th)
            b18_profile_2d();

    color("black")
    translate([68, 190, 0.01])
        linear_extrude(height = th)
            outline2d(0.33) b18_profile_2d();

    // Right-side thin side view of b18 thickness.
    color("black")
    translate([356, 192, 0])
        linear_extrude(height = th)
            outline2d(0.3) square([1.6, 52], center = false);

    // b17 detail projection at lower-right.
    color([0.92, 0.92, 0.92])
    translate([300, 74, 0])
        linear_extrude(height = th)
            projection(cut = true) translate([0, 0, 7.35]) part_b17();

    color("black")
    translate([300, 74, 0.01])
        linear_extrude(height = th)
            outline2d(0.32) projection(cut = true) translate([0, 0, 7.35]) part_b17();

    // Isometric previews matching source composition.
    color([0.45, 0.30, 0.18])
    translate([62, 48, 16])
        rotate([20, -8, 8])
            scale([1.9, 1.9, 1.9])
                translate([62, 12, 0.8])
                    part_b18();

    color([0.45, 0.30, 0.18])
    translate([298, 126, 16])
        rotate([26, -12, 35])
            scale([1.5, 1.5, 1.5])
                translate([0, 0, 1.5])
                    part_b17();

    // Detail symbol for b17 hole diameter callout zone.
    color("black")
    linear_extrude(height = th) {
        translate([340, 126]) outline2d(0.30) square([10, 10], center = true);
        translate([340, 126]) outline2d(0.30) circle(d = 6, $fn = 30);
        translate([348, 118]) text("\u23003.0", size = 3.2, halign = "left", valign = "center", font = "Liberation Sans");
    }

    // Labels.
    color("black") translate([156, 94, 0]) linear_extrude(height = th) label("b18", sz = 3.1, bold = true);
    color("black") translate([316, 148, 0]) linear_extrude(height = th) label("b17 x 4", sz = 3.1, bold = true);

    // Leaders.
    color("black")
    linear_extrude(height = th) {
        line2d([173, 94], [150, 79], 0.24);
        line2d([330, 147], [309, 132], 0.24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet10();
}
