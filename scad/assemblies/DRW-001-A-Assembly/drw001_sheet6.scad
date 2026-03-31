// DRW-001 Sheet 6 recreation (a7 to a10 focus).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-001-A-Assembly/a7_block.scad>
use <../../parts/DRW-001-A-Assembly/a8_rivet_pin.scad>
use <../../parts/DRW-001-A-Assembly/a9_axle.scad>
use <../../parts/DRW-001-A-Assembly/a10_disc.scad>
use <./drw001_a8_subassembly.scad>

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

module label(s, sz = 3.1, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module dim_h(x0, x1, y, txt = "") {
    line2d([x0, y], [x1, y], 0.26);
    translate([x0, y]) rotate([0, 0, 180]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    translate([x1, y]) polygon([[0, 0], [-1.2, 0.42], [-1.2, -0.42]]);
    if (txt != "") translate([(x0 + x1) / 2, y + 1.7]) text(txt, size = 2.8, halign = "center");
}

module dim_v(y0, y1, x, txt = "") {
    line2d([x, y0], [x, y1], 0.26);
    translate([x, y0]) rotate([0, 0, -90]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    translate([x, y1]) rotate([0, 0, 90]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    if (txt != "") translate([x + 1.8, (y0 + y1) / 2]) rotate([0, 0, 90]) text(txt, size = 2.8, halign = "center");
}

module drw001_sheet6() {
    w = 420;
    h = 297;
    b = 8;
    th = 0.12;

    // Border.
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (a7 to a10)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 6 OF 7", sz = 2.9);

    // Top-row detail views.
    color([0.90, 0.90, 0.90]) translate([90, 195, 0]) linear_extrude(height = th) projection(cut = false) rotate([0, 90, 0]) part_a7();
    color("black") translate([90, 195, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = false) rotate([0, 90, 0]) part_a7();
    color("black") translate([48, 160, 0]) linear_extrude(height = th) label("a7", sz = 3.2, bold = true);

    color([0.90, 0.90, 0.90]) translate([124, 246, 0]) linear_extrude(height = th) projection(cut = false) rotate([90, 0, 35]) part_a8();
    color("black") translate([124, 246, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = false) rotate([90, 0, 35]) part_a8();
    color("black") translate([128, 256, 0]) linear_extrude(height = th) label("a8 x 2", sz = 2.9, bold = true);

    color([0.90, 0.90, 0.90]) translate([200, 198, 0]) linear_extrude(height = th) projection(cut = false) rotate([0, 90, 0]) part_a9();
    color("black") translate([200, 198, 0.01]) linear_extrude(height = th) outline2d(0.32) projection(cut = false) rotate([0, 90, 0]) part_a9();
    color("black") translate([233, 240, 0]) linear_extrude(height = th) label("a9", sz = 3.0, bold = true);

    color([0.90, 0.90, 0.90]) translate([360, 136, 0]) linear_extrude(height = th) projection(cut = false) part_a10();
    color("black") translate([360, 136, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = false) part_a10();
    color("black") translate([297, 116, 0]) linear_extrude(height = th) label("a10", sz = 3.0, bold = true);

    // Minimal dimension callouts to anchor the page layout to the source sheet.
    color("black")
    linear_extrude(height = th) {
        dim_h(81, 99, 263, "11");
        dim_v(183, 218, 35, "35.2");
        dim_h(194, 214, 255, "14.0");
        dim_v(181, 227, 172, "46.4");
        dim_h(329, 391, 170, "111");
    }

    // Bottom-row isometric part previews.
    color([0.45, 0.30, 0.18])
        translate([36, 72, 16])
            rotate([0, 0, 0])
                part_a7();

    color([0.52, 0.43, 0.34])
        translate([124, 245, 7])
            rotate([58, -18, -42])
                part_a8();

    color([0.52, 0.43, 0.34])
        translate([145, 79, 14])
            rotate([90, 0, 90])
                scale([0.9, 0.9, 0.9])
                    part_a9();

    color([0.52, 0.43, 0.34])
        translate([246, 220, 15])
            rotate([0, 0, 0])
                part_a9();

    color([0.45, 0.30, 0.18])
        translate([256, 72, 12])
            rotate([74, 0, -18])
                part_a10();

    // a8 subassembly area.
    translate([112, 62, 13])
        rotate([0, 90, 6])
            scale([0.82, 0.82, 0.82])
                drw001_a8_subassembly();
    color("black") translate([102, 24, 0]) linear_extrude(height = th) label("a8 sub assembly", sz = 3.0);

    // Callout leaders and labels following the source page composition.
    color("black") linear_extrude(height = th) {
        line2d([50, 168], [88, 186], 0.24);
        line2d([128, 248], [118, 238], 0.24);
        line2d([227, 236], [210, 222], 0.24);
        line2d([305, 119], [344, 137], 0.24);
        line2d([44, 92], [28, 74], 0.24);
        line2d([150, 109], [132, 88], 0.24);
        line2d([172, 109], [166, 87], 0.24);
        line2d([262, 92], [282, 114], 0.24);
    }
    color("black") translate([23, 72, 0]) linear_extrude(height = th) label("a7", sz = 3.0);
    color("black") translate([134, 107, 0]) linear_extrude(height = th) label("a9 rivet to a10", sz = 2.7);
    color("black") translate([157, 112, 0]) linear_extrude(height = th) label("a10 rivet to a12", sz = 2.7);
    color("black") translate([282, 115, 0]) linear_extrude(height = th) label("a10", sz = 3.0);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet6();
}
