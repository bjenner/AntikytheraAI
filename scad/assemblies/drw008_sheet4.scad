// DRW-008 Sheet 4 recreation (Date pointer sub-assembly, dat1 to dat6).
// SPDX-License-Identifier: MIT

use <../parts/dat1_pointer.scad>
use <../parts/dat2_pin.scad>
use <../parts/dat3_ball_tip.scad>
use <../parts/dat4_post.scad>
use <../parts/dat5_ball_tip_small.scad>
use <../parts/dat6_post_small.scad>

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

module pointer_subassembly_3d() {
    color([0.45, 0.30, 0.18]) part_dat1();

    // Left pointer: small post + small ball
    translate([-63.5, 0, 0.55]) {
        color([0.30, 0.22, 0.15]) part_dat6();
        color([0.13, 0.27, 0.90]) translate([0, 0, 17.4 + 0.9]) part_dat5();
    }

    // Right pointer: large post + large ball
    translate([63.5, 0, 0.55]) {
        color([0.30, 0.22, 0.15]) part_dat4();
        color([0.13, 0.27, 0.90]) translate([0, 0, 17.4 + 1.0]) part_dat3();
    }

    // dat2 pin shown at right post top as in drawing annotation.
    color([0.22, 0.22, 0.22])
    translate([63.5, 1.2, 17.8]) rotate([90, 15, 0]) part_dat2();
}

module drw008_sheet4() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Date      (dat1 to dat6)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 4 OF 5", sz = 2.9);

    // Top: dat1 engineering top + side style views.
    color([0.93, 0.93, 0.93]) translate([146, 243, 0]) linear_extrude(height = th) dat1_profile_2d();
    color("black") translate([146, 243, 0.01]) linear_extrude(height = th) outline2d(0.3) dat1_profile_2d();
    color("black") translate([66, 285, 0]) linear_extrude(height = th) label("dat1", sz = 3.2, bold = true);

    color([0.93, 0.93, 0.93])
    translate([146, 160, 0]) linear_extrude(height = th)
    projection(cut = true) rotate([90, 0, 0]) part_dat1();
    color("black")
    translate([146, 160, 0.01]) linear_extrude(height = th)
    outline2d(0.28) projection(cut = true) rotate([90, 0, 0]) part_dat1();

    // dat2..dat6 individual 3D previews.
    color([0.20, 0.20, 0.20]) translate([321, 241, 14]) rotate([75, 0, 45]) scale([1.5, 1.5, 1.5]) part_dat2();
    color([0.13, 0.27, 0.90]) translate([377, 253, 14]) scale([1.6, 1.6, 1.6]) part_dat3();
    color("black") translate([324, 276, 0]) linear_extrude(height = th) label("dat2", sz = 3.0, bold = true);
    color("black") translate([386, 276, 0]) linear_extrude(height = th) label("dat3", sz = 3.0, bold = true);

    color([0.20, 0.20, 0.20]) translate([190, 118, 14]) rotate([90, 0, 0]) scale([1.45, 1.45, 1.45]) part_dat4();
    color([0.13, 0.27, 0.90]) translate([255, 118, 14]) scale([1.55, 1.55, 1.55]) part_dat5();
    color([0.20, 0.20, 0.20]) translate([297, 118, 14]) rotate([90, 0, 0]) scale([1.45, 1.45, 1.45]) part_dat6();
    color("black") translate([189, 149, 0]) linear_extrude(height = th) label("dat4", sz = 3.0, bold = true);
    color("black") translate([255, 137, 0]) linear_extrude(height = th) label("dat5", sz = 3.0, bold = true);
    color("black") translate([297, 137, 0]) linear_extrude(height = th) label("dat6", sz = 3.0, bold = true);

    // Middle-left iso of dat1.
    color([0.45, 0.30, 0.18])
    translate([86, 122, 14]) rotate([70, 0, 24]) scale([1.32, 1.32, 1.32]) part_dat1();

    // Bottom assembly view + callouts.
    translate([137, 26, 14]) rotate([70, 0, 18]) scale([1.1, 1.1, 1.1]) pointer_subassembly_3d();
    color("black") translate([109, 22, 0]) linear_extrude(height = th) label("Date Pointer Sub Assembly", sz = 3.2, bold = false);

    color("black") {
        translate([6, 50, 0]) linear_extrude(height = th) label("Tight press fit dat5 to dat6", sz = 2.8);
        translate([16, 14, 0]) linear_extrude(height = th) label("Tight press fit dat1 to dat6", sz = 2.8);
        translate([111, 16, 0]) linear_extrude(height = th) label("Tight press fit dat1 to dat4", sz = 2.8);
        translate([137, 58, 0]) linear_extrude(height = th) label("Tight press fit dat3 to dat4", sz = 2.8);
        translate([136, 69, 0]) linear_extrude(height = th) label("Tight press fit dat2 to dat3", sz = 2.8);
    }
}
