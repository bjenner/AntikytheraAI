// DRW-001 Sheet 5 recreation (a1 to a7, a12 focus).
// SPDX-License-Identifier: MIT

use <../parts/a2_ring.scad>
use <../parts/a3_pin.scad>
use <../parts/a4_block.scad>
use <../parts/a5_ring.scad>
use <../parts/a6_bush.scad>
use <../parts/a12_link.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.32) {
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

module label(s, sz = 3.1, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module dim_h(x0, x1, y, txt = "") {
    line2d([x0, y], [x1, y], 0.28);
    translate([x0, y]) rotate([0, 0, 180]) polygon([[0, 0], [1.3, 0.45], [1.3, -0.45]]);
    translate([x1, y]) polygon([[0, 0], [-1.3, 0.45], [-1.3, -0.45]]);
    if (txt != "") translate([(x0 + x1) / 2, y + 1.8]) text(txt, size = 3.0, halign = "center");
}

module dim_v(y0, y1, x, txt = "") {
    line2d([x, y0], [x, y1], 0.28);
    translate([x, y0]) rotate([0, 0, -90]) polygon([[0, 0], [1.3, 0.45], [1.3, -0.45]]);
    translate([x, y1]) rotate([0, 0, 90]) polygon([[0, 0], [1.3, 0.45], [1.3, -0.45]]);
    if (txt != "") translate([x + 1.9, (y0 + y1) / 2]) rotate([0, 0, 90]) text(txt, size = 3.0, halign = "center");
}

module a1_gear(th = 2.0, tip_d = 30, root_d = 27.5, teeth = 48, bore_d = 4) {
    difference() {
        union() {
            cylinder(d = root_d, h = th, center = false);
            for (a = [0 : 360 / teeth : 360 - 360 / teeth]) {
                rotate([0, 0, a]) translate([root_d / 2, 0, 0]) translate([0, -0.35, 0])
                    cube([(tip_d - root_d) / 2, 0.7, th], center = false);
            }
        }
        translate([0, 0, -0.1]) cylinder(d = bore_d, h = th + 0.2, center = false);
    }
}

module drw001_sheet5() {
    w = 420;
    h = 297;
    b = 8;
    th = 0.12;

    // Sheet border.
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (a1 to a7, a12)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 5 OF 7", sz = 2.9);

    // Main orthographic views.
    color([0.90, 0.90, 0.90]) translate([78, 156, 0]) linear_extrude(height = th) projection(cut = true) a1_gear();
    color("black") translate([78, 156, 0.01]) linear_extrude(height = th) outline2d(0.36) projection(cut = true) a1_gear();
    color("black") translate([48, 213, 0]) linear_extrude(height = th) label("a1", sz = 3.2, bold = true);

    color([0.90, 0.90, 0.90]) translate([130, 165, 0]) linear_extrude(height = th) projection(cut = true) part_a2();
    color("black") translate([130, 165, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a2();
    color("black") translate([150, 216, 0]) linear_extrude(height = th) label("a2", sz = 3.1, bold = true);

    color([0.90, 0.90, 0.90]) translate([206, 164, 0]) linear_extrude(height = th) projection(cut = true) part_a3();
    color("black") translate([206, 164, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a3();
    color("black") translate([214, 227, 0]) linear_extrude(height = th) label("a3", sz = 3.1, bold = true);

    color([0.90, 0.90, 0.90]) translate([310, 160, 0]) linear_extrude(height = th) projection(cut = true) part_a4();
    color("black") translate([310, 160, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a4();
    color("black") translate([324, 198, 0]) linear_extrude(height = th) label("a4", sz = 3.1, bold = true);

    color([0.90, 0.90, 0.90]) translate([130, 72, 0]) linear_extrude(height = th) projection(cut = true) part_a5();
    color("black") translate([130, 72, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a5();
    color("black") translate([138, 95, 0]) linear_extrude(height = th) label("a5", sz = 3.1, bold = true);

    color([0.90, 0.90, 0.90]) translate([311, 73, 0]) linear_extrude(height = th) projection(cut = true) part_a6();
    color("black") translate([311, 73, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a6();
    color("black") translate([332, 126, 0]) linear_extrude(height = th) label("a6", sz = 3.1, bold = true);

    color([0.90, 0.90, 0.90]) translate([226, 72, 0]) linear_extrude(height = th) projection(cut = true) part_a12();
    color("black") translate([226, 72, 0.01]) linear_extrude(height = th) outline2d(0.34) projection(cut = true) part_a12();
    color("black") translate([227, 95, 0]) linear_extrude(height = th) label("a12", sz = 3.1, bold = true);

    // Key dimensions (minimal set, matching visible callouts style).
    color("black")
    linear_extrude(height = th) {
        dim_h(59, 97, 121, "R14.1");
        dim_h(205, 221, 248, "16");
        dim_v(49, 66, 347, "17");
        dim_h(222, 242, 54, "19.5");
        dim_h(301, 321, 55, "11.8");
    }

    // 3D thumbnails similar to source sheet.
    color([0.45, 0.30, 0.18]) translate([56, 226, 20]) rotate([65, 0, 35]) scale([1.2, 1.2, 1.2]) a1_gear();
    color([0.28, 0.23, 0.20]) translate([129, 234, 18]) rotate([68, 0, 25]) scale([1.0, 1.0, 1.0]) part_a2();
    color([0.55, 0.46, 0.40]) translate([206, 226, 18]) rotate([0, 0, 0]) scale([1.0, 1.0, 1.0]) part_a3();
    color([0.45, 0.30, 0.18]) translate([306, 198, 18]) rotate([0, 0, 0]) scale([1.0, 1.0, 1.0]) part_a4();
    color([0.45, 0.30, 0.18]) translate([126, 92, 18]) rotate([68, 0, 25]) scale([0.95, 0.95, 0.95]) part_a5();
    color([0.38, 0.30, 0.22]) translate([329, 93, 18]) rotate([0, 0, 0]) scale([1.0, 1.0, 1.0]) part_a6();
    color([0.30, 0.24, 0.20]) translate([228, 112, 18]) rotate([70, 0, -25]) scale([1.0, 1.0, 1.0]) part_a12();

    color("black") translate([74, 18, 0]) linear_extrude(height = th) label("a1 sub assembly", sz = 3.3);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet5();
}
