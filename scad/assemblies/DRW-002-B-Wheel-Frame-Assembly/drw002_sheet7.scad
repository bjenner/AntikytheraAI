// DRW-002 Sheet 7 recreation (b5 to b6).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b5_post.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b6_clip.scad>

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

module dim_h(x0, x1, y, txt = "") {
    line2d([x0, y], [x1, y], 0.24);
    translate([x0, y]) rotate([0, 0, 180]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    translate([x1, y]) polygon([[0, 0], [-1.2, 0.42], [-1.2, -0.42]]);
    if (txt != "") translate([(x0 + x1) / 2, y + 1.6]) text(txt, size = 2.6, halign = "center");
}

module dim_v(y0, y1, x, txt = "") {
    line2d([x, y0], [x, y1], 0.24);
    translate([x, y0]) rotate([0, 0, -90]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    translate([x, y1]) rotate([0, 0, 90]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    if (txt != "") translate([x + 1.8, (y0 + y1) / 2]) rotate([0, 0, 90]) text(txt, size = 2.6, halign = "center");
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

    // Hero renders.
    color([0.45, 0.30, 0.18])
        translate([115, 196, 16])
            rotate([18, 0, -18])
                scale([2.2, 2.2, 2.2])
                    translate([0, 0, 14.9])
                        part_b5();

    color([0.45, 0.30, 0.18])
        translate([323, 197, 16])
            rotate([20, 0, -22])
                scale([2.2, 2.2, 2.2])
                    translate([0, 0, 3.65])
                        part_b6();

    // b5 orthographic/details cluster.
    color([0.95, 0.95, 0.95])
        translate([115, 124, 0])
            linear_extrude(height = th)
                projection(cut = false)
                    rotate([90, 0, 0])
                        translate([0, 0, 14.9])
                            part_b5();
    color("black")
        translate([115, 124, 0.01])
            linear_extrude(height = th)
                outline2d(0.28)
                    projection(cut = false)
                        rotate([90, 0, 0])
                            translate([0, 0, 14.9])
                                part_b5();

    color([0.95, 0.95, 0.95])
        translate([116, 50, 0])
            linear_extrude(height = th)
                projection(cut = false)
                    translate([0, 0, 14.9])
                        part_b5();
    color("black")
        translate([116, 50, 0.01])
            linear_extrude(height = th)
                outline2d(0.28)
                    projection(cut = false)
                        translate([0, 0, 14.9])
                            part_b5();

    // b6 orthographic/details cluster.
    color([0.95, 0.95, 0.95])
        translate([322, 126, 0])
            linear_extrude(height = th)
                projection(cut = false)
                    rotate([90, 0, 0])
                        translate([0, 0, 3.65])
                            part_b6();
    color("black")
        translate([322, 126, 0.01])
            linear_extrude(height = th)
                outline2d(0.28)
                    projection(cut = false)
                        rotate([90, 0, 0])
                            translate([0, 0, 3.65])
                                part_b6();

    color([0.95, 0.95, 0.95])
        translate([323, 85, 0])
            linear_extrude(height = th)
                projection(cut = false)
                    translate([0, 0, 3.65])
                        part_b6();
    color("black")
        translate([323, 85, 0.01])
            linear_extrude(height = th)
                outline2d(0.28)
                    projection(cut = false)
                        translate([0, 0, 3.65])
                            part_b6();

    // Key dimensions and source-note text.
    color("black")
        linear_extrude(height = th) {
            dim_h(103, 126, 182, "4.5");
            dim_v(58, 101, 82, "23.6");
            dim_v(54, 71, 97, "7");
            dim_h(312, 334, 148, "5");
            dim_v(111, 132, 288, "5.3");
            dim_v(127, 140, 304, "3.0");
        }

    color("black") translate([132, 244, 0]) linear_extrude(height = th) label("b5 x 4", sz = 3.1, bold = true);
    color("black") translate([335, 205, 0]) linear_extrude(height = th) label("b6", sz = 3.1, bold = true);
    color("black") translate([282, 124, 0]) linear_extrude(height = th) label("Fitted (not 2.5 for Venus pin and slot parallel to b1)?", sz = 2.5);

    // Leaders.
    color("black")
        linear_extrude(height = th) {
            line2d([146, 244], [126, 222], 0.24);
            line2d([338, 205], [325, 199], 0.24);
            line2d([286, 125], [305, 111], 0.24);
        }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet7();
}
