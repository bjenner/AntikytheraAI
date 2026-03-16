// DRW-002 Sheet 2 recreation (parts list / exploded assembly).
// Uses existing b-series parts only.
// Working note: sheet-2 likely depends on a cross-drawing center shaft/core
// element, currently suspected to be `sun17`, even though it is not listed in
// the DRW-002 B-series parts table. Current visual stack reading is
// `b3 -> b7 (+ b8/b9) -> b10 -> b2 subassembly -> b1`, with the large wheel
// oriented so its toothed edge faces upward in the exploded view. The source
// drawing may also contain a `b9`/`b10` callout mix-up around the thin disc-like
// elements on the centerline.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b0_gear.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b1_main_wheel.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b2_gear_ring.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b3_gear.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b4_rivet_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b5_post.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b6_clip.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b7_hub.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b8_rivet_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b9_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b10_disc.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b11_carrier_block.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b12_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b13_roller.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b14_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b15_wire_link.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b16_rivet.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b17_standoff_pin.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b18_link_plate.scad>
use <drw002_b2_subassembly.scad>
use <drw002_b9_subassembly.scad>

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

module bronze() {
    color([0.45, 0.30, 0.18]) children();
}

module dark_metal() {
    color([0.22, 0.22, 0.22]) children();
}

module light_metal() {
    color([0.72, 0.72, 0.72]) children();
}

module roller_cluster() {
    rotate([0, 0, -18])
        drw002_b9_subassembly();
}

module drive_axis_exploded() {
    bronze()
        rotate([0, 90, 0]) translate([0, 0, 6.95]) part_b7();

    dark_metal()
        translate([-18, 0, 0]) rotate([0, 90, 0]) translate([0, 0, 3.1]) part_b8();

    dark_metal()
        translate([18, 0, 0]) rotate([0, 90, 0]) translate([0, 0, 1.75]) part_b9();

    bronze() {
        translate([34, 0, 0]) rotate([0, 90, 0]) part_b0();
        translate([47, 0, 0]) rotate([0, 90, 0]) translate([0, 0, -0.3]) part_b10();
        translate([56, 0, 0]) rotate([0, 90, 0]) drw002_b2_subassembly();
        translate([70, 0, 0]) rotate([0, 90, 0]) translate([0, 0, -0.3]) part_b10();
        translate([83, 0, 0]) rotate([0, 90, 0]) part_b3();
    }
}

module vertical_drive_stack() {
    b18_outer_holes = [
        [-58.5, -7.8],
        [-58.5, 7.8],
        [58.5, -7.8],
        [58.5, 7.8]
    ];

    // Leftmost in the current fit-check view, matching the large wheel at the
    // end of the centerline stack. Keep the toothed rim facing upward.
    bronze()
        translate([0, 0, 0]) rotate([0, -90, 0]) part_b0();

    bronze()
        translate([12, 0, 0]) rotate([0, 90, 0]) {
            part_b18();
            for (p = b18_outer_holes)
                translate([p[0], p[1], -15.7])
                    part_b5();
        }

    bronze()
        translate([34, 0, 0]) rotate([0, 90, 0]) part_b1();

    // b2 subassembly with its b4 rivets stays on the centerline.
    bronze()
        translate([58, 0, 0]) rotate([0, 90, 0]) drw002_b2_subassembly();

    // Drawing callout likely says b9 here in error; current interpretation is
    // that this centerline disc is b10.
    bronze()
        translate([71, 0, 0]) rotate([0, 90, 0]) translate([0, 0, -0.3]) part_b10();

    // b7 hub with its associated b8/b9 pins.
    bronze()
        translate([86, 0, 0]) rotate([0, 90, 0]) translate([0, 0, 6.95]) part_b7();
    dark_metal()
        translate([94, 0, 0]) rotate([0, 90, 0]) translate([0, 0, 3.1]) part_b8();
    dark_metal()
        translate([99, 0, 0]) rotate([0, 90, 0]) translate([0, 0, 1.75]) part_b9();

    // Placeholder only until sun17 is modeled/wired into this sheet.
    dark_metal()
        translate([113, 0, 0]) rotate([0, 90, 0]) cylinder(d = 5.3, h = 54.8, center = true, $fn = 42);

    bronze()
        translate([132, 0, 0]) rotate([0, 90, 0]) part_b3();
}

module post_cluster() {
    bronze()
        translate([45, -15, -2]) rotate([0, 22, 26]) part_b6();

    dark_metal() {
        translate([-10, 26, 0]) rotate([0, 90, 24]) part_b17();
        translate([10, 26, 2]) rotate([0, 90, 24]) part_b17();
        translate([30, 24, 5]) rotate([0, 90, 24]) part_b17();
        translate([50, 22, 8]) rotate([0, 90, 24]) part_b17();
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

    // Stage loose plate hardware up top while we solve the main fit.
    translate([296, 221, 16]) post_cluster();

    // Straight exploded drive stack with no presentation-angle twist yet.
    translate([232, 107, 16]) vertical_drive_stack();

    // Off-centerline items parked nearby while the main stack is verified.
    // Roller subsystem parked below the main stack for separate fit checking.
    translate([230, 32, 16]) rotate([0, 0, 0]) roller_cluster();

    // Spare b17 kept high and separate for now.
    dark_metal()
        translate([228, 214, 17]) rotate([0, 90, 0]) part_b17();

    // Temporary callouts for the fit-check layout.
    callout("b10", [299, 107], [338, 148], [382, 188]);
    callout("b9",  [327, 107], [334, 145], [382, 171]);
    callout("b8",  [322, 107], [327, 127], [382, 154]);
    callout("b7",  [314, 107], [320, 111], [382, 137]);
    callout("b0",  [232, 107], [345, 111], [382, 120]);
    callout("b1",  [262, 107], [336, 95],  [382, 103]);
    callout("b2",  [286, 107], [351, 88],  [382, 86]);
    callout("b3",  [360, 107], [360, 72],  [382, 69]);
    callout("b4",  [286, 117], [350, 56],  [382, 52]);

    color("black")
        linear_extrude(height = th) {
            line2d([235, 38], [214, 44], 0.22);
            translate([169, 48]) text("b9 sub assembly", size = 2.8, halign = "left", valign = "center");
        }

    callout("b5",  [320, 221], [307, 237], [268, 257]);
    callout("b6",  [341, 206], [331, 216], [252, 246]);
    callout("b17", [228, 214], [220, 246], [228, 258]);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet2();
}
