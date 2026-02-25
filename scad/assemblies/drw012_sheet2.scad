// DRW-012 Sheet 2 recreation (Jupiter parts list assembly view).
// Uses existing modeled parts; stand-ins are marked in comments.
// SPDX-License-Identifier: MIT

use <../parts/jup1_gear.scad>
use <../parts/jup2_gear.scad>
use <../parts/jup3_gear.scad>
use <../parts/jup4_gear.scad>
use <../parts/jup5_gear.scad>
use <../parts/jup7_hub.scad>
use <../parts/jup8_spacer.scad>
use <../parts/jup9_rivet_pin.scad>
use <../parts/jup10_hub.scad>
use <../parts/jup11_sleeve.scad>
use <../parts/jup13_pointer_arm.scad>
use <../parts/jup14_orb_large.scad>
use <../parts/jup15_orb_rod_large.scad>
use <../parts/jup16_orb_small.scad>
use <../parts/jup17_orb_rod_small.scad>
use <../parts/jup18_pointer_ring_outer.scad>
use <../parts/sp1_superior_gear.scad>
use <../parts/sp2_gear_axle_subassembly.scad>
use <../parts/cp3_rivet.scad>
use <../parts/cp9_pin.scad>
use <../parts/cpf3_fork.scad>
use <../parts/cpf6_fork.scad>

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

module jupiter_pointer_set() {
    // jup13 + rings + rods + orbs.
    color([0.42, 0.30, 0.18]) part_jup13();
    color([0.34, 0.27, 0.23]) translate([0, 0, 1.0]) part_jup18();
    color([0.40, 0.30, 0.22]) {
        translate([-51.5, 0, 1.0]) part_jup15();
        translate([51.5, 0, 1.0]) part_jup17();
    }
    color([0.82, 0.82, 0.84]) {
        translate([-51.5, 0, 16.0]) part_jup14();
        translate([51.5, 0, 16.0]) part_jup16();
    }
}

module jupiter_gear_stack() {
    color([0.42, 0.30, 0.18]) translate([0, 0, 0.0]) part_jup1();
    color([0.42, 0.30, 0.18]) translate([0, 0, 2.0]) part_jup2();
    color([0.42, 0.30, 0.18]) translate([0, 0, 3.6]) part_jup3();
    color([0.42, 0.30, 0.18]) translate([0, 0, 5.2]) part_jup4();
    color([0.42, 0.30, 0.18]) translate([0, 0, 6.8]) part_jup5();
    color([0.34, 0.30, 0.27]) translate([0, 0, 8.4]) part_jup10();
    color([0.34, 0.30, 0.27]) translate([0, 0, 13.0]) part_jup11();
    color([0.38, 0.30, 0.24]) translate([2.8, -1.2, 5.6]) rotate([0, 0, -28]) part_cpf6();
}

module drw012_sheet2() {
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

    // Right-side parts list panel.
    color("black")
    linear_extrude(height = th) {
        outline2d(0.35) translate([285, 20]) square([127, 245], center = false);
        for (y = [30 : 8 : 257]) line2d([285, y], [412, y], 0.2);
        line2d([295, 20], [295, 265], 0.2);
        line2d([312, 20], [312, 265], 0.2);
    }
    color("black") translate([319, 262, 0]) linear_extrude(height = th) label("PARTS LIST", sz = 3.1, bold = true);

    // Key exploded scene.
    color([0.43, 0.30, 0.18]) translate([116, 120, 4]) rotate([73, 0, 18]) scale([2.1, 2.1, 2.1]) part_sp1();
    color([0.36, 0.31, 0.27]) translate([118, 146, 4]) rotate([73, 0, 18]) scale([2.0, 2.0, 2.0]) part_sp2();

    translate([123, 178, 0]) rotate([70, 0, 11]) scale([0.95, 0.95, 0.95]) jupiter_pointer_set();

    translate([130, 26, 0]) rotate([70, 0, 22]) scale([1.1, 1.1, 1.1]) jupiter_gear_stack();

