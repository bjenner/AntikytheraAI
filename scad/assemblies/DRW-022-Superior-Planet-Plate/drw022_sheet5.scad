// DRW-022 sheet recreation (engineering-style layout).
// Focused on SP1, SP5, SP6, SP7 as requested.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-022-Superior-Planet-Plate/sp1_superior_gear.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp5_superior_plate.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp6_rivet_pin.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp7_companion_gear.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.35) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.45) {
    difference() {
        offset(r = w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module dim_h(x0, x1, y, ext0, ext1, txt = "", txt_dy = 2.2) {
    line2d([x0, y], [x1, y], 0.3);
    line2d([x0, y], [x0, ext0], 0.25);
    line2d([x1, y], [x1, ext1], 0.25);
    translate([x0, y]) rotate([0, 0, 180]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    translate([x1, y]) polygon([[0, 0], [-1.4, 0.5], [-1.4, -0.5]]);
    if (txt != "") {
        translate([(x0 + x1) / 2, y + txt_dy]) text(txt, size = 3.2, halign = "center", valign = "bottom");
    }
}

module dim_v(y0, y1, x, ext0, ext1, txt = "", txt_dx = 2.2) {
    line2d([x, y0], [x, y1], 0.3);
    line2d([x, y0], [ext0, y0], 0.25);
    line2d([x, y1], [ext1, y1], 0.25);
    translate([x, y0]) rotate([0, 0, -90]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    translate([x, y1]) rotate([0, 0, 90]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    if (txt != "") {
        translate([x + txt_dx, (y0 + y1) / 2]) rotate([0, 0, 90]) text(txt, size = 3.2, halign = "center", valign = "bottom");
    }
}

module label(s, p = [0, 0], sz = 3.2, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module proj_top_sp5() {
    projection(cut = true) part_sp5();
}

module proj_top_sp1() {
    projection(cut = true) part_sp1();
}

module proj_top_sp7() {
    projection(cut = true) part_sp7();
}

module proj_side_sp6() {
    projection(cut = true) rotate([90, 0, 0]) part_sp6();
}

module proj_end_sp6() {
    projection(cut = true) part_sp6();
}

module iso_sp1() {
    color([0.45, 0.30, 0.18]) rotate([65, 0, 35]) part_sp1();
}

module iso_sp7() {
    color([0.45, 0.30, 0.18]) rotate([65, 0, 28]) part_sp7();
}

module iso_sp5() {
    color([0.45, 0.30, 0.18]) rotate([68, 0, 12]) part_sp5();
}

module iso_sp6() {
    color([0.25, 0.25, 0.25]) rotate([90, 0, 0]) part_sp6();
}

module drw022_sheet5() {
    // A3 sheet in mm.
    w = 420;
    h = 297;
    border = 8;
    th = 0.12; // tiny Z thickness so text/lines are visible in 3D preview.

    color("black")
    linear_extrude(height = th)
    difference() {
        square([w, h], center = false);
        translate([border, border]) square([w - 2 * border, h - 2 * border], center = false);
    }

    // Title block lines (no filled panels).
    color("black")
    linear_extrude(height = th) {
        outline2d(0.45) translate([300, 8]) square([112, 42], center = false);
        line2d([300, 22], [412, 22], 0.3);
        line2d([300, 34], [412, 34], 0.3);
        line2d([352, 8], [352, 50], 0.3);
    }

    color("black")
    translate([303, 42, 0]) linear_extrude(height = th) label("PROJECT  Antikythera Mechanism", sz = 3.9, bold = true);
    color("black")
    translate([303, 28, 0]) linear_extrude(height = th) label("DWG  Superior Planet Plate (sp1, sp5, sp6)", sz = 3.3);
    color("black")
    translate([303, 15, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 5 OF 7", sz = 3.3);

    // Main SP5 front view (fill + edge for readability).
    color([0.85, 0.85, 0.85])
    translate([200, 178, 0.00]) linear_extrude(height = th) proj_top_sp5();
    color("black")
    translate([200, 178, 0.01]) linear_extrude(height = th) outline2d(0.45) proj_top_sp5();
    color("black")
    translate([108, 274, 0]) linear_extrude(height = th) label("sp5", sz = 3.6, bold = true);

    // Dimensions around SP5.
    color("black")
    linear_extrude(height = th) {
        dim_h(108, 292, 265, 270, 270, "184.0");
        dim_v(86, 270, 305, 86, 270, "184.0");
        dim_h(108, 115.5, 255, 258, 258, "7.5");
        dim_h(284.5, 292, 255, 258, 258, "7.5");
        dim_v(262.5, 270, 98, 108, 108, "7.5");
        dim_v(86, 93.5, 98, 108, 108, "7.5");
        dim_h(192.5, 207.5, 116, 123, 123, "15");
    }

    // SP1 and SP7 detail views (fill + edge).
    color([0.90, 0.90, 0.90])
    translate([66, 170, 0.00]) linear_extrude(height = th) proj_top_sp1();
    color("black")
    translate([66, 170, 0.01]) linear_extrude(height = th) outline2d(0.40) proj_top_sp1();
    color([0.90, 0.90, 0.90])
    translate([66, 68, 0.00]) linear_extrude(height = th) proj_top_sp7();
    color("black")
    translate([66, 68, 0.01]) linear_extrude(height = th) outline2d(0.40) proj_top_sp7();
    color("black")
    translate([96, 206, 0]) linear_extrude(height = th) label("sp1", sz = 3.4, bold = true);
    color("black")
    translate([96, 102, 0]) linear_extrude(height = th) label("sp7", sz = 3.4, bold = true);

    // SP6 pin detail (explicit detail block).
    color("black")
    linear_extrude(height = th)
    difference() {
        translate([120, 48]) square([54, 32], center = false);
        translate([120.35, 48.35]) square([53.3, 31.3], center = false);
    }

    color([0.90, 0.90, 0.90])
    translate([138, 62, 0.00]) linear_extrude(height = th) scale([3, 3, 1]) proj_side_sp6();
    color("black")
    translate([138, 62, 0.01]) linear_extrude(height = th) scale([3, 3, 1]) outline2d(0.35) proj_side_sp6();

    color([0.90, 0.90, 0.90])
    translate([159, 62, 0.00]) linear_extrude(height = th) scale([3, 3, 1]) proj_end_sp6();
    color("black")
    translate([159, 62, 0.01]) linear_extrude(height = th) scale([3, 3, 1]) outline2d(0.35) proj_end_sp6();

    color("black")
    translate([123, 76, 0]) linear_extrude(height = th) label("DETAIL: sp6 x 4", sz = 3.5, bold = true);

    color("black")
    linear_extrude(height = th) line2d([132, 73], [138, 66], 0.25);

    color("black")
    linear_extrude(height = th) {
        dim_v(55, 70, 149, 138, 138, "5.0");
        dim_h(154.5, 163.5, 54, 62, 62, "Ø3.0");
    }

    // Note.
    color("black")
    translate([148, 87, 0]) linear_extrude(height = th) label("Rivet sp1 to sp5 using sp6 x 4.", sz = 3.4);

    // 3D part thumbnails positioned to match DRW-022 sheet style.
    // Lift in Z so parts always render in front of 2D sheet geometry.
    translate([96, 236, 24]) scale([1.20, 1.20, 1.20]) iso_sp1();
    translate([97, 114, 24]) scale([1.20, 1.20, 1.20]) iso_sp7();
    translate([131, 72, 22]) scale([2.2, 2.2, 2.2]) iso_sp6();
    translate([224, 58, 22]) scale([0.55, 0.55, 0.55]) iso_sp5();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw022_sheet5();
}
