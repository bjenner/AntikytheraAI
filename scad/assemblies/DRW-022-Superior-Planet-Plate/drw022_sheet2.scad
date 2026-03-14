// DRW-022 Sheet 2 — Superior Planet Plate (exploded view + parts list).
// Source: Superior_Planet_Plate_page_02.png
// SPDX-License-Identifier: MIT

use <../../parts/DRW-022-Superior-Planet-Plate/sp1_superior_gear.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp2_gear_axle_subassembly.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp3_superior_plate.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp4_press_pin.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp5_superior_plate.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp6_rivet_pin.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp7_companion_gear.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp8_large_gear.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp9_latch.scad>
use <../../parts/DRW-022-Superior-Planet-Plate/sp10_disc.scad>
use <../../parts/DRW-005-Common-Parts/cpr4_rivet.scad>
use <../../parts/DRW-005-Common-Parts/cpf6_fork.scad>

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

// Shared iso transform.
module iso(rx = 65, rz = 30) {
    rotate([rx, 0, rz]) children();
}

// Parts list table in top-right area.
module parts_list_table(x0, y0) {
    th = 0.12;
    col_w = [22, 8, 58, 26];   // item / qty / file / material
    row_h = 7.5;
    rows = [
        ["sp1",   "1", "sp1.ipt",                   "Bronze"],
        ["sp2",   "1", "sp2.ipt",                   "Bronze"],
        ["sp3",   "1", "Superior Planet Plate.ipt",  "Bronze"],
        ["sp4",   "1", "sp1 axle.ipt",               "Bronze"],
        ["sp5",   "1", "sp3.ipt",                    "Bronze"],
        ["sp6",   "1", "sp1 pin.ipt",                "Bronze"],
        ["sp7",   "1", "sp1 spacer.ipt",             "Bronze"],
        ["sp8",   "1", "sp2 axle OD.ipt",            "Bronze"],
        ["sp9",   "1", "Jupiter Mars latch.ipt",     "Bronze"],
        ["sp10",  "1", "sp2 axle.ipt",               "Bronze"],
        ["cp-r4", "1", "CP Rivet 3D 3.6L.ipt",       "Bronze"],
        ["cp-f6", "1", "CP Fork 3W 10D 6L.ipt",      "Bronze"],
        ["",      "15","Total parts to manufacture",  ""],
    ];

    total_w = col_w[0] + col_w[1] + col_w[2] + col_w[3];
    n_rows = len(rows);

    color("black")
    linear_extrude(height = th) {
        // Outer box.
        outline2d(0.35) square([total_w, (n_rows + 1) * row_h], center = false);
        // Column dividers.
        for (i = [1, 2, 3]) {
            cx = col_w[0] + (i > 1 ? col_w[1] : 0) + (i > 2 ? col_w[2] : 0);
            line2d([cx, 0], [cx, (n_rows + 1) * row_h], 0.25);
        }
        // Row dividers.
        for (r = [1 : n_rows]) {
            line2d([0, r * row_h], [total_w, r * row_h], 0.25);
        }
    }

    // Header row.
    color("black") {
        for (pair = [[0, "ITEM"], [col_w[0], "QTY"],
                      [col_w[0] + col_w[1], "FILE NAME"],
                      [col_w[0] + col_w[1] + col_w[2], "MATERIAL"]]) {
            translate([x0 + pair[0] + 1, y0 + n_rows * row_h + 1.5, 0])
            linear_extrude(height = th) label(pair[1], sz = 2.6, bold = true);
        }
    }

    // Data rows.
    for (r = [0 : n_rows - 1]) {
        row = rows[r];
        ry  = y0 + (n_rows - 1 - r) * row_h + 1.5;
        color("black") {
            translate([x0 + 1,                                     ry, 0]) linear_extrude(height = th) label(row[0], sz = 2.4);
            translate([x0 + col_w[0] + 1,                         ry, 0]) linear_extrude(height = th) label(row[1], sz = 2.4);
            translate([x0 + col_w[0] + col_w[1] + 1,             ry, 0]) linear_extrude(height = th) label(row[2], sz = 2.4);
            translate([x0 + col_w[0] + col_w[1] + col_w[2] + 1,  ry, 0]) linear_extrude(height = th) label(row[3], sz = 2.4);
        }
    }
}

