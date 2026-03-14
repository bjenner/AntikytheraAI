// DRW-008 Sheet 5 recreation (date pointer friction rings dat7 to dat8).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-008-Date/dat7_ring.scad>
use <../../parts/DRW-008-Date/dat8_ring.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp3_superior_plate.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp2_gear_axle_subassembly.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/spp17_date_pointer_base.scad>
use <../../parts/DRW-005-Common-Parts/cp3_rivet.scad>

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

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center", font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module date_pointer_bar_2d(len = 98, arm_w = 3.4, hub_od = 16, hub_id = 9, end_d = 4.2) {
    difference() {
        union() {
            hull() {
                translate([-len / 2, 0]) circle(d = end_d, $fn = 40);
                translate([0, 0]) circle(d = arm_w, $fn = 40);
            }
            hull() {
                translate([len / 2, 0]) circle(d = end_d, $fn = 40);
                translate([0, 0]) circle(d = arm_w, $fn = 40);
            }
            difference() {
                circle(d = hub_od, $fn = 60);
                circle(d = hub_id, $fn = 60);
            }
        }
        translate([0, 0, 0]) circle(d = hub_id, $fn = 60);
    }
}

module dat_stack_3d() {
    color([0.43, 0.29, 0.18]) part_dat7();
    color([0.40, 0.27, 0.16]) translate([0, 0, 2.05]) part_dat8();
    color([0.20, 0.20, 0.20]) for (i = [0 : 3]) {
        a = i * 90;
        translate([(17 / 2) * cos(a), (17 / 2) * sin(a), 0.05]) part_cp3();
    }
}

module date_pointer_subassembly_3d() {
    color([0.46, 0.31, 0.18])
    linear_extrude(height = 1.2) date_pointer_bar_2d();

    color([0.43, 0.29, 0.18])
    translate([0, 0, 0.3]) part_dat7();

    color([0.38, 0.25, 0.15])
    translate([0, 0, 2.35]) part_dat8();

    color([0.18, 0.18, 0.18]) {
        translate([-49, 0, 1.2]) part_cp3();
        translate([49, 0, 1.2]) part_cp3();
    }

    color([0.15, 0.35, 0.90]) {
        translate([-49, 0, 5.4]) sphere(d = 4.1, $fn = 20);
        translate([49, 0, 5.4]) sphere(d = 4.1, $fn = 20);
    }
}

module drw008_sheet5() {
    W = 420;
    H = 297;
    B = 8;
    th = 0.12;

    // Border.
    color("black")
    linear_extrude(height = th)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W - 2 * B, H - 2 * B], center = false);
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Date      (dat7 to dat8)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 5 OF 5", sz = 2.9);

    // Top-left: dat7 and dat8 isometric parts.
    color([0.43, 0.29, 0.18])
    translate([52, 255, 16]) rotate([68, 0, 18]) scale([2.0, 2.0, 2.0]) part_dat7();
    color("black") translate([74, 266, 0]) linear_extrude(height = th) label("dat7", sz = 3.1, bold = true);

    color([0.43, 0.29, 0.18])
    translate([152, 255, 16]) rotate([68, 0, 20]) scale([1.8, 1.8, 1.8]) part_dat8();
    color("black") translate([184, 266, 0]) linear_extrude(height = th) label("dat8", sz = 3.1, bold = true);

    // Left-mid: 2D reference views.
    color([0.92, 0.92, 0.92]) translate([58, 184, 0]) linear_extrude(height = th) projection(cut = true) part_dat7();
    color("black") translate([58, 184, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_dat7();
    color("black") translate([104, 212, 0]) linear_extrude(height = th) label("\u230028.5", sz = 3.0);
    color("black") translate([101, 200, 0]) linear_extrude(height = th) label("\u230018.5", sz = 3.0);

    color([0.92, 0.92, 0.92]) translate([150, 184, 0]) linear_extrude(height = th) projection(cut = true) part_dat8();
    color("black") translate([150, 184, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) part_dat8();
    color("black") translate([188, 212, 0]) linear_extrude(height = th) label("\u230024.5", sz = 3.0);
    color("black") translate([188, 200, 0]) linear_extrude(height = th) label("\u230022.5", sz = 3.0);

    // Bottom-left: date pointer base subassembly.
    translate([86, 84, 12]) rotate([70, 0, 0]) scale([1.18, 1.18, 1.18]) date_pointer_subassembly_3d();
    color("black") translate([53, 63, 0]) linear_extrude(height = th) label("Date Pointer Base Sub Assembly", sz = 3.0);
    color("black") translate([98, 108, 0]) linear_extrude(height = th) label("cp3 x 4 rivet between dat7 and dat8", sz = 2.8);

    // Top-right: context assembly on superior plate.
    color([0.44, 0.30, 0.18])
    translate([326, 208, 12]) rotate([70, 0, 18]) scale([0.82, 0.82, 0.82]) part_sp3();

    translate([326, 208, 13.8]) rotate([70, 0, 18]) scale([0.82, 0.82, 0.82]) dat_stack_3d();

    color([0.46, 0.31, 0.18])
    translate([326, 208, 15.2]) rotate([70, 0, 18])
    linear_extrude(height = 0.9) scale([0.58, 0.58, 1]) date_pointer_bar_2d();

    color([0.40, 0.30, 0.20])
    translate([326, 208, 12.9]) rotate([70, 0, 18]) scale([0.72, 0.72, 0.72]) part_sp2();

    // Section E-E stylized view from projection of the stack.
    color([0.93, 0.93, 0.93])
    translate([267, 111, 0]) linear_extrude(height = th)
    projection(cut = true)
    rotate([90, 0, 0])
    scale([1.35, 1.35, 1.35]) dat_stack_3d();

    color("black")
    translate([267, 111, 0.01]) linear_extrude(height = th)
    outline2d(0.30)
    projection(cut = true)
    rotate([90, 0, 0])
    scale([1.35, 1.35, 1.35]) dat_stack_3d();

    color("black") translate([255, 76, 0]) linear_extrude(height = th) label("SECTION E-E", sz = 5.2, bold = true);
    color("black") translate([261, 64, 0]) linear_extrude(height = th) label("SCALE 1:2", sz = 4.6, bold = true);

    color("black") translate([247, 154, 0]) linear_extrude(height = th)
        label("Fit sp2 between Superior plant plate and date pointer.", sz = 2.9);
    color("black") translate([247, 148, 0]) linear_extrude(height = th)
        label("Solder date Pointer to date axle for minimum clearance rotating fit.", sz = 2.9);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw008_sheet5();
}
