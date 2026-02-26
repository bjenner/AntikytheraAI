// DRW-022 Sheet 7 — Superior Planet Plate (sp1, sp2 dimensions; sp3 cut pattern; sp4 ring detail).
// Source: Superior_Planet_Plate_page_07.png
// SPDX-License-Identifier: MIT

use <../parts/sp1_superior_gear.scad>
use <../parts/sp2_gear_axle_subassembly.scad>
use <../parts/sp3_superior_plate.scad>
use <../parts/sp5_superior_plate.scad>

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

// sp4 axle ring spacer (Ø20.0 outer, Ø18.0 step, Ø16.0 bore) shown on sheet 7.
// This is the sp1-axle ring, distinct from the press pin (sp4_press_pin.scad).
module sp4_ring_detail(cx, cy) {
    th = 0.12;
    od = 20.0; mid_d = 18.0; bore_d = 16.0; ring_h = 1.5;

    color([0.90, 0.90, 0.90])
    translate([cx, cy, 0.00]) linear_extrude(height = th)
        difference() {
            circle(d = od,     $fn = 80);
            circle(d = bore_d, $fn = 80);
        }
    color("black")
    translate([cx, cy, 0.01]) linear_extrude(height = th)
        outline2d(0.35) difference() {
            circle(d = od,     $fn = 80);
            circle(d = bore_d, $fn = 80);
        }
    color("black") linear_extrude(height = th) {
        dim_h(cx - od/2,    cx + od/2,    cy - 14, cy - od/2,    cy - od/2,    "\u00d820.0");
        dim_h(cx - mid_d/2, cx + mid_d/2, cy - 18, cy - mid_d/2, cy - mid_d/2, "\u00d818.0");
        dim_h(cx - bore_d/2,cx + bore_d/2,cy - 22, cy - bore_d/2,cy - bore_d/2,"\u00d816.0");
    }
    color("black") translate([cx - 12, cy - 28, 0]) linear_extrude(height = th)
        label("sp4  (sp1 axle ring)", sz = 2.6);
    color("black") translate([cx - 12, cy - 34, 0]) linear_extrude(height = th)
        label("Very tight press fit sp4 to sp3", sz = 2.6);
}

// sp3 sheet metal cut pattern (simplified outline with hole positions).
module sp3_cut_pattern(cx, cy) {
    th   = 0.12;
    sc   = 0.45;

    color([0.90, 0.90, 0.90])
    translate([cx, cy, 0.00]) linear_extrude(height = th)
        scale([sc, sc, 1]) projection(cut = true) part_sp3();
    color("black")
    translate([cx, cy, 0.01]) linear_extrude(height = th)
        scale([sc, sc, 1]) outline2d(0.40) projection(cut = true) part_sp3();

    color("black") translate([cx - 26, cy - 26, 0]) linear_extrude(height = th)
        label("sp3  sheet metal cut pattern", sz = 2.6);
}

module drw022_sheet7() {
    w      = 420;
    h      = 297;
    border = 8;
    th     = 0.12;

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
        label("DWG  Superior Planet Plate (sp1, sp2)", sz = 3.3);
    color("black") translate([303, 15, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 7 OF 7", sz = 3.3);

    // ---- sp1 hole-pattern top view (left, scale 1:1) ----
    sp1_cx = 92;
    sp1_cy = 178;

    color([0.90, 0.90, 0.90])
    translate([sp1_cx, sp1_cy, 0.00]) linear_extrude(height = th)
        projection(cut = true) part_sp1();
    color("black")
    translate([sp1_cx, sp1_cy, 0.01]) linear_extrude(height = th)
        outline2d(0.45) projection(cut = true) part_sp1();

    color("black") translate([sp1_cx - 24, sp1_cy + 24, 0]) linear_extrude(height = th)
        label("sp1", sz = 3.2, bold = true);

    // Angular bolt-hole callouts (from DRW-022 sheet 7: 169.1°, 133.6°, 179°, 142.1° positions).
    color("black") linear_extrude(height = th) {
        // Cross-hairs.
        line2d([sp1_cx - 22, sp1_cy], [sp1_cx + 22, sp1_cy], 0.2);
        line2d([sp1_cx, sp1_cy - 22], [sp1_cx, sp1_cy + 22], 0.2);
        // Pitch-circle radius annotation.
        line2d([sp1_cx, sp1_cy], [sp1_cx + 13, sp1_cy + 13], 0.25);
    }
    color("black") translate([sp1_cx + 13, sp1_cy + 14, 0]) linear_extrude(height = th)
        label("R13.0 bolt PCD", sz = 2.6);

    // Key angular dimensions.
    color("black") translate([sp1_cx - 24, sp1_cy - 28, 0]) linear_extrude(height = th)
        label("Bolt circle  R13.0  4 holes  Ø3.0", sz = 2.6);
    color("black") translate([sp1_cx - 24, sp1_cy - 33, 0]) linear_extrude(height = th)
        label("Hole angles:  169.1°  133.6°  179°  142.1°", sz = 2.6);

    // sp1 OD dimension.
    color("black") linear_extrude(height = th) {
        dim_h(sp1_cx - 19.6, sp1_cx + 19.6,
              sp1_cy + 23, sp1_cy + 19.6, sp1_cy + 19.6, "\u00d839.2");
        dim_h(sp1_cx - 10.1, sp1_cx + 10.1,
              sp1_cy - 25, sp1_cy - 20.2/2, sp1_cy - 20.2/2, "\u00d820.2 bore");
    }

    // ---- sp2 side-view (centre, scale 1:1) ----
    sp2_cx = 200;
    sp2_cy = 178;

    color([0.90, 0.90, 0.90])
    translate([sp2_cx, sp2_cy, 0.00]) linear_extrude(height = th)
        projection(cut = true) rotate([90, 0, 0]) part_sp2();
    color("black")
    translate([sp2_cx, sp2_cy, 0.01]) linear_extrude(height = th)
        outline2d(0.45) projection(cut = true) rotate([90, 0, 0]) part_sp2();

    color("black") translate([sp2_cx + 16, sp2_cy + 18, 0]) linear_extrude(height = th)
        label("sp2", sz = 3.2, bold = true);

    color("black") linear_extrude(height = th) {
        dim_h(sp2_cx - 14, sp2_cx + 14, sp2_cy + 20,
              sp2_cy + 16, sp2_cy + 16, "\u00d828.0");
        dim_v(sp2_cy, sp2_cy + 16, sp2_cx + 18,
              sp2_cx + 14, sp2_cx + 14, "16.0");
    }

    // ---- sp3 sheet metal cut pattern — bottom-right ----
    sp3_cut_pattern(255, 150);

    // ---- sp4 axle ring detail — bottom-left ----
    sp4_ring_detail(68, 76);

    // sp4 3D iso thumbnail.
    translate([95, 55, 8]) rotate([65, 0, 25]) scale([3.0, 3.0, 3.0]) {
        color([0.85, 0.85, 0.85])
        difference() {
            cylinder(d = 20, h = 1.5, center = false, $fn = 60);
            translate([0, 0, -0.1]) cylinder(d = 16, h = 1.7, center = false, $fn = 60);
        }
    }
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw022_sheet7();
}
