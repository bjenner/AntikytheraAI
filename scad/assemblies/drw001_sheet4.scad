// DRW-001 Sheet 4 recreation (drawing-only, no 3D part modules).
// SPDX-License-Identifier: MIT

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

module toothed_disc_2d(root_r = 12, tip_r = 14, teeth = 48, hole_r = 2.2) {
    difference() {
        union() {
            circle(r = root_r, $fn = 96);
            for (a = [0 : 360 / teeth : 360 - 360 / teeth]) {
                rotate(a) translate([root_r, 0]) square([tip_r - root_r, 0.8], center = true);
            }
        }
        circle(r = hole_r, $fn = 36);
    }
}

module hatch_rect(x = 0, y = 0, w = 40, h = 20, step = 4) {
    translate([x, y]) {
        difference() {
            square([w, h], center = false);
            for (i = [-h : step : w + h]) {
                translate([i, -2]) rotate(45) square([1.0, h + w], center = false);
            }
        }
    }
}

module drw001_sheet4() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   a      (a1 axle gear clearance)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 4 OF 7", sz = 2.9);

    // Top clearance view (large circle + small centered mechanism sketch).
    color("black")
    linear_extrude(height = th) {
        translate([136, 217]) outline2d(0.35) circle(d = 118, $fn = 180);
        translate([136, 217]) {
            outline2d(0.35) toothed_disc_2d();
            translate([-9, 14]) outline2d(0.3) square([18, 12], center = true);
            translate([0, -16]) outline2d(0.3) square([16, 8], center = true);
        }
    }

    // Front view with centerline and A-A arrows.
    color("black")
    linear_extrude(height = th) {
        translate([136, 58]) outline2d(0.35) square([116, 2.8], center = true);         // base plate
        translate([136, 89]) outline2d(0.35) square([10, 56], center = true);           // axle post
        translate([136, 118]) outline2d(0.35) circle(d = 15, $fn = 64);                 // collar
        translate([136, 132]) outline2d(0.35) square([20, 10], center = true);          // upper support
        translate([136, 138]) outline2d(0.35) toothed_disc_2d(root_r = 11, tip_r = 12.8, teeth = 42, hole_r = 2.0);

        // A-A centerline and arrows.
        line2d([136, 58], [136, 138], 0.25);
        line2d([136, 58], [136, 43], 0.25);
        line2d([124, 136], [136, 136], 0.25);
        polygon([[124, 136], [128, 137.4], [128, 134.6]]);
        line2d([136, 58], [124, 58], 0.25);
        polygon([[124, 58], [128, 59.4], [128, 56.6]]);
        translate([128, 142]) text("A", size = 7, halign = "center");
        translate([128, 48]) text("A", size = 7, halign = "center");
    }

    // Section A-A view (hatched).
    color("black")
    linear_extrude(height = th) {
        // base hatched strip
        hatch_rect(x = 212, y = 58, w = 142, h = 2.8, step = 4);
        outline2d(0.35) translate([212, 58]) square([142, 2.8], center = false);

        // vertical shaft hatched
        hatch_rect(x = 262, y = 58, w = 10, h = 56, step = 4);
        outline2d(0.35) translate([262, 58]) square([10, 56], center = false);

        // top sectioned mechanical block
        hatch_rect(x = 250, y = 114, w = 34, h = 16, step = 4);
        outline2d(0.35) translate([250, 114]) square([34, 16], center = false);
        outline2d(0.35) translate([267, 122]) circle(d = 5, $fn = 30);

        // dimension snippets
        line2d([246, 140], [286, 140], 0.24);
        line2d([246, 137], [246, 143], 0.24);
        line2d([286, 137], [286, 143], 0.24);
        translate([264, 144]) text(".10", size = 2.8, halign = "center");

        line2d([292, 113], [292, 130], 0.24);
        line2d([289, 113], [295, 113], 0.24);
        line2d([289, 130], [295, 130], 0.24);
        translate([296, 121]) rotate(90) text(".20", size = 2.8, halign = "center");
    }

    color("black") translate([248, 47, 0]) linear_extrude(height = th) text("SECTION A-A", size = 7, halign = "left");
    color("black") translate([248, 38, 0]) linear_extrude(height = th) text("SCALE 1 : 1", size = 7, halign = "left");
}

