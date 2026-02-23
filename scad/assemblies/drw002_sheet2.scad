// DRW-002 Sheet 2 recreation (parts list / exploded assembly).
// Uses existing b-series parts only.
// SPDX-License-Identifier: MIT

use <../parts/b0_gear.scad>
use <../parts/b1_main_wheel.scad>
use <../parts/b2_gear_ring.scad>
use <../parts/b3_gear.scad>
use <../parts/b4_rivet_pin.scad>
use <../parts/b5_post.scad>
use <../parts/b6_clip.scad>
use <../parts/b7_hub.scad>
use <../parts/b8_rivet_pin.scad>
use <../parts/b9_pin.scad>
use <../parts/b10_disc.scad>
use <../parts/b11_carrier_block.scad>
use <../parts/b12_pin.scad>
use <../parts/b13_roller.scad>
use <../parts/b14_pin.scad>
use <../parts/b15_wire_link.scad>
use <../parts/b16_rivet.scad>
use <../parts/b17_standoff_pin.scad>
use <../parts/b18_link_plate.scad>

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

module callout(tag, anchor = [0, 0], p1 = [0, 0], p2 = [0, 0]) {
    color("black")
    linear_extrude(height = 0.12) {
        line2d(anchor, p1, 0.22);
        line2d(p1, p2, 0.22);
        translate(p2) outline2d(0.3) circle(d = 9.2, $fn = 42);
        translate([p2[0] - 3.7, p2[1]]) text(tag, size = 2.8, halign = "left", valign = "center");
    }
}

module parts_table_b2(x = 8, y = 122) {
    w = 132;
    h = 167;
    color("black")
    linear_extrude(height = 0.12) {
        outline2d(0.35) translate([x, y]) square([w, h], center = false);
        // Rows (22).
        for (r = [10 : 7 : 160]) line2d([x, y + r], [x + w, y + r], 0.2);
        // Cols.
        line2d([x + 18, y], [x + 18, y + h], 0.2);
        line2d([x + 36, y], [x + 36, y + h], 0.2);
        line2d([x + 107, y], [x + 107, y + h], 0.2);

        translate([x + 66, y + 163]) text("PARTS LIST", size = 3.4, halign = "center");
        translate([x + 2, y + 153]) text("ITEM", size = 2.5);
        translate([x + 20, y + 153]) text("QTY", size = 2.5);
        translate([x + 38, y + 153]) text("FILE NAME", size = 2.5);
        translate([x + 109, y + 153]) text("MATERIAL", size = 2.5);

        items = [
            ["b0","1","b0 Gear 20T cut.ipt","Bronze"],
            ["b1","1","b1 cut.ipt","Bronze"],
            ["b2","1","b2 Gear 64T.ipt","Bronze"],
            ["b3","1","b3 Gear 32T.ipt","Bronze"],
            ["b4","4","b2 pin.ipt","Bronze"],
            ["b5","4","b1 Superior Plate Post.ipt","Bronze"],
            ["b6","1","Node post.ipt","Bronze"],
            ["b7","1","b1 axle.ipt","Bronze"],
            ["b8","1","b1 axle pin outer.ipt","Bronze"],
            ["b9","1","b1 axle bush bearing top.ipt","Bronze"],
            ["b10","2","b1 axle pin inner.ipt","Bronze"],
            ["b11","1","b1 Roller Body.ipt","Bronze"],
            ["b12","2","b1 Roller guide.ipt","Bronze"],
            ["b13","1","b1 Roller.ipt","Bronze"],
            ["b14","1","b1 Roller axle bush bearing.ipt","PTFE"],
            ["b15","1","b1 Roller Pin.ipt","Spring SS"],
            ["b16","1","b1 Roller axle rivet.ipt","Bronze"],
            ["b17","4","b1 Plate Post.ipt","Bronze"],
            ["b18","1","b1 Plate.ipt","Bronze"],
            ["cp-f1","4","CP Fork 1.5W 3D 5L 6T.ipt","Bronze"],
            ["cp-f2","6","CP Fork 2W 4D 6L 7T.ipt","Bronze"],
            ["cp-f6","1","CP Fork 3W 10D 6L 10T.ipt","Bronze"]
        ];

        for (i = [0 : len(items) - 1]) {
            yy = y + 146 - i * 7;
            translate([x + 1.2, yy]) text(items[i][0], size = 2.2);
            translate([x + 22, yy]) text(items[i][1], size = 2.2);
            translate([x + 38, yy]) text(items[i][2], size = 2.2);
            translate([x + 109, yy]) text(items[i][3], size = 2.2);
        }

        translate([x + 22, y + 6.5]) text("41", size = 2.2);
        translate([x + 38, y + 6.5]) text("Total parts to manufacture", size = 2.2);
    }
}

