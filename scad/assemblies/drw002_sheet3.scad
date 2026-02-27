// DRW-002 Sheet 3 — b (b2, sp1, dat1 mounting hole alignment).
// Source: b_page03.png
// SPDX-License-Identifier: MIT

use <../parts/b1_main_wheel.scad>

module line2d(a = [0, 0], b = [10, 0], w = 0.3) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.38) {
    difference() {
        offset(r =  w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module label(s, sz = 3.0, bold = false) {
    text(s, size = sz, halign = "left", valign = "center",
         font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module dim_h(x0, x1, y, ext0, ext1, txt = "", txt_dy = 2.0) {
    line2d([x0, y], [x1, y], 0.25);
    line2d([x0, y], [x0, ext0], 0.2);
    line2d([x1, y], [x1, ext1], 0.2);
    translate([x0, y]) rotate([0, 0, 180]) polygon([[0,0],[1.2,0.4],[1.2,-0.4]]);
    translate([x1, y]) polygon([[0,0],[-1.2,0.4],[-1.2,-0.4]]);
    if (txt != "") translate([(x0+x1)/2, y+txt_dy])
        text(txt, size=2.8, halign="center", valign="bottom");
}

// Simplified top-projection of b1 plate showing hole layout.
module b1_holes_top(cx, cy) {
    th = 0.12;
    // Outer tooth ring outline.
    color([0.85, 0.85, 0.85])
    translate([cx, cy, 0]) linear_extrude(height = th)
        projection(cut = true) part_b1();
    color("black")
    translate([cx, cy, 0.01]) linear_extrude(height = th)
        outline2d(0.35) projection(cut = true) part_b1();
}

// sp2 hole circle layout (R24.57 pitch circle with Ø3.0 mounting holes).
module sp2_hole_pattern(cx, cy) {
    th = 0.12;
    sp_r  = 24.57 / 2;  // half of D49.14
    hole_d = 3.0;
    color([0.75, 0.75, 0.90])
    translate([cx, cy, 0]) linear_extrude(height = th)
        difference() {
            circle(r = sp_r + 2, $fn = 120);
            circle(r = sp_r - 2, $fn = 120);
        }
    color("black")
    translate([cx, cy, 0.01]) linear_extrude(height = th) {
        outline2d(0.3) difference() {
            circle(r = sp_r + 2, $fn = 120);
            circle(r = sp_r - 2, $fn = 120);
        }
        // 4 Ø3.0 holes at 90° spacing on pitch circle.
        for (a = [0, 90, 180, 270])
            rotate(a) translate([sp_r, 0])
                outline2d(0.3) circle(d = hole_d, $fn = 28);
        // Centre Ø18 ring.
        outline2d(0.3) circle(d = 18.0, $fn = 80);
    }
}

module drw002_sheet3() {
    W = 420; H = 297; B = 8; th = 0.12;

    // Border.
    color("black") linear_extrude(height = th)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W-2*B, H-2*B], center = false);
    }

    // Title block.
    color("black") linear_extrude(height = th) {
        outline2d(0.4) translate([285, 8]) square([127, 34], center = false);
        line2d([285, 20], [412, 20], 0.28);
        line2d([285, 30], [412, 30], 0.28);
        line2d([325, 8],  [325, 42], 0.28);
        line2d([376, 8],  [376, 42], 0.28);
    }
    color("black") translate([289, 37, 0]) linear_extrude(height = th)
        label("PROJECT   Antikithera Mechanism", sz = 3.1, bold = true);
    color("black") translate([289, 25, 0]) linear_extrude(height = th)
        label("DWG NO   b   (b2, sp1, dat1 hole alignment)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 7.0    SHEET 3 OF 10", sz = 2.9);

    // ---- Left: b1 top view with sp2 hole overlay ----
    b1_cx = 100; b1_cy = 160;
    b1_holes_top(b1_cx, b1_cy);

    // sp2 mounting ring overlay on b1.
    sp2_hole_pattern(b1_cx, b1_cy);

    // Hole callouts on b1 view.
    color("black") linear_extrude(height = th) {
        // dat1 / Ø10 centre registration hole.
        outline2d(0.3) translate([b1_cx, b1_cy]) circle(d = 10.0, $fn = 48);
        // Ø3.0 holes at R18 (b1 auxiliary holes, 4×).
        for (a = [0, 90, 180, 270])
            rotate(a) translate([b1_cx + 18, b1_cy])
                outline2d(0.25) circle(d = 3.0, $fn = 28);
        // Ø4.0 holes at R53 (b1 rivet/post holes, 6×).
        for (a = [30, 150, 210, 330])
            rotate(a) translate([b1_cx + 53, b1_cy])
                outline2d(0.25) circle(d = 4.0, $fn = 28);
    }

    // Dimension annotations.
    color("black") linear_extrude(height = th) {
        line2d([b1_cx, b1_cy], [b1_cx, b1_cy + 18], 0.2);
        translate([b1_cx + 1, b1_cy + 10]) text("Ø18.0", size = 2.8, valign = "center");
        line2d([b1_cx, b1_cy], [b1_cx + 9, b1_cy + 9], 0.2);
        translate([b1_cx + 9, b1_cy + 10]) text("Ø10.0", size = 2.8, valign = "center");
    }

    // Label.
    color("black") translate([b1_cx - 60, b1_cy - 78, 0]) linear_extrude(height = th)
        label("b1 (main wheel) — Ø3.0 holes align with sp2 mounting", sz = 2.8);

    // ---- Right: sp2 plate alone (scale 1:1) ----
    sp2_cx = 310; sp2_cy = 160;
    sp2_hole_pattern(sp2_cx, sp2_cy);

    color("black") linear_extrude(height = th) {
        // b2 pitch circle R15.5 shown for reference.
        outline2d(0.25) translate([sp2_cx, sp2_cy]) circle(r = 15.5, $fn = 100);
        line2d([sp2_cx, sp2_cy], [sp2_cx + 15.5, sp2_cy], 0.2);
        translate([sp2_cx + 16, sp2_cy + 1]) text("R15.50 (b2)", size = 2.6, valign = "center");
        line2d([sp2_cx, sp2_cy], [sp2_cx, sp2_cy + 24.57/2], 0.2);
        translate([sp2_cx + 1, sp2_cy + 10]) text("R24.57 (sp2 PCD)", size = 2.6, valign = "center");
    }

    // Ø4.0 alignment holes on sp2 at 90° shown.
    color("black") linear_extrude(height = th)
        for (a = [0, 90, 180, 270])
            rotate(a) translate([sp2_cx + 24.57/2, sp2_cy])
                outline2d(0.25) circle(d = 4.0, $fn = 28);

    color("black") translate([sp2_cx - 30, sp2_cy - 35, 0]) linear_extrude(height = th)
        label("sp2 (superior planet plate) — mounting hole pattern", sz = 2.8);

    // Scale label.
    color("black") translate([B + 2, B + 2, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 3.5, bold = true);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw002_sheet3();
}
