// DRW-022 Sheet 4 — Superior Planet Plate (Axle clearance).
// Source: Superior_Planet_Plate_page_04.png
// SPDX-License-Identifier: MIT

use <../parts/sp1_superior_gear.scad>
use <../parts/sp2_gear_axle_subassembly.scad>
use <../parts/sp5_superior_plate.scad>
use <../parts/sp6_rivet_pin.scad>
use <../parts/sp7_companion_gear.scad>

module label(s, p = [0, 0], sz = 3.2, bold = false) {
    text(s, size = sz, halign = "left", valign = "center",
         font = bold ? "Liberation Sans:style=Bold" : "Liberation Sans");
}

module line2d(a = [0, 0], b = [10, 0], w = 0.35) {
    hull() {
        translate(a) circle(d = w, $fn = 20);
        translate(b) circle(d = w, $fn = 20);
    }
}

module outline2d(w = 0.45) {
    difference() {
        offset(r =  w / 2) children();
        offset(delta = -w / 2) children();
    }
}

module dim_v(y0, y1, x, ext0, ext1, txt = "", txt_dx = 2.2) {
    line2d([x, y0], [x, y1], 0.3);
    line2d([x, y0], [ext0, y0], 0.25);
    line2d([x, y1], [ext1, y1], 0.25);
    translate([x, y0]) rotate([0, 0, -90]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    translate([x, y1]) rotate([0, 0,  90]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    if (txt != "") {
        translate([x + txt_dx, (y0 + y1) / 2]) rotate([0, 0, 90])
            text(txt, size = 3.2, halign = "center", valign = "bottom");
    }
}

module dim_h(x0, x1, y, ext0, ext1, txt = "", txt_dy = 2.2) {
    line2d([x0, y], [x1, y], 0.3);
    line2d([x0, y], [x0, ext0], 0.25);
    line2d([x1, y], [x1, ext1], 0.25);
    translate([x0, y]) rotate([0, 0, 180]) polygon([[0, 0], [1.4, 0.5], [1.4, -0.5]]);
    translate([x1, y]) polygon([[0, 0], [-1.4, 0.5], [-1.4, -0.5]]);
    if (txt != "") {
        translate([(x0 + x1) / 2, y + txt_dy])
            text(txt, size = 3.2, halign = "center", valign = "bottom");
    }
}

// sp1 sub assembly: SP1 + SP7 riveted (SP6 ×4) onto SP5 carrier.
module sp1_sub_assembly() {
    bronze   = [0.45, 0.30, 0.18];
    bronze2  = [0.50, 0.35, 0.20];
    dark_brz = [0.33, 0.25, 0.15];

    color([0.55, 0.40, 0.22]) part_sp5();
    color(bronze2)  translate([0, 0, 2.0]) part_sp1();
    color(dark_brz) translate([0, 0, 4.0]) part_sp7();
    // SP6 rivet pins at 4 positions.
    for (a = [0, 90, 180, 270]) {
        rotate([0, 0, a]) translate([13, 0, 4.2])
            color([0.60, 0.45, 0.30]) part_sp6();
    }
}

// Section detail box (cross-section schematic).
module section_box(label_txt, cx, cy, bore_d, outer_d, h_list, clearance = 0) {
    th = 0.12;
    box_w = 30;
    box_h = 22;

    color("black") linear_extrude(height = th)
    difference() {
        translate([cx - box_w/2, cy - box_h/2]) square([box_w, box_h]);
        translate([cx - box_w/2 + 0.35, cy - box_h/2 + 0.35])
            square([box_w - 0.7, box_h - 0.7]);
    }

    // Simplified cross-section: two rectangles (shaft + bore walls).
    half_bore   = bore_d  / 2;
    half_outer  = outer_d / 2;
    total_h     = h_list[0] + (len(h_list) > 1 ? h_list[1] : 0);

    color([0.88, 0.88, 0.88]) linear_extrude(height = th)
        translate([cx - half_outer, cy - total_h / 2])
            difference() {
                square([outer_d, total_h]);
                translate([half_outer - half_bore, -0.1]) square([bore_d, total_h + 0.2]);
            }
    color("black") linear_extrude(height = th + 0.01)
        translate([cx - half_outer, cy - total_h / 2])
            outline2d(0.3)
                difference() {
                    square([outer_d, total_h]);
                    translate([half_outer - half_bore, -0.1]) square([bore_d, total_h + 0.2]);
                }

    // Section label.
    color("black") translate([cx - box_w/2 + 1, cy + box_h/2 - 4.5, 0])
        linear_extrude(height = th) label(label_txt, sz = 2.8, bold = true);

    // Dimension callout for clearance.
    if (clearance > 0) {
        color("black") translate([cx + half_outer + 2, cy, 0])
            linear_extrude(height = th) label(str(clearance), sz = 2.6);
    }
}

module drw022_sheet4() {
    w      = 420;
    h      = 297;
    border = 8;
    th     = 0.12;

    // Sheet border.
    color("black")
    linear_extrude(height = th)
    difference() {
        square([w, h], center = false);
        translate([border, border]) square([w - 2 * border, h - 2 * border], center = false);
    }

    // Title block.
    color("black")
    linear_extrude(height = th) {
        outline2d(0.45) translate([300, 8]) square([112, 42], center = false);
        line2d([300, 22], [412, 22], 0.3);
        line2d([300, 34], [412, 34], 0.3);
        line2d([352, 8],  [352, 50], 0.3);
    }

    color("black") translate([303, 42, 0]) linear_extrude(height = th)
        label("PROJECT  Antikythera Mechanism", sz = 3.9, bold = true);
    color("black") translate([303, 28, 0]) linear_extrude(height = th)
        label("DWG  Superior Planet Plate (Axle clearance)", sz = 3.3);
    color("black") translate([303, 15, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 4 OF 7", sz = 3.3);

    // ---- Left: sp1 sub assembly isometric ----
    translate([110, 170, 30]) rotate([65, 0, 20]) scale([0.35, 0.35, 0.35])
        sp1_sub_assembly();

    color("black") translate([18, 108, 0]) linear_extrude(height = th)
        label("sp1 sub assembly", sz = 3.4, bold = true);

    // ---- Right: cross-section details ----
    // Section B-B (bore clearance sp1 inner bore / SP2 axle).
    section_box("SECTION B-B", 245, 220, 4.0, 8.0, [1.70, 1.06]);
    color("black") translate([218, 238, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 2.8);
    color("black") linear_extrude(height = th) {
        dim_h(230, 238, 202, 210, 210, "1.06");
        dim_v(218, 224, 272, 260, 260, "1.70");
    }

    // Section C-C (outer bore / bearing fit).
    section_box("SECTION C-C", 245, 155, 4.0, 7.0, [1.80]);
    color("black") translate([218, 173, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 2.8);
    color("black") linear_extrude(height = th) {
        dim_v(148, 162, 272, 260, 260, "1.80");
    }

    // Section D-D (axle outer).
    section_box("SECTION D-D", 245, 90, 4.0, 7.0, [1.70, 1.05]);
    color("black") translate([218, 108, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 2.8);
    color("black") linear_extrude(height = th) {
        dim_v(83, 97, 272, 260, 260, "1.70");
        dim_h(231, 239, 77, 84, 84, "1.05");
    }

    // Section F-F (tight clearance — 0.15 mm).
    section_box("SECTION F-F", 355, 155, 3.0, 5.0, [0.15], clearance = 0);
    color("black") translate([328, 173, 0]) linear_extrude(height = th)
        label("SCALE 1 : 1", sz = 2.8);
    color("black") linear_extrude(height = th) {
        dim_h(342, 348, 142, 150, 150, "0.15");
    }

    // Section marker labels on assembly.
    color("black") {
        translate([160, 100, 0]) linear_extrude(height = th) label("B", sz = 4.0, bold = true);
        translate([175, 100, 0]) linear_extrude(height = th) label("B", sz = 4.0, bold = true);
        translate([160, 133, 0]) linear_extrude(height = th) label("C", sz = 4.0, bold = true);
        translate([175, 133, 0]) linear_extrude(height = th) label("C", sz = 4.0, bold = true);
        translate([160, 116, 0]) linear_extrude(height = th) label("D", sz = 4.0, bold = true);
        translate([175, 116, 0]) linear_extrude(height = th) label("D", sz = 4.0, bold = true);
        translate([160, 148, 0]) linear_extrude(height = th) label("F", sz = 4.0, bold = true);
        translate([175, 148, 0]) linear_extrude(height = th) label("F", sz = 4.0, bold = true);
    }
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw022_sheet4();
}
