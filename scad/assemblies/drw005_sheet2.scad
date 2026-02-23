// DRW-005 Sheet 2 recreation (Common Parts cp-r1 to cp-r6).
// Scene-first implementation with local modules.
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

module rivet_local(shank_d = 3.0, shank_h = 2.0, head_d = 5.0, head_h = 1.0, cap_d = 4.5, cap_h = 1.0) {
    color([0.45, 0.30, 0.18])
    union() {
        cylinder(d = shank_d, h = shank_h, center = false, $fn = 48);
        translate([0, 0, shank_h]) cylinder(d = head_d, h = head_h, center = false, $fn = 56);
        translate([0, 0, shank_h + head_h]) cylinder(d = cap_d, h = cap_h, center = false, $fn = 56);
    }
}

module drw005_sheet2() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   Common Parts (cp-r1 to cp-r6)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 8.0    SHEET 2 OF 3", sz = 2.9);

    // Top row rivets.
    translate([58, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) rivet_local(2.0, 2.0, 5.0, 1.0, 4.2, 1.0);
    translate([160, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) rivet_local(3.0, 2.6, 4.5, 1.0, 4.5, 1.0);
    translate([260, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) rivet_local(3.0, 2.0, 4.5, 1.0, 4.5, 1.0);
    translate([350, 238, 16]) rotate([65, 0, 20]) scale([2.2, 2.2, 2.2]) rivet_local(3.0, 3.0, 6.0, 1.0, 4.8, 1.0);

    // Bottom row rivets.
    translate([80, 108, 16]) rotate([65, 0, 20]) scale([2.4, 2.4, 2.4]) rivet_local(3.0, 4.0, 6.0, 1.0, 4.8, 1.0);
    translate([165, 106, 16]) rotate([65, 0, 20]) scale([2.6, 2.6, 2.6]) rivet_local(5.0, 4.0, 8.0, 1.0, 6.0, 1.0);

    // Labels.
    color("black") translate([72, 256, 0]) linear_extrude(height = th) label("cp-r1", sz = 3.0, bold = true);
    color("black") translate([176, 256, 0]) linear_extrude(height = th) label("cp-r2", sz = 3.0, bold = true);
    color("black") translate([276, 256, 0]) linear_extrude(height = th) label("cp-r3", sz = 3.0, bold = true);
    color("black") translate([366, 256, 0]) linear_extrude(height = th) label("cp-r4", sz = 3.0, bold = true);
    color("black") translate([96, 126, 0]) linear_extrude(height = th) label("cp-r5", sz = 3.0, bold = true);
    color("black") translate([182, 126, 0]) linear_extrude(height = th) label("cp-r6", sz = 3.0, bold = true);

    // A few 2D references under each group.
    color([0.92, 0.92, 0.92]) {
        translate([48, 180, 0]) linear_extrude(height = th) projection(cut = true) rivet_local(2.0, 2.0, 5.0, 1.0, 4.2, 1.0);
        translate([145, 172, 0]) linear_extrude(height = th) projection(cut = true) rivet_local(3.0, 2.6, 4.5, 1.0, 4.5, 1.0);
        translate([245, 174, 0]) linear_extrude(height = th) projection(cut = true) rivet_local(3.0, 2.0, 4.5, 1.0, 4.5, 1.0);
        translate([336, 172, 0]) linear_extrude(height = th) projection(cut = true) rivet_local(3.0, 3.0, 6.0, 1.0, 4.8, 1.0);
        translate([66, 58, 0]) linear_extrude(height = th) projection(cut = true) rivet_local(3.0, 4.0, 6.0, 1.0, 4.8, 1.0);
        translate([156, 56, 0]) linear_extrude(height = th) projection(cut = true) rivet_local(5.0, 4.0, 8.0, 1.0, 6.0, 1.0);
    }

    color("black") {
        translate([48, 180, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rivet_local(2.0, 2.0, 5.0, 1.0, 4.2, 1.0);
        translate([145, 172, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rivet_local(3.0, 2.6, 4.5, 1.0, 4.5, 1.0);
        translate([245, 174, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rivet_local(3.0, 2.0, 4.5, 1.0, 4.5, 1.0);
        translate([336, 172, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rivet_local(3.0, 3.0, 6.0, 1.0, 4.8, 1.0);
        translate([66, 58, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rivet_local(3.0, 4.0, 6.0, 1.0, 4.8, 1.0);
        translate([156, 56, 0.01]) linear_extrude(height = th) outline2d(0.30) projection(cut = true) rivet_local(5.0, 4.0, 8.0, 1.0, 6.0, 1.0);
    }
}
