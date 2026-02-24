// DRW-001 Sheet 2 recreation (parts list / exploded positioning).
// Uses existing part modules only.
// SPDX-License-Identifier: MIT

use <../parts/a1.scad>
use <../parts/a2_ring.scad>
use <../parts/a3_pin.scad>
use <../parts/a4_block.scad>
use <../parts/a5_ring.scad>
use <../parts/a6_bush.scad>
use <../parts/a7_block.scad>
use <../parts/a8_rivet_pin.scad>
use <../parts/a9_axle.scad>
use <../parts/a10_disc.scad>
use <../parts/a12_link.scad>

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

module callout(tag = "a1", anchor = [0, 0], p1 = [0, 0], p2 = [0, 0]) {
    color("black")
    linear_extrude(height = 0.12) {
        line2d(anchor, p1, 0.22);
        line2d(p1, p2, 0.22);
        translate(p2) outline2d(0.3) circle(d = 9.2, $fn = 42);
        translate([p2[0] - 3.8, p2[1]]) text(tag, size = 2.8, halign = "left", valign = "center");
    }
}

module parts_table(x = 290, y = 185) {
    // Simplified table matching source layout.
    w = 122;
    h = 108;
    color("black")
    linear_extrude(height = 0.12) {
        outline2d(0.35) translate([x, y]) square([w, h], center = false);
        // Horizontal rows.
        for (r = [10, 17, 24, 31, 38, 45, 52, 59, 66, 73, 80, 87, 94, 101]) {
            line2d([x, y + r], [x + w, y + r], 0.2);
        }
        // Columns.
        line2d([x + 18, y], [x + 18, y + h], 0.2);
        line2d([x + 36, y], [x + 36, y + h], 0.2);
        line2d([x + 96, y], [x + 96, y + h], 0.2);

        translate([x + 62, y + 104]) text("PARTS LIST", size = 3.6, halign = "center");
        translate([x + 2,  y + 96]) text("ITEM", size = 2.6);
        translate([x + 20, y + 96]) text("QTY", size = 2.6);
        translate([x + 38, y + 96]) text("FILE NAME", size = 2.6);
        translate([x + 98, y + 96]) text("MATERIAL", size = 2.6);

        // Rows (abbreviated same IDs as source).
        items = [
            ["a1","1","a1 cut.ipt","Bronze"],
            ["a2","1","a1 Gear washer.ipt","Bronze"],
            ["a3","1","a1 Axle Gear.ipt","Bronze"],
            ["a4","1","a1 Axle Mount Inter.ipt","Bronze"],
            ["a5","1","a1 Axle washer.ipt","Bronze"],
            ["a6","1","a1 Axle Tube.ipt","Bronze"],
            ["a7","1","a1 Axle Mount Outer.ipt","Bronze"],
            ["a8","1","a1 handle pin.ipt","Bronze"],
            ["a9","1","a1 Axle.ipt","Bronze"],
            ["a10","1","a1 crank inner.ipt","Bronze"],
            ["a11","1","b1 Gear Lock.ipt","Bronze"],
            ["cp-r5","1","CP Rivet 3D 3.6L.ipt","Bronze"],
            ["cp-f5","1","CP Fork 3W 12D 17L 12T.ipt","Bronze"],
            ["cp-f6","1","CP Fork 3W 10D 6L 10T.ipt","Bronze"]
        ];

        for (i = [0 : len(items) - 1]) {
            yy = y + 89 - i * 7;
            translate([x + 1.5, yy]) text(items[i][0], size = 2.35);
            translate([x + 22,  yy]) text(items[i][1], size = 2.35);
            translate([x + 38,  yy]) text(items[i][2], size = 2.35);
            translate([x + 98,  yy]) text(items[i][3], size = 2.35);
        }
    }
}

module drw001_sheet2() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (parts list)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 2 OF 7", sz = 2.9);

    // Parts list table.
    parts_table(290, 185);

    // Exploded horizontal arrangement (existing parts only).
    // a10 disc on left.
    color([0.45, 0.30, 0.18]) translate([55, 62, 18]) rotate([90, 0, 90]) scale([1.1, 1.1, 1.1]) part_a10();
    // a9 axle.
    color([0.52, 0.43, 0.34]) translate([102, 136, 18]) rotate([0, 90, 0]) part_a9();
    // a8 pin near a9.
    color([0.25, 0.25, 0.25]) translate([117, 136, 19]) rotate([90, 0, 0]) part_a8();
    // a7 + a6 + a5 + a4 + a3 + a2 + a1 cluster.
    color([0.45, 0.30, 0.18]) translate([158, 128, 18]) rotate([0, 0, 0]) part_a7();
    color([0.38, 0.30, 0.22]) translate([178, 136, 18]) rotate([0, 90, 0]) part_a6();
    color([0.28, 0.23, 0.20]) translate([194, 136, 18]) rotate([0, 90, 0]) part_a5();
    color([0.45, 0.30, 0.18]) translate([214, 128, 18]) part_a4();
    color([0.55, 0.46, 0.40]) translate([234, 136, 18]) rotate([0, 90, 0]) part_a3();
    color([0.28, 0.23, 0.20]) translate([246, 136, 18]) rotate([0, 90, 0]) part_a2();
    color([0.45, 0.30, 0.18]) translate([260, 136, 18]) rotate([0, 90, 0]) part_a1(body_d = 30, thickness = 2, bore_d = 4, spoke_count = 0);
    // a11 approximation with existing link.
    color([0.30, 0.24, 0.20]) translate([207, 94, 18]) rotate([0, 0, -8]) part_a12();

    // Callouts (IDs visible in source sheet).
    callout("a10", [55, 98], [66, 182], [68, 233]);
    callout("a9", [103, 136], [103, 184], [87, 233]);
    callout("a8", [117, 136], [117, 178], [107, 233]);
    callout("a7", [158, 128], [149, 178], [127, 230]);
    callout("cp-f6", [171, 126], [162, 182], [143, 230]);
    callout("a6", [178, 136], [176, 187], [159, 230]);
    callout("a5", [194, 136], [193, 186], [175, 230]);
    callout("a4", [214, 128], [214, 188], [196, 230]);
    callout("a3", [234, 136], [234, 188], [212, 230]);
    callout("a2", [246, 136], [246, 186], [230, 230]);
    callout("a1", [260, 136], [262, 185], [249, 230]);
    callout("cp-r5", [209, 93], [201, 74], [194, 60]);
    callout("a11", [214, 92], [226, 73], [232, 60]);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet2();
}
