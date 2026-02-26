// DRW-022 Sheet 6 — Superior Planet Plate (sp2, sp8, sp9).
// Source: Superior_Planet_Plate_page_06.png
// SPDX-License-Identifier: MIT

use <../parts/sp2_gear_axle_subassembly.scad>
use <../parts/sp8_large_gear.scad>
use <../parts/sp9_latch.scad>
use <../parts/sp10_disc.scad>

module label(s, p = [0, 0], sz = 3.2, bold = false) {
    text(s, size = sz, halign = "left", valign = "center",
         font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module line2d(a = [0, 0], b = [10, 0], w = 0.35) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.45) {
    difference() {
        offset(r =  w / 2) children();
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
        translate([(x0 + x1) / 2, y + txt_dy])
            text(txt, size = 3.2, halign = "center", valign = "bottom");
    }
}

module dim_v(y0, y1, x, ext0, ext1, txt = "", txt_dx = 2.2) {
    line2d([x, y0], [x, y1], 0.3);
    line2d([x, y0], [ext0, y0], 0.25);
    line2d([x, y1], [ext1, y1], 0.25);
    translate([x, y0]) rotate([0, 0, -90]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    translate([x, y1]) rotate([0, 0,  90]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    if (txt != "") {
        translate([x + txt_dx, (y0 + y1) / 2]) rotate([0, 0, 90])
            text(txt, size = 3.2, halign = "center", valign = "bottom");
    }
}

module proj_top_sp8() {
    projection(cut = true) part_sp8();
}

module proj_side_sp8() {
    projection(cut = true) rotate([90, 0, 0]) part_sp8();
}

module proj_side_sp9() {
    projection(cut = true) rotate([90, 0, 0]) part_sp9();
}

module proj_top_sp9() {
    projection(cut = true) part_sp9();
}

module proj_top_sp10() {
    projection(cut = true) part_sp10();
}

module drw022_sheet6() {
    w      = 420;
    h      = 297;
    border = 8;
    th     = 0.12;
    bronze = [0.45, 0.30, 0.18];

    // Sheet border.
    color("black")
    linear_extrude(height = th)
    difference() {
        square([w, h], center = false);
        translate([border, border]) square([w - 2 * border, h - 2 * border], center = false);
    }

    // Title block.
    color("black")
    linear_extrude(height = th) {
        outline2d(0.45) translate([300, 8]) square([112, 42], center = false);
        line2d([300, 22], [412, 22], 0.3);
        line2d([300, 34], [412, 34], 0.3);
        line2d([352, 8],  [352, 50], 0.3);
    }

    color("black") translate([303, 42, 0]) linear_extrude(height = th)
        label("PROJECT  Antikythera Mechanism", sz = 3.9, bold = true);
    color("black") translate([303, 28, 0]) linear_extrude(height = th)
        label("DWG  Superior Planet Plate (sp2, sp8, sp9)", sz = 3.3);
    color("black") translate([303, 15, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 6 OF 7", sz = 3.3);

    // ---- sp8 large gear — top-left, fill + outline ----
    sp8_sc = 2.0;
    sp8_cx = 70;
    sp8_cy = 210;

    color([0.90, 0.90, 0.90])
    translate([sp8_cx, sp8_cy, 0.00]) linear_extrude(height = th)
        scale([sp8_sc, sp8_sc, 1]) proj_top_sp8();
    color("black")
    translate([sp8_cx, sp8_cy, 0.01]) linear_extrude(height = th)
        scale([sp8_sc, sp8_sc, 1]) outline2d(0.40) proj_top_sp8();

    color("black") translate([12, 244, 0]) linear_extrude(height = th)
        label("sp8", sz = 3.4, bold = true);

    // Radial dimension callouts on sp8.
    color("black") linear_extrude(height = th) {
        dim_h(sp8_cx - 20.48*sp8_sc, sp8_cx, sp8_cy + 21 * sp8_sc,
              sp8_cy + 20.48*sp8_sc, sp8_cy + 20.48*sp8_sc, "R20.48");
        dim_h(sp8_cx - 19.09*sp8_sc, sp8_cx, sp8_cy + 18 * sp8_sc,
              sp8_cy + 19.09*sp8_sc, sp8_cy + 19.09*sp8_sc, "R19.09");
    }

    // Boss detail bottom-left (bore Ø4.0, boss Ø4.9, fitted 12.5).
    color("black") translate([12, 70, 0]) linear_extrude(height = th) {
        dim_h(16, 20, 60, 68, 68, "\u00d84.0");
        dim_h(16, 21, 52, 60, 60, "\u00d84.9");
        dim_v(32, 44.5, 30, 18, 18, "12.5");
    }
    color("black") translate([14, 49, 0]) linear_extrude(height = th)
        label("Fitted 12.5", sz = 2.8);
    color("black") translate([14, 43, 0]) linear_extrude(height = th)
        label("Tight press fit sp8 to sp2", sz = 2.8);

    // SECTION E-E label.
    color("black") translate([175, 62, 0]) linear_extrude(height = th)
        label("SECTION E-E", sz = 4.5, bold = true);
    color("black") translate([178, 51, 0]) linear_extrude(height = th)
        label("SCALE 2 : 1", sz = 3.8);

    // sp8 section E-E (side view scaled 2:1).
    color([0.90, 0.90, 0.90])
    translate([193, 66, 0.00]) linear_extrude(height = th)
        scale([2, 2, 1]) proj_side_sp8();
    color("black")
    translate([193, 66, 0.01]) linear_extrude(height = th)
        scale([2, 2, 1]) outline2d(0.35) proj_side_sp8();

    // Tooth thickness callout on section E-E.
    color("black") translate([195, 71, 0]) linear_extrude(height = th)
        label("3.1", sz = 2.8);

    // ---- sp9 latch — top-center ----
    sp9_cx = 140;
    sp9_cy = 245;
    sp9_sc = 1.5;

    color([0.90, 0.90, 0.90])
    translate([sp9_cx, sp9_cy, 0.00]) linear_extrude(height = th)
        scale([sp9_sc, sp9_sc, 1]) proj_top_sp9();
    color("black")
    translate([sp9_cx, sp9_cy, 0.01]) linear_extrude(height = th)
        scale([sp9_sc, sp9_sc, 1]) outline2d(0.40) proj_top_sp9();

    color("black") translate([138, 283, 0]) linear_extrude(height = th)
        label("sp9", sz = 3.4, bold = true);

    color("black") linear_extrude(height = th) {
        dim_h(sp9_cx, sp9_cx + 51 * sp9_sc,
              sp9_cy + 18, sp9_cy + 16.5*sp9_sc, sp9_cy + 16.5*sp9_sc, "51");
        dim_h(sp9_cx, sp9_cx + 32 * sp9_sc,
              sp9_cy - 11, sp9_cy - 9.5*sp9_sc, sp9_cy - 9.5*sp9_sc, "32.0");
        dim_h(sp9_cx + 32*sp9_sc, sp9_cx + 44*sp9_sc,
              sp9_cy - 11, sp9_cy - 9.5*sp9_sc, sp9_cy - 9.5*sp9_sc, "12.0");
    }

    // sp9 3D iso thumbnail.
    translate([192, 195, 12]) rotate([65, 0, 20]) scale([1.4, 1.4, 1.4])
        color([0.45, 0.30, 0.18]) part_sp9();

    // ---- sp10 disc — below sp9 label ----
    sp10_cx = 118;
    sp10_cy = 150;
    sp10_sc = 5.0;

    color([0.90, 0.90, 0.90])
    translate([sp10_cx, sp10_cy, 0.00]) linear_extrude(height = th)
        scale([sp10_sc, sp10_sc, 1]) proj_top_sp10();
    color("black")
    translate([sp10_cx, sp10_cy, 0.01]) linear_extrude(height = th)
        scale([sp10_sc, sp10_sc, 1]) outline2d(0.40) proj_top_sp10();

    color("black") translate([102, 168, 0]) linear_extrude(height = th)
        label("sp10", sz = 3.0, bold = true);

    color("black") linear_extrude(height = th) {
        dim_h(sp10_cx - 4.5*sp10_sc, sp10_cx + 4.5*sp10_sc,
              sp10_cy - 5.5*sp10_sc, sp10_cy - 4.5*sp10_sc, sp10_cy - 4.5*sp10_sc, "\u00d89.0");
        dim_h(sp10_cx - 3.5*sp10_sc, sp10_cx + 3.5*sp10_sc,
              sp10_cy - 7 * sp10_sc, sp10_cy - 6*sp10_sc, sp10_cy - 6*sp10_sc, "\u00d87.0");
        dim_h(sp10_cx - 2.5*sp10_sc, sp10_cx + 2.5*sp10_sc,
              sp10_cy - 8.5*sp10_sc, sp10_cy - 7.5*sp10_sc, sp10_cy - 7.5*sp10_sc, "\u00d85.0");
    }

    // ---- sp2 sub assembly isometric — right ----
    translate([260, 180, 20]) rotate([65, 0, 25]) scale([2.0, 2.0, 2.0]) {
        color([0.45, 0.30, 0.18]) part_sp2();
        translate([0, 0, 16]) rotate([180, 0, 0]) color([0.50, 0.35, 0.20]) part_sp8();
        translate([0, 0, 3])  color([0.40, 0.28, 0.16]) part_sp10();
    }
    color("black") translate([248, 90, 0]) linear_extrude(height = th)
        label("sp2 sub assembly", sz = 3.2, bold = true);

    // sp2 gear assembly label (large iso top-right).
    translate([355, 190, 20]) rotate([65, 0, 25]) scale([1.2, 1.2, 1.2])
        color([0.50, 0.35, 0.20]) part_sp8();
    color("black") translate([340, 250, 0]) linear_extrude(height = th)
        label("sp2 gear assembly", sz = 3.0, bold = true);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw022_sheet6();
}