module drw022_sheet2() {
    w      = 420;
    h      = 297;
    border = 8;
    th     = 0.12;
    bronze = [0.45, 0.30, 0.18];

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
        label("DWG  Superior Planet Plate (parts list)", sz = 3.3);
    color("black") translate([303, 15, 0]) linear_extrude(height = th)
        label("SIZE A3    REV 8.0    SHEET 2 OF 7", sz = 3.3);

    // Parts list table — top-right quadrant.
    parts_list_table(300, 52);

    // ---- Exploded isometric parts (left side of sheet) ----
    // Parts are stacked vertically with Z-offsets to show exploded positions.
    // Each part iso-rotated; labels placed below each part.

    // sp5 — base carrier plate (large, at bottom of stack).
    translate([120, 50, 12]) iso(65, 28) scale([0.28, 0.28, 0.28])
        color(bronze) part_sp5();
    color("black") translate([86, 44, 0]) linear_extrude(height = th)
        label("sp5", sz = 2.8, bold = true);

    // sp1 — gear ring.
    translate([120, 105, 12]) iso(65, 28) scale([0.9, 0.9, 0.9])
        color(bronze) part_sp1();
    color("black") translate([116, 100, 0]) linear_extrude(height = th)
        label("sp1", sz = 2.8, bold = true);

    // sp7 — companion ring.
    translate([120, 148, 12]) iso(65, 28) scale([1.2, 1.2, 1.2])
        color([0.38, 0.26, 0.14]) part_sp7();
    color("black") translate([116, 143, 0]) linear_extrude(height = th)
        label("sp7", sz = 2.8, bold = true);

    // sp6 — rivet pin (×4).
    translate([160, 148, 12]) iso(75, 10) scale([2.5, 2.5, 2.5])
        color([0.55, 0.42, 0.28]) part_sp6();
    color("black") translate([155, 143, 0]) linear_extrude(height = th)
        label("sp6 x4", sz = 2.8, bold = true);

    // sp3 — mounting plate.
    translate([60, 195, 12]) iso(62, 22) scale([0.55, 0.55, 0.55])
        color([0.50, 0.34, 0.20]) part_sp3();
    color("black") translate([55, 190, 0]) linear_extrude(height = th)
        label("sp3", sz = 2.8, bold = true);

    // sp2 — gear axle.
    translate([145, 200, 12]) iso(65, 28) scale([1.8, 1.8, 1.8])
        color(bronze) part_sp2();
    color("black") translate([140, 195, 0]) linear_extrude(height = th)
        label("sp2", sz = 2.8, bold = true);

    // sp8 — large gear.
    translate([195, 200, 12]) iso(65, 28) scale([0.9, 0.9, 0.9])
        color(bronze) part_sp8();
    color("black") translate([190, 195, 0]) linear_extrude(height = th)
        label("sp8", sz = 2.8, bold = true);

    // sp9 — latch.
    translate([80, 245, 8]) iso(70, 15) scale([1.0, 1.0, 1.0])
        color([0.40, 0.28, 0.16]) part_sp9();
    color("black") translate([82, 240, 0]) linear_extrude(height = th)
        label("sp9", sz = 2.8, bold = true);

    // sp10 — disc.
    translate([162, 245, 8]) iso(70, 20) scale([3.5, 3.5, 3.5])
        color(bronze) part_sp10();
    color("black") translate([158, 240, 0]) linear_extrude(height = th)
        label("sp10", sz = 2.8, bold = true);

    // sp4 — press pin (×4).
    translate([200, 245, 8]) iso(75, 10) scale([2.0, 2.0, 2.0])
        color([0.55, 0.42, 0.28]) part_sp4();
    color("black") translate([196, 240, 0]) linear_extrude(height = th)
        label("sp4 x4", sz = 2.8, bold = true);

    // cp-r4 and cp-f6 (small hardware).
    translate([240, 205, 8]) iso(70, 20) scale([2.2, 2.2, 2.2])
        color([0.55, 0.42, 0.28]) part_cpr4();
    color("black") translate([237, 200, 0]) linear_extrude(height = th)
        label("cp-r4", sz = 2.6, bold = true);

    translate([275, 205, 8]) iso(70, 20) scale([1.6, 1.6, 1.6])
        color([0.55, 0.42, 0.28]) part_cpf6();
    color("black") translate([272, 200, 0]) linear_extrude(height = th)
        label("cp-f6", sz = 2.6, bold = true);
}


// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw022_sheet2();
}
