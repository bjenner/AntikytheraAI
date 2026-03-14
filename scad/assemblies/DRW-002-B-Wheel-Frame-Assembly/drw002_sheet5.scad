// DRW-002 Sheet 5 — b (b to l2, l2 to m1 gear clearance).
// Source: b_page05.png
// SPDX-License-Identifier: MIT

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

module gear_circle(cx, cy, r, col = "black", fill = false) {
    th = 0.12;
    if (fill) {
        color([0.88, 0.88, 0.88])
        translate([cx, cy, 0]) linear_extrude(height = th)
            circle(r = r, $fn = 180);
    }
    color(col) translate([cx, cy, fill ? 0.01 : 0]) linear_extrude(height = th)
        outline2d(0.3) circle(r = r, $fn = 180);
}

module radius_leader(cx, cy, r, angle_deg, lbl) {
    th = 0.12;
    ex = cx + r * cos(angle_deg);
    ey = cy + r * sin(angle_deg);
    color("black") linear_extrude(height = th) {
        line2d([cx, cy], [ex, ey], 0.2);
        translate([ex + 1.5 * cos(angle_deg), ey + 1.5 * sin(angle_deg)])
            text(lbl, size = 2.6, halign = "left", valign = "center");
    }
}

module drw002_sheet5() {
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
        label("DWG NO   b  (b to l2, l2 to m1 gear clearance)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 7.0    SHEET 5 OF 10", sz = 2.9);

    // ---- Main gear mesh diagram ----
    // b1 outer ring.
    b1_cx = 175; b1_cy = 155;
    b1_r  = 66.0;

    color([0.90, 0.90, 0.90])
    translate([b1_cx, b1_cy, 0]) linear_extrude(height = 0.12)
        difference() {
            circle(r = b1_r, $fn = 240);
            circle(r = b1_r - 4, $fn = 240);
        }
    color("black")
    translate([b1_cx, b1_cy, 0.01]) linear_extrude(height = 0.12)
        outline2d(0.3) difference() {
            circle(r = b1_r, $fn = 240);
            circle(r = b1_r - 4, $fn = 240);
        }

    // b2 gear (R15.50) offset from b1 centre.
    b2_offset = 24.57;
    b2_r      = 15.50;
    gear_circle(b1_cx + b2_offset, b1_cy, b2_r, "black", true);

    // l0 gear coaxial with b2 (same centre, R12.63 root).
    l0_r = 12.63;
    gear_circle(b1_cx + b2_offset, b1_cy, l0_r, [0.5, 0.35, 0.2], false);

    // l2 gear meshing with b2 (b2 tip R15.50, clearance 0.2, l2 tip R9.82).
    l2_r    = 9.82;
    l2_cx   = b1_cx + b2_offset + b2_r + 0.2 + l2_r;
    gear_circle(l2_cx, b1_cy, l2_r, "black", true);

    // l2 root circle.
    gear_circle(l2_cx, b1_cy, 8.88, [0.5, 0.35, 0.2], false);

    // m1 gear meshing with l2 (l2 tip R9.82, clearance 0.2, m1 tip R13.75).
    m1_r  = 13.75;
    m1_cx = l2_cx + l2_r + 0.2 + m1_r;
    gear_circle(m1_cx, b1_cy, m1_r, [0.5, 0.35, 0.2], true);

    // l1 gear coaxial with l2 (R23.38, outer ring).
    l1_r = 23.38;
    gear_circle(l2_cx, b1_cy, l1_r, "black", false);

    // Cross-hairs at gear centres.
    color("black") linear_extrude(height = th) {
        for (cx_pt = [b1_cx, b1_cx + b2_offset, l2_cx, m1_cx]) {
            line2d([cx_pt - 4, b1_cy], [cx_pt + 4, b1_cy], 0.2);
            line2d([cx_pt, b1_cy - 4], [cx_pt, b1_cy + 4], 0.2);
        }
    }

    // Radius annotations.
    radius_leader(b1_cx + b2_offset, b1_cy, b2_r,   110, "R15.50 (b2 tip)");
    radius_leader(b1_cx + b2_offset, b1_cy, 14.55,  125, "R14.55 (b2 root)");
    radius_leader(b1_cx + b2_offset, b1_cy, l1_r,    60, "R23.38 (l1)");
    radius_leader(l2_cx, b1_cy,              l2_r,    70, "R9.82 (l2 tip)");
    radius_leader(l2_cx, b1_cy,              8.88,   260, "R8.88 (l2 root)");
    radius_leader(m1_cx, b1_cy,              m1_r,    70, "R13.75 (m1)");
    radius_leader(b1_cx + b2_offset, b1_cy, 12.63,   230, "R12.63 (l0)");

    // sp2 diameter reference.
    color("black") linear_extrude(height = th)
        line2d([b1_cx + b2_offset, b1_cy], [b1_cx + b2_offset + b2_r + 0.2 + l2_r, b1_cy], 0.25);
    color("black") translate([b1_cx + b2_offset - 5, b1_cy - 8, 0]) linear_extrude(height = th)
        text("sp2 centre = 24.57", size = 2.8, halign = "center");

    // Centre-distance annotations.
    color("black") translate([B + 2, 55, 0]) linear_extrude(height = th) {
        text("b2 to l2 gear centres: 14.55 + 0.2 + 9.82 = R24.57 = D49.14", size = 2.8);
        translate([0, -7]) text("b2 to l0 clearance: 0.2 mm", size = 2.8);
        translate([0, -14]) text("l2 to m1 gear centres: 23.38 + 0.2 + 13.75 = R37.33 = D74.66", size = 2.8);
        translate([0, -21]) text("l2 to m1 clearance: 0.2 mm", size = 2.8);
    }

    // Scale label.
    color("black") translate([B + 2, B + 2, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 3.5, bold = true);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw002_sheet5();
}
