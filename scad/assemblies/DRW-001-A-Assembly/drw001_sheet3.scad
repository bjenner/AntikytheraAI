// DRW-001 Sheet 3 — a (a1 to b1 gear clearance).
// Source: a_page03.png
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

module drw001_sheet3() {
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
        label("DWG NO   a  (a1 to b1 gear clearance)", sz = 2.8);
    color("black") translate([289, 13, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 3 OF 7", sz = 2.9);

    // ---- Main gear mesh diagram (right side, centred on b1 wheel) ----
    // b1 outer ring centred at (175, 165).
    b1_cx = 175; b1_cy = 165;
    b1_tip_r  = 66.0;   // b1 outer tip
    b1_root_r = 62.0;   // b1 inner face of tooth ring (approximate)

    // b1 outer ring (grey fill + black outline).
    color([0.90, 0.90, 0.90])
    translate([b1_cx, b1_cy, 0]) linear_extrude(height = 0.12)
        difference() {
            circle(r = b1_tip_r,  $fn = 240);
            circle(r = b1_tip_r - 4, $fn = 240);
        }
    color("black")
    translate([b1_cx, b1_cy, 0.01]) linear_extrude(height = 0.12)
        outline2d(0.3) difference() {
            circle(r = b1_tip_r,  $fn = 240);
            circle(r = b1_tip_r - 4, $fn = 240);
        }

    // b1 inner ring reference circle (dashed representation via thin ring).
    gear_circle(b1_cx, b1_cy, b1_root_r, [0.5, 0.35, 0.2], false);

    // a1 gear — meshes inside b1's inner ring.
    // centre-to-centre = b1_root_r − a1_tip_r − 0.2 (clearance) = 62 − 14.1 − 0.2 = 47.7
    a1_r  = 14.1;
    a1_cx = b1_cx + (b1_root_r - a1_r - 0.2);  // offset along +X axis
    gear_circle(a1_cx, b1_cy, a1_r, "black", true);

    // a1 root circle.
    gear_circle(a1_cx, b1_cy, 12.8, [0.5, 0.35, 0.2], false);

    // Cross-hairs at b1 centre and a1 centre.
    color("black") linear_extrude(height = th) {
        for (cx_pt = [b1_cx, a1_cx]) {
            line2d([cx_pt - 5, b1_cy], [cx_pt + 5, b1_cy], 0.2);
            line2d([cx_pt, b1_cy - 5], [cx_pt, b1_cy + 5], 0.2);
        }
    }

    // Radius annotations.
    radius_leader(b1_cx,  b1_cy, b1_tip_r,  150, "R66.0 (b1 outer tip)");
    radius_leader(b1_cx,  b1_cy, b1_root_r, 165, "R62.0 (b1 inner face)");
    radius_leader(a1_cx,  b1_cy, a1_r,       60, "R14.1 (a1 outer tip)");
    radius_leader(a1_cx,  b1_cy, 12.8,       240, "R12.8 (a1 root)");

    // Centre-distance line and annotation.
    color("black") linear_extrude(height = th)
        line2d([b1_cx, b1_cy], [a1_cx, b1_cy], 0.25);
    color("black") translate([b1_cx + 20, b1_cy + 3, 0]) linear_extrude(height = th)
        text("C/C = 47.7 mm", size = 2.8, valign = "center");

    // ---- Section-view notes (bottom-left) ----
    // Reproduce axial-clearance values read from the source section drawing.
    color("black") translate([B + 2, 80, 0]) linear_extrude(height = th) {
        text("Section A-A  (axial clearances along shaft):", size = 2.9, halign = "left");
        translate([0, -8])  text("  1.90 mm — total a1 assembly axial engagement depth", size = 2.8);
        translate([0, -15]) text("  0.65 mm — gear face clearance (a1 to b1 face)", size = 2.8);
        translate([0, -22]) text("  0.80 mm — gear root-to-shoulder clearance", size = 2.8);
        translate([0, -31]) text("Mesh clearance (radial): 0.2 mm", size = 2.8);
        translate([0, -38]) text("a1 to b1 centres: R62.0 - 0.2 - R14.1 = R47.7 = D95.4", size = 2.8);
    }

    // Scale label.
    color("black") translate([B + 2, B + 2, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 3.5, bold = true);
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw001_sheet3();
}
