// DRW-022 Sheet 1 — Superior Planet Plate (assembly, isometric view).
// Source: Superior_Planet_Plate_page_01.png
// SPDX-License-Identifier: MIT

use <../parts/sp1_superior_gear.scad>
use <../parts/sp2_gear_axle_subassembly.scad>
use <../parts/sp5_superior_plate.scad>
use <../parts/sp7_companion_gear.scad>
use <../parts/sp8_large_gear.scad>
use <../parts/sp9_latch.scad>

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

// Full SP assembly isometric: sp5 carrier plate + sp1 + sp7 + sp2 + sp8.
module sp_full_assembly() {
    bronze    = [0.45, 0.30, 0.18];
    bronze2   = [0.50, 0.35, 0.20];
    dark_brz  = [0.33, 0.25, 0.15];

    // SP5 — large square carrier plate.
    color(bronze)  part_sp5();

    // SP1 — superior gear ring centred on SP5 face.
    color(bronze2) translate([0, 0, 2.0]) part_sp1();

    // SP7 — companion ring on top of SP1.
    color(dark_brz) translate([0, 0, 4.0]) part_sp7();

    // SP2 — gear axle subassembly offset from centre.
    color(bronze) translate([38, 0, 2.0]) part_sp2();

    // SP8 — large gear press-fit on SP2 axle.
    color(bronze2) translate([38, 0, 2.0 + 3.0]) rotate([180, 0, 0])
        part_sp8();

    // SP9 — Jupiter/Mars latch.
    color(dark_brz) translate([-55, -8, 2.5]) part_sp9();
}

module drw022_sheet1() {
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
        label("DWG  Superior Planet Plate (assembly)", sz = 3.3);
    color("black") translate([303, 15, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 1 OF 7", sz = 3.3);

    // 3D isometric assembly — centred on sheet, lifted in Z so it renders
    // in front of the 2D sheet geometry.
    translate([150, 148, 30]) rotate([65, 0, 30]) scale([0.52, 0.52, 0.52])
        sp_full_assembly();

    // Annotation label.
    color("black") translate([84, 256, 0]) linear_extrude(height = th)
        label("sp superior planet plate  —  full assembly", sz = 3.6, bold = true);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw022_sheet1();
}
