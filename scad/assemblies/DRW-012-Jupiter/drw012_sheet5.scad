// DRW-012 Sheet 5 recreation (Jupiter: jup2, jup7, jup8, cp-f4).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-012-Jupiter/jup2_gear.scad>
use <../../parts/DRW-012-Jupiter/jup7_hub.scad>
use <../../parts/DRW-012-Jupiter/jup8_spacer.scad>
use <../../parts/DRW-005-Common-Parts/cpf4_fork.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.3) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.35) {
    difference() {
        offset(r = w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module jup2_subassembly() {
    color([0.42, 0.30, 0.18]) part_jup2();
    color([0.36, 0.31, 0.27]) translate([0, 0, 1.0]) part_jup7();
    color([0.36, 0.31, 0.27]) translate([0, 0, 1.0]) part_jup8();
    color([0.38, 0.30, 0.24]) translate([3.0, -1.2, 1.6]) rotate([0, 0, -28]) part_cpf4();
}

module drw012_sheet5() {
    W = 420;
    H = 297;
    B = 8;
    th = 0.12;

    color("black")
    linear_extrude(height = th)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W - 2 * B, H - 2 * B], center = false);
    }

    color("black")
    linear_extrude(height = th) {
        outline2d(0.4) translate([285, 8]) square([127, 34], center = false);
        line2d([285, 20], [412, 20], 0.28);
        line2d([285, 30], [412, 30], 0.28);
        line2d([325, 8], [325, 42], 0.28);
        line2d([376, 8], [376, 42], 0.28);
    }
    color("black") translate([289, 37, 0]) linear_extrude(height = th) label("PROJECT   Antikithera Mechanism", sz = 3.1, bold = true);
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Jupiter   (jup2, jup7, jup8, cp-f4)", sz = 2.9);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 5 OF 9", sz = 2.9);

    // Top part previews.
    color([0.42, 0.30, 0.18]) translate([60, 210, 8]) rotate([68, 0, 25]) scale([1.9, 1.9, 1.9]) part_jup2();
    color([0.42, 0.30, 0.18]) translate([230, 219, 8]) rotate([68, 0, 20]) scale([1.9, 1.9, 1.9]) part_jup2();
    color([0.36, 0.31, 0.27]) translate([355, 228, 8]) rotate([68, 0, 22]) scale([1.7, 1.7, 1.7]) part_jup7();
    color("black") translate([82, 248, 0]) linear_extrude(height = th) label("jup2", sz = 3.0, bold = true);
    color("black") translate([358, 246, 0]) linear_extrude(height = th) label("jup7", sz = 3.0, bold = true);

    // 2D gear/profile views.
    color([0.93, 0.93, 0.93]) translate([57, 87, 0]) linear_extrude(height = th) projection(cut = true) part_jup2();
    color("black") translate([57, 87, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup2();

    color([0.93, 0.93, 0.93]) translate([31, 114, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_jup2();
    color("black") translate([31, 114, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup2();

    color([0.93, 0.93, 0.93]) translate([333, 121, 0]) linear_extrude(height = th) projection(cut = true) part_jup7();
    color("black") translate([333, 121, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup7();
    color([0.93, 0.93, 0.93]) translate([334, 77, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_jup8();
    color("black") translate([334, 77, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup8();
    color([0.36, 0.31, 0.27]) translate([354, 130, 8]) rotate([68, 0, 20]) scale([1.35, 1.35, 1.35]) part_jup8();
    color("black") translate([358, 146, 0]) linear_extrude(height = th) label("jup8", sz = 3.0, bold = true);

    // Center sub-assembly.
    translate([230, 142, 0]) rotate([70, 0, 18]) scale([1.45, 1.45, 1.45]) jup2_subassembly();
    color("black") translate([214, 102, 0]) linear_extrude(height = th) label("jup2 sub assembly", sz = 2.8);
    color("black") translate([198, 174, 0]) linear_extrude(height = th) label("cp-f4", sz = 2.8, bold = true);

    // Bottom section views.
    color([0.36, 0.31, 0.27]) translate([192, 26, 0]) rotate([70, 0, 18]) scale([1.45, 1.45, 1.45]) jup2_subassembly();
    color([0.36, 0.31, 0.27]) translate([228, 31, 0]) rotate([0, 0, 0]) projection(cut = false) jup2_subassembly();
    color([0.93, 0.93, 0.93]) translate([240, 22, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([90, 0, 0]) jup2_subassembly();
    color("black") translate([240, 22, 0.01]) linear_extrude(height = th)
        outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) jup2_subassembly();
    color("black") translate([229, 60, 0]) linear_extrude(height = th) label("H", sz = 7.2, bold = true);
    color("black") translate([227, 14, 0]) linear_extrude(height = th) label("H", sz = 7.2, bold = true);
    color("black") translate([252, 82, 0]) linear_extrude(height = th) label("SECTION H-H", sz = 4.6, bold = true);
    color("black") translate([266, 72, 0]) linear_extrude(height = th) label("SCALE 2 : 1", sz = 3.5, bold = true);

    // Key dimension text.
    color("black") {
        translate([39, 101, 0]) linear_extrude(height = th) label("R11.70", sz = 2.8);
        translate([39, 91, 0]) linear_extrude(height = th) label("R10.44", sz = 2.8);
        translate([131, 76, 0]) linear_extrude(height = th) label("\u23007.0", sz = 2.8);
        translate([129, 58, 0]) linear_extrude(height = th) label("R.5", sz = 2.8);
        translate([149, 135, 0]) linear_extrude(height = th) label("1.0", sz = 2.8);

        translate([302, 145, 0]) linear_extrude(height = th) label("\u23001.0", sz = 2.8);
        translate([335, 145, 0]) linear_extrude(height = th) label("\u23007.0", sz = 2.8);
        translate([329, 136, 0]) linear_extrude(height = th) label("\u23005.0", sz = 2.8);
        translate([330, 58, 0]) linear_extrude(height = th) label("\u23004.9", sz = 2.8);
        translate([355, 58, 0]) linear_extrude(height = th) label("\u23004.0", sz = 2.8);
        translate([302, 57, 0]) linear_extrude(height = th) label("\u23003.0", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw012_sheet5();
}