module drw002_sheet2() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (parts list)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 2 OF 10", sz = 2.9);

    // Parts table on left.
    parts_table_b2();

    // Exploded cluster (existing parts only).
    translate([250, 102, 16]) rotate([75, 0, 28]) scale([1.08, 1.08, 1.08]) part_b1();
    translate([272, 112, 18]) rotate([75, 0, 28]) scale([1.02, 1.02, 1.02]) part_b18();

    // Main axle group.
    color([0.50, 0.42, 0.34]) translate([299, 77, 18]) rotate([12, 78, -28]) part_b7();
    color([0.18, 0.18, 0.18]) translate([292, 84, 18]) rotate([10, 78, -28]) part_b8();
    color([0.18, 0.18, 0.18]) translate([306, 68, 18]) rotate([10, 78, -28]) part_b9();

    // Gear stack.
    color([0.45, 0.30, 0.18]) translate([320, 107, 17]) rotate([76, 0, 29]) part_b0();
    color([0.45, 0.30, 0.18]) translate([334, 92, 17]) rotate([76, 0, 29]) part_b2();
    color([0.45, 0.30, 0.18]) translate([345, 76, 17]) rotate([76, 0, 29]) part_b3();

    // Posts and standoffs.
    color([0.45, 0.30, 0.18]) translate([216, 183, 17]) rotate([18, 0, 18]) part_b5();
    color([0.45, 0.30, 0.18]) translate([250, 60, 17]) rotate([18, 0, 18]) part_b5();
    color([0.45, 0.30, 0.18]) translate([358, 228, 17]) rotate([18, 0, 18]) part_b5();
    color([0.45, 0.30, 0.18]) translate([342, 168, 17]) rotate([18, 0, 18]) part_b6();

    // Roller subsystem at bottom-middle.
    color([0.40, 0.29, 0.19]) translate([241, 52, 16]) rotate([18, -2, -25]) part_b11();
    color([0.45, 0.30, 0.18]) translate([254, 50, 17]) rotate([8, 85, -20]) part_b12();
    color([0.35, 0.25, 0.18]) translate([265, 52, 17]) rotate([8, 85, -20]) part_b13();
    color([0.75, 0.75, 0.75]) translate([274, 51, 17]) rotate([8, 85, -20]) part_b14();
    color([0.75, 0.75, 0.75]) translate([282, 48, 17]) rotate([0, 70, -20]) part_b15();
    color([0.25, 0.25, 0.25]) translate([290, 44, 17]) rotate([8, 85, -20]) part_b16();

    // Rivet and link parts.
    color([0.25, 0.25, 0.25]) translate([222, 126, 17]) rotate([90, 0, 20]) part_b17();
    color([0.25, 0.25, 0.25]) translate([198, 92, 17]) rotate([90, 0, 20]) part_b17();
    color([0.25, 0.25, 0.25]) translate([233, 160, 17]) rotate([90, 0, 20]) part_b17();
    color([0.25, 0.25, 0.25]) translate([346, 124, 17]) rotate([90, 0, 20]) part_b4();

    // A few sheet-like callouts around right side.
    callout("b10", [323, 107], [353, 140], [378, 188]);
    callout("b9",  [306, 68],  [347, 132], [378, 171]);
    callout("b8",  [292, 84],  [341, 122], [378, 154]);
    callout("b7",  [299, 77],  [334, 112], [378, 137]);
    callout("b0",  [320, 107], [340, 98],  [378, 120]);
    callout("b1",  [250, 101], [330, 88],  [378, 103]);
    callout("b2",  [334, 92],  [350, 80],  [378, 86]);
    callout("b3",  [345, 76],  [355, 66],  [378, 69]);
    callout("b4",  [346, 124], [359, 53],  [378, 52]);

    callout("b11", [241, 52], [226, 43], [168, 48]);
    callout("b12", [254, 50], [248, 39], [185, 44]);
    callout("b13", [265, 52], [264, 33], [202, 43]);
    callout("b14", [274, 51], [281, 34], [220, 45]);
    callout("b15", [282, 48], [300, 37], [238, 46]);
    callout("b16", [290, 44], [316, 33], [256, 45]);

    callout("b5", [358, 228], [334, 242], [268, 257]);
    callout("b6", [342, 168], [329, 201], [252, 246]);
    callout("b17", [222, 126], [206, 252], [228, 258]);
}
