// DRW-012 Sheet 9 recreation (Jupiter, jup5 and jup11).
// SPDX-License-Identifier: MIT

use <../parts/jup5_gear.scad>
use <../parts/jup11_sleeve.scad>

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

module jupiter_pointer() {
    color([0.42, 0.30, 0.18]) {
        translate([-45, -1.0, 0]) cube([90, 2.0, 1.2], center = false);
        translate([-2, -3, 0]) linear_extrude(height = 1.2)
            difference() {
                circle(d = 16, $fn = 72);
                circle(d = 10, $fn = 64);
            }
    }
    color([0.45, 0.32, 0.20]) {
        translate([-41.5, -0.9, 1.2]) cylinder(d = 2.2, h = 8.5, $fn = 24);
        translate([40.0, -0.9, 1.2]) cylinder(d = 2.2, h = 8.5, $fn = 24);
    }
    color([0.82, 0.82, 0.84]) {
        translate([-41.5, -0.9, 9.9]) sphere(d = 4.4, $fn = 32);
        translate([40.0, -0.9, 9.9]) sphere(d = 4.4, $fn = 32);
    }
}

module drw012_sheet9() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Jupiter   (jup5, jup11)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 9 OF 9", sz = 2.9);

    // Isometric part previews.
    color([0.42, 0.30, 0.18]) translate([65, 228, 10]) rotate([68, 0, 25]) scale([1.7, 1.7, 1.7]) part_jup5();
    color("black") translate([78, 248, 0]) linear_extrude(height = th) label("jup5", sz = 3.0, bold = true);

    color([0.32, 0.27, 0.24]) translate([140, 229, 10]) rotate([68, 0, 25]) scale([1.6, 1.6, 1.6]) part_jup11();
    color("black") translate([160, 260, 0]) linear_extrude(height = th) label("jup11", sz = 3.0, bold = true);

    // 2D views.
    color([0.93, 0.93, 0.93]) translate([66, 112, 0]) linear_extrude(height = th) projection(cut = true) part_jup5();
    color("black") translate([66, 112, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup5();
    color([0.93, 0.93, 0.93]) translate([43, 138, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_jup5();
    color("black") translate([43, 138, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup5();

    color([0.93, 0.93, 0.93]) translate([152, 147, 0]) linear_extrude(height = th) projection(cut = true) rotate([90, 0, 0]) part_jup11();
    color("black") translate([152, 147, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup11();
    color([0.93, 0.93, 0.93]) translate([145, 112, 0]) linear_extrude(height = th) projection(cut = true) part_jup11();
    color("black") translate([145, 112, 0.01]) linear_extrude(height = th) outline2d(0.26) projection(cut = true) part_jup11();

    // Main pointer + gear/sleeve assembly.
    translate([305, 188, 0]) rotate([68, 0, 18]) {
        jupiter_pointer();
        color([0.32, 0.27, 0.24]) translate([0, 0, -17.6]) part_jup11();
        color([0.42, 0.30, 0.18]) translate([0, 0, -19.2]) part_jup5();
    }
    color("black") translate([250, 250, 0]) linear_extrude(height = th)
        label("Tight press fit Jupiter pointer and jup5 assembly", sz = 2.7);
    color("black") translate([263, 241, 0]) linear_extrude(height = th)
        label("to superior planet assembly.", sz = 2.7);
    color("black") translate([296, 116, 0]) linear_extrude(height = th)
        label("Jupiter pointer and jup5 assembly", sz = 3.0);

    // Subassembly inset and section callout.
    translate([110, 20, 0]) rotate([70, 0, 20]) {
        color([0.32, 0.27, 0.24]) translate([0, 0, 0]) part_jup11();
        color([0.42, 0.30, 0.18]) translate([0, 0, -1.6]) part_jup5();
    }
    color("black") translate([82, 42, 0]) linear_extrude(height = th) label("jup5 sub assembly", sz = 2.8);
    color("black") translate([127, 62, 0]) linear_extrude(height = th) label("Very tight press fit jup5 to jup11", sz = 2.6);

    color([0.93, 0.93, 0.93]) translate([307, 78, 0]) linear_extrude(height = th)
        projection(cut = true) rotate([90, 0, 0]) part_jup11();
    color("black") translate([307, 78, 0.01]) linear_extrude(height = th)
        outline2d(0.26) projection(cut = true) rotate([90, 0, 0]) part_jup11();
    color("black") translate([347, 66, 0]) linear_extrude(height = th) label("SECTION N-N", sz = 3.2, bold = true);
    color("black") translate([360, 55, 0]) linear_extrude(height = th) label("SCALE 1 : 1", sz = 2.9);

    // Key dimensions.
    color("black") {
        translate([45, 118, 0]) linear_extrude(height = th) label("R14.43", sz = 2.8);
        translate([45, 108, 0]) linear_extrude(height = th) label("R15.47", sz = 2.8);
        translate([101, 112, 0]) linear_extrude(height = th) label("\u230014.0", sz = 2.9);
        translate([152, 146, 0]) linear_extrude(height = th) label("17.6", sz = 2.9);
        translate([146, 112, 0]) linear_extrude(height = th) label("\u230014.0", sz = 2.8);
        translate([171, 112, 0]) linear_extrude(height = th) label("\u230014.30", sz = 2.8);
        translate([181, 102, 0]) linear_extrude(height = th) label("\u230013.0", sz = 2.8);
        translate([113, 146, 0]) linear_extrude(height = th) label("1.6", sz = 2.8);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw012_sheet9();
}
