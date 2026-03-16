// DRW-002 Sheet 6 recreation (b0 to b4).
// SPDX-License-Identifier: MIT

use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b0_gear.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b1_main_wheel.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b2_gear_ring.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b3_gear.scad>
use <../../parts/DRW-002-B-Wheel-Frame-Assembly/b4_rivet_pin.scad>
use <./drw002_b2_subassembly.scad>

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

module dim_h(x0, x1, y, txt = "") {
    line2d([x0, y], [x1, y], 0.24);
    translate([x0, y]) rotate([0, 0, 180]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    translate([x1, y]) polygon([[0, 0], [-1.2, 0.42], [-1.2, -0.42]]);
    if (txt != "") translate([(x0 + x1) / 2, y + 1.6]) text(txt, size = 2.7, halign = "center");
}

module dim_v(y0, y1, x, txt = "") {
    line2d([x, y0], [x, y1], 0.24);
    translate([x, y0]) rotate([0, 0, -90]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    translate([x, y1]) rotate([0, 0, 90]) polygon([[0, 0], [1.2, 0.42], [1.2, -0.42]]);
    if (txt != "") translate([x + 1.8, (y0 + y1) / 2]) rotate([0, 0, 90]) text(txt, size = 2.7, halign = "center");
}

module drw002_sheet6() {
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
    color("black") translate([289, 25, 0]) linear_extrude(height = th) label("DWG NO   b      (b0 to b4)", sz = 3.0);
    color("black") translate([289, 13, 0]) linear_extrude(height = th) label("SIZE A3    REV 7.0    SHEET 6 OF 10", sz = 2.9);

    // Upper-left detailed b1 view.
    color([0.95, 0.95, 0.95])
        translate([86, 192, 0])
            linear_extrude(height = th)
                b1_wheel_2d();
    color("black")
        translate([86, 192, 0.01])
            linear_extrude(height = th)
                outline2d(0.24)
                    b1_wheel_2d();

    // Thin side section strip between the two wheel views.
    color("black")
        translate([83, 145, 0.01])
            linear_extrude(height = th)
                projection(cut = false)
                    rotate([90, 0, 0])
                        part_b1();

    // Lower-left continuity view.
    color([0.97, 0.97, 0.97])
        translate([88, 42, 0])
            linear_extrude(height = th)
                b1_wheel_2d();
    color([0.72, 0.72, 0.72])
        translate([88, 42, 0.01])
            linear_extrude(height = th)
                outline2d(0.18)
                    b1_wheel_2d();

    // A few key dimensions to anchor the technical-view feel.
    color("black")
        linear_extrude(height = th) {
            dim_h(53, 119, 235, "R66.0");
            dim_v(161, 223, 152, "44.6");
            dim_h(73, 99, 187, "26.5");
            dim_v(169, 198, 125, "29.4");
        }

    // Center hero isometric wheel.
    color([0.45, 0.30, 0.18])
        translate([212, 66, 16])
            rotate([69, 0, 31])
                scale([1.08, 1.08, 1.08])
                    part_b1();
    color("black") translate([191, 170, 0]) linear_extrude(height = th) label("b1 sheet metal cut pateren", sz = 2.8);

    // Top-right: b0 and b3 detail cluster.
    color("black") translate([198, 279, 0]) linear_extrude(height = th) label("b0 sheet metal cut pattern", sz = 2.6);
    color([0.45, 0.30, 0.18]) translate([223, 252, 16]) rotate([65, 0, 33]) part_b0();
    color([0.92, 0.92, 0.92]) translate([270, 246, 0]) linear_extrude(height = th) b3_gear_2d();
    color([0.82, 0.82, 0.82]) translate([270, 246, 0.01]) linear_extrude(height = th) outline2d(0.18) b3_gear_2d();
    color([0.45, 0.30, 0.18]) translate([356, 246, 16]) rotate([67, 0, 36]) part_b3();
    color("black") translate([357, 269, 0]) linear_extrude(height = th) label("b3", sz = 3.0, bold = true);
    color("black") linear_extrude(height = th) {
        dim_v(235, 251, 308, "1.6");
        line2d([351, 267], [344, 255], 0.22);
    }

    // Mid-right and lower-right: b2, b4, and subassembly.
    color([0.92, 0.92, 0.92]) translate([334, 146, 0]) linear_extrude(height = th) b2_gear_2d();
    color("black") translate([334, 146, 0.01]) linear_extrude(height = th) outline2d(0.26) b2_gear_2d();
    color("black") translate([370, 116, 0]) linear_extrude(height = th) label("b2", sz = 3.0, bold = true);

    color([0.25, 0.25, 0.25]) translate([294, 86, 16]) rotate([90, 0, 0]) part_b4();
    color("black") translate([283, 82, 0]) linear_extrude(height = th) label("b4 x 4", sz = 2.9, bold = true);
    color("black") translate([272, 67, 0]) linear_extrude(height = th) label("Rivet b4 x 2 to b2", sz = 2.7);

    translate([360, 54, 16]) rotate([67, 0, 24]) scale([1.32, 1.32, 1.32]) drw002_b2_subassembly();
    color("black") translate([338, 44, 0]) linear_extrude(height = th) label("b2 sub assembly", sz = 2.8);

    // Leaders.
    color("black") linear_extrude(height = th) {
        line2d([291, 83], [293, 93], 0.24);
        line2d([284, 68], [291, 80], 0.24);
        line2d([371, 114], [365, 92], 0.24);
        line2d([347, 45], [356, 60], 0.24);
        line2d([215, 278], [223, 257], 0.24);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    drw002_sheet6();
}
