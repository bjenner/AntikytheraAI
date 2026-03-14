// DRW-002 Sheet 4 — b (b to c1, c2 to d1 gear clearance).
// Source: b_page04.png
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

// Gear circle with radius annotation.
module gear_circle(cx, cy, r, lbl, col = "black", fill = false) {
    th = 0.12;
    if (fill) {
        color([0.88, 0.88, 0.88])
        translate([cx, cy, 0]) linear_extrude(height = th)
            circle(r = r, $fn = 180);
    }
    color(col) translate([cx, cy, fill ? 0.01 : 0]) linear_extrude(height = th)
        outline2d(0.3) circle(r = r, $fn = 180);
    if (lbl != "") {
        color("black") translate([cx + r + 1.5, cy, 0]) linear_extrude(height = th)
            text(lbl, size = 2.6, valign = "center");
    }
}

// Radius leader line.
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

module drw002_sheet4() {
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
        label("DWG NO   b  (b to c1, c2 to d1 gear clearance)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 7.0    SHEET 4 OF 10", sz = 2.9);

    // ---- Main gear mesh diagram ----
    // b1 outer ring centred on the sheet.
    b1_cx = 175; b1_cy = 160;
    b1_r  = 66.0;   // b1 outer tip radius (Ø132)

    // b1 outer ring (filled grey).
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

    // b2 gear at R=24.57 from b1 centre.
    b2_offset = 24.57;
    b2_r = 15.50;
    gear_circle(b1_cx + b2_offset, b1_cy, b2_r, "", "black", true);

    // c1 gear meshing with b2 (centre 24.57+0.2+9.82=34.59 from b1 centre).
    c1_r  = 9.82;
    c1_cx = b1_cx + b2_offset + b2_r + 0.2 + c1_r;
    gear_circle(c1_cx, b1_cy, c1_r, "", "black", true);

    // c2 small gear coaxial with c1 (same centre, different layer).
    c2_r  = 4.84;
    gear_circle(c1_cx, b1_cy, c2_r, "", [0.5, 0.35, 0.2], true);

    // d1 gear meshing with c2.
    d1_r  = 11.25;
    d1_cx = c1_cx + c2_r + 0.2 + d1_r;
    gear_circle(d1_cx, b1_cy, d1_r, "", [0.5, 0.35, 0.2], true);

    // Cross-hairs at gear centres.
    color("black") linear_extrude(height = th) {
        for (cx_pt = [b1_cx, b1_cx + b2_offset, c1_cx, d1_cx]) {
            line2d([cx_pt - 4, b1_cy], [cx_pt + 4, b1_cy], 0.2);
            line2d([cx_pt, b1_cy - 4], [cx_pt, b1_cy + 4], 0.2);
        }
    }

    // Radius annotations.
    radius_leader(b1_cx + b2_offset, b1_cy, b2_r, 110, "R15.50 (b2 tip)");
    radius_leader(b1_cx + b2_offset, b1_cy, 14.55, 135, "R14.55 (b2 root)");
    radius_leader(c1_cx, b1_cy, c1_r, 70, "R9.82 (c1)");
    radius_leader(c1_cx, b1_cy, c2_r, 250, "R4.84 (c2)");
    radius_leader(d1_cx, b1_cy, d1_r, 70, "R11.25 (d1)");

    // Centre-distance annotations.
    color("black") translate([B + 2, 60, 0]) linear_extrude(height = th) {
        text("b2 to c1 gear centres: 14.55 + 0.2 + 9.82 = R24.57 = D49.14", size=2.8);
        translate([0, -7]) text("b2 to c1 clearance: 0.2 mm", size=2.8);
        translate([0, -14]) text("c2 to d1 gear centres: 4.84 + 0.2 + 11.25 = R16.29 = D32.58", size=2.8);
        translate([0, -21]) text("c2 to d1 clearance: 0.2 mm", size=2.8);
    }

    // Scale label.
    color("black") translate([B + 2, B + 2, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 3.5, bold = true);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw002_sheet4();
}