    // Lower-left loose components cluster.
    color([0.36, 0.31, 0.27]) translate([72, 35, 6]) rotate([70, 0, 14]) scale([1.25, 1.25, 1.25]) part_jup10();
    color([0.34, 0.30, 0.27]) translate([93, 30, 6]) rotate([70, 0, 18]) scale([1.15, 1.15, 1.15]) part_jup8();
    color([0.34, 0.30, 0.27]) translate([56, 28, 6]) rotate([70, 0, 16]) scale([1.2, 1.2, 1.2]) part_jup7();
    color([0.42, 0.30, 0.18]) translate([92, 50, 6]) rotate([70, 0, 20]) scale([1.8, 1.8, 1.8]) part_jup4();
    color([0.42, 0.30, 0.18]) translate([55, 52, 6]) rotate([70, 0, 22]) scale([1.5, 1.5, 1.5]) part_jup2();
    color([0.38, 0.30, 0.24]) translate([42, 58, 6]) rotate([70, 0, -35]) scale([1.3, 1.3, 1.3]) part_cpf3();
    color([0.38, 0.30, 0.24]) translate([76, 60, 6]) rotate([70, 0, -28]) scale([1.3, 1.3, 1.3]) part_cpf6();
    color([0.34, 0.30, 0.27]) translate([38, 74, 6]) rotate([90, 0, 0]) part_cp9();
    color([0.34, 0.30, 0.27]) translate([44, 72, 6]) rotate([90, 0, 0]) part_cp9();
    color([0.34, 0.30, 0.27]) translate([50, 70, 6]) rotate([90, 0, 0]) part_jup9();

    // Simple callouts matching the source intent.
    color("black") {
        translate([16, 102, 0]) linear_extrude(height = th) label("sp1", sz = 2.8);
        translate([28, 102, 0]) linear_extrude(height = th) line2d([0, 0], [46, 28], 0.22);

        translate([182, 70, 0]) linear_extrude(height = th) label("sp2", sz = 2.8);
        translate([194, 70, 0]) linear_extrude(height = th) line2d([0, 0], [-58, 66], 0.22);

        translate([196, 250, 0]) linear_extrude(height = th) label("jup12", sz = 2.6); // stand-in not yet modeled
        translate([196, 241, 0]) linear_extrude(height = th) label("jup13", sz = 2.6);
        translate([196, 232, 0]) linear_extrude(height = th) label("jup14", sz = 2.6);
        translate([196, 223, 0]) linear_extrude(height = th) label("jup15", sz = 2.6);
        translate([196, 214, 0]) linear_extrude(height = th) label("jup16", sz = 2.6);
        translate([196, 205, 0]) linear_extrude(height = th) label("jup17", sz = 2.6);
        translate([196, 196, 0]) linear_extrude(height = th) label("jup18", sz = 2.6);

        translate([14, 18, 0]) linear_extrude(height = th) label("jup11", sz = 2.6);
        translate([36, 18, 0]) linear_extrude(height = th) label("jup10", sz = 2.6);
        translate([58, 18, 0]) linear_extrude(height = th) label("jup9", sz = 2.6);
        translate([78, 18, 0]) linear_extrude(height = th) label("jup8", sz = 2.6);
        translate([98, 18, 0]) linear_extrude(height = th) label("jup7", sz = 2.6);
        translate([118, 18, 0]) linear_extrude(height = th) label("jup6", sz = 2.6); // stand-in not yet modeled
        translate([138, 18, 0]) linear_extrude(height = th) label("jup5", sz = 2.6);
        translate([158, 18, 0]) linear_extrude(height = th) label("jup4", sz = 2.6);
        translate([178, 18, 0]) linear_extrude(height = th) label("jup3", sz = 2.6);
        translate([198, 18, 0]) linear_extrude(height = th) label("jup2", sz = 2.6);
        translate([218, 18, 0]) linear_extrude(height = th) label("jup1", sz = 2.6);
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Jupiter   (parts list)", sz = 2.9);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 2 OF 9", sz = 2.9);
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw012_sheet2();
}
