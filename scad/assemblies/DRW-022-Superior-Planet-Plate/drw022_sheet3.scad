// DRW-022 Sheet 3 — Superior Planet Plate (Gear clearance).
// Source: Superior_Planet_Plate_page_03.png
// SPDX-License-Identifier: MIT

use <../../parts/DRW-022-Superior-Planet-Plate/sp1_superior_gear.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp2_gear_axle_subassembly.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp5_superior_plate.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp7_companion_gear.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp8_large_gear.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp9_latch.scad>

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

// Top-view projection of the gear assembly (sp1 + sp7 centred, sp2+sp8 offset, sp9 latch).
module gear_asm_top_proj() {
    projection(cut = true) {
        part_sp1();
        part_sp7();
        translate([38, 0, 3]) part_sp2();
        translate([38, 0, 3]) rotate([180, 0, 0]) part_sp8();
        translate([-55, -8, 2.5]) part_sp9();
    }
}

module drw022_sheet3() {
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
        label("DWG  Superior Planet Plate (Gear clearance)", sz = 3.3);
    color("black") translate([303, 15, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 3 OF 7", sz = 3.3);

    // --- Left view: full top projection scale 1:1.5 (drawn at 1:1, label indicates source scale) ---
    left_cx = 90;
    left_cy = 148;
    left_sc = 0.67;   // 1:1.5

    color([0.90, 0.90, 0.90])
    translate([left_cx, left_cy, 0.00]) linear_extrude(height = th)
        scale([left_sc, left_sc, 1]) gear_asm_top_proj();
    color("black")
    translate([left_cx, left_cy, 0.01]) linear_extrude(height = th)
        scale([left_sc, left_sc, 1]) outline2d(0.45) gear_asm_top_proj();

    // Scale label.
    color("black") translate([15, 14, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1.5", sz = 4.0, bold = true);

    // Overall width callout on left view.
    color("black") linear_extrude(height = th) {
        dim_h(left_cx + (-92 * left_sc), left_cx + (92 * left_sc),
              left_cy - 92 * left_sc - 10,
              left_cy - 92 * left_sc, left_cy - 92 * left_sc,
              "184.0");
    }

    // --- Right view: sp1 + sp8 top projection scale 1:1 with gear clearance annotation ---
    right_cx = 240;
    right_cy = 148;

    color([0.90, 0.90, 0.90])
    translate([right_cx, right_cy, 0.00]) linear_extrude(height = th)
        projection(cut = true) part_sp1();
    color("black")
    translate([right_cx, right_cy, 0.01]) linear_extrude(height = th)
        outline2d(0.45) projection(cut = true) part_sp1();

    color([0.90, 0.90, 0.90])
    translate([right_cx + 38, right_cy, 0.00]) linear_extrude(height = th)
        projection(cut = true) part_sp8();
    color("black")
    translate([right_cx + 38, right_cy, 0.01]) linear_extrude(height = th)
        outline2d(0.45) projection(cut = true) part_sp8();

    // Radial callout: sp1 root radius.
    color("black") linear_extrude(height = th) {
        line2d([right_cx, right_cy], [right_cx + 18.3, right_cy + 18.3], 0.25);
        translate([right_cx + 14, right_cy + 20]) text("R18.3", size = 2.8, halign = "left");
    }

    // Scale label right view.
    color("black") translate([195, 14, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 4.0, bold = true);

    // Clearance note.
    color("black") translate([196, 252, 0]) linear_extrude(height = th)
        label("Gear clearance check: sp1 — sp8 mesh", sz = 3.2);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw022_sheet3();
}
