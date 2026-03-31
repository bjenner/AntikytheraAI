// DRW-001 Sheet 2 recreation (parts list / exploded positioning).
// Uses existing part modules only.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-001-A-Assembly/a1.scad>
use <../../parts/DRW-001-A-Assembly/a2_ring.scad>
use <../../parts/DRW-001-A-Assembly/a3_pin.scad>
use <../../parts/DRW-001-A-Assembly/a4_block.scad>
use <../../parts/DRW-001-A-Assembly/a5_ring.scad>
use <../../parts/DRW-001-A-Assembly/a6_bush.scad>
use <../../parts/DRW-001-A-Assembly/a7_block.scad>
use <../../parts/DRW-001-A-Assembly/a8_rivet_pin.scad>
use <../../parts/DRW-001-A-Assembly/a9_axle.scad>
use <../../parts/DRW-001-A-Assembly/a10_disc.scad>
use <../../parts/DRW-001-A-Assembly/a12_link.scad>
use <../../parts/DRW-005-Common-Parts/cpr5_rivet.scad>
use <../../parts/DRW-005-Common-Parts/cpf5_fork.scad>
use <../../parts/DRW-005-Common-Parts/cpf6_fork.scad>

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

        // Rows use the project interpretation, not the known Sheet 2 source mislabel.
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
            ["a12","1","a12 link.ipt","Bronze"],
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

    // Exploded horizontal arrangement (tuned to match sheet reference layout).
    // Left anchor: a10 disc.
    color([0.45, 0.30, 0.18]) translate([54, 62, 18]) rotate([90, 0, 90]) scale([1.05, 1.05, 1.05]) part_a10();
    // a9 axle + a8 pin.
    color([0.52, 0.43, 0.34]) translate([112, 136, 18]) rotate([0, 90, 0]) part_a9();
    color([0.25, 0.25, 0.25]) translate([129, 136, 19]) rotate([90, 0, 0]) part_a8();
    // Mid-chain parts.
    color([0.45, 0.30, 0.18]) translate([170, 128, 18]) part_a7();
    color([0.45, 0.30, 0.18]) translate([154, 126, 18]) rotate([90, 0, 24]) part_cpf5();
    color([0.45, 0.30, 0.18]) translate([186, 126, 18]) rotate([90, 0, -18]) part_cpf6();
    color([0.38, 0.30, 0.22]) translate([204, 136, 18]) rotate([0, 90, 0]) part_a6();
    color([0.28, 0.23, 0.20]) translate([222, 136, 18]) rotate([0, 90, 0]) part_a5();
    color([0.45, 0.30, 0.18]) translate([241, 128, 18]) part_a4();
    // Right chain: a3/a2/a1.
    color([0.55, 0.46, 0.40]) translate([259, 136, 18]) rotate([0, 90, 0]) part_a3();
    color([0.28, 0.23, 0.20]) translate([274, 136, 18]) rotate([0, 90, 0]) part_a2();
    color([0.45, 0.30, 0.18]) translate([292, 136, 18]) rotate([0, 90, 0]) part_a1(body_d = 30, thickness = 2, bore_d = 4, spoke_count = 0);
    // Remaining listed hardware parts (lower callouts).
    color([0.30, 0.24, 0.20]) translate([219, 92, 18]) rotate([90, 0, -12]) part_a12();
    color([0.38, 0.30, 0.22]) translate([201, 88, 18]) rotate([90, 0, 0]) part_cpr5();

    // Callouts (IDs visible in source sheet).
    callout("a10", [54, 98], [62, 182], [62, 233]);
    callout("a9", [112, 136], [110, 184], [84, 233]);
    callout("a8", [129, 136], [129, 178], [106, 233]);
    callout("cp-f5", [154, 126], [150, 176], [126, 230]);
    callout("a7", [170, 128], [166, 178], [146, 230]);
    callout("cp-f6", [186, 126], [182, 182], [166, 230]);
    callout("a6", [204, 136], [202, 186], [186, 230]);
    callout("a5", [222, 136], [221, 186], [206, 230]);
    callout("a4", [241, 128], [240, 188], [226, 230]);
    callout("a3", [259, 136], [259, 188], [246, 230]);
    callout("a2", [274, 136], [274, 186], [266, 230]);
    callout("a1", [292, 136], [294, 185], [286, 230]);
    callout("cp-r5", [201, 88], [198, 74], [194, 60]);
    callout("a12", [219, 92], [230, 73], [232, 60]);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet2();
}
