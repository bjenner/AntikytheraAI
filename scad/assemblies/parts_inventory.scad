// Parts inventory scene for all modeled standalone parts.
// Shows part_id, part_name, and filename.
// SPDX-License-Identifier: MIT

use <../parts/a1.scad>
use <../parts/a2_ring.scad>
use <../parts/a3_pin.scad>
use <../parts/a4_block.scad>
use <../parts/a5_ring.scad>
use <../parts/a6_bush.scad>
use <../parts/a7_block.scad>
use <../parts/a8_rivet_pin.scad>
use <../parts/a9_axle.scad>
use <../parts/a10_disc.scad>
use <../parts/a12_link.scad>

use <../parts/b0_gear.scad>
use <../parts/b1_main_wheel.scad>
use <../parts/b2_gear_ring.scad>
use <../parts/b3_gear.scad>
use <../parts/b4_rivet_pin.scad>
use <../parts/b5_post.scad>
use <../parts/b6_clip.scad>
use <../parts/b7_hub.scad>
use <../parts/b8_rivet_pin.scad>
use <../parts/b9_pin.scad>
use <../parts/b10_disc.scad>
use <../parts/b11_carrier_block.scad>
use <../parts/b12_pin.scad>
use <../parts/b13_roller.scad>
use <../parts/b14_pin.scad>
use <../parts/b15_wire_link.scad>
use <../parts/b16_rivet.scad>
use <../parts/b17_standoff_pin.scad>
use <../parts/b18_link_plate.scad>

use <../parts/cp1_pointer_small.scad>
use <../parts/cp2_slider.scad>
use <../parts/cp3_rivet.scad>
use <../parts/cp4_stopper.scad>
use <../parts/cp5_spacer.scad>
use <../parts/cp6_bush.scad>
use <../parts/cp7_bush.scad>
use <../parts/cp8_pin.scad>
use <../parts/cp9_pin.scad>
use <../parts/cpr1_rivet.scad>
use <../parts/cpr2_rivet.scad>
use <../parts/cpr3_rivet.scad>
use <../parts/cpr4_rivet.scad>
use <../parts/cpr5_rivet.scad>
use <../parts/cpr6_rivet.scad>
use <../parts/cpf1_fork.scad>
use <../parts/cpf2_fork.scad>
use <../parts/cpf3_fork.scad>
use <../parts/cpf4_fork.scad>
use <../parts/cpf5_fork.scad>
use <../parts/cpf6_fork.scad>

use <../parts/sp1_superior_gear.scad>
use <../parts/sp2_gear_axle_subassembly.scad>
use <../parts/sp3_superior_plate.scad>
use <../parts/sp4_press_pin.scad>
use <../parts/sp5_superior_plate.scad>
use <../parts/sp6_rivet_pin.scad>
use <../parts/sp7_companion_gear.scad>
use <../parts/sat6_date_pointer_axle.scad>
use <../parts/spp17_date_pointer_base.scad>
use <../parts/fp1_front_plate.scad>
use <../parts/fp2_front_panel_dial_frame.scad>
use <../parts/fp3_zodiac_dial.scad>
use <../parts/fp4_egyptian_dial.scad>
use <../parts/fp5_rivet.scad>
use <../parts/fp6_post.scad>
use <../parts/fp7_post.scad>
use <../parts/fp8_post.scad>
use <../parts/fp9_bush.scad>
use <../parts/fp10_zodiac_pointer.scad>

module label3(id, name, file) {
    color("black")
    linear_extrude(height = 0.12) {
        text(id, size = 2.4, halign = "left", valign = "baseline", font = "Liberation Sans:style=Bold");
        translate([0, -3.0]) text(name, size = 1.8, halign = "left", valign = "baseline", font = "Liberation Sans");
        translate([0, -5.2]) text(file, size = 1.5, halign = "left", valign = "baseline", font = "Liberation Sans");
    }
}

module tile(col, row, id, name, file, sc = 1, rx = 62, ry = 0, rz = 24) {
    sx = 40;
    sy = 37;
    x = 10 + col * sx;
    y = 252 - row * sy;
    translate([x, y, 0]) {
        label3(id, name, file);
        color([0.45, 0.30, 0.18])
            translate([14, -15, 13]) rotate([rx, ry, rz]) scale([sc, sc, sc]) children();
    }
}

module parts_inventory() {
    W = 420;
    H = 297;
    B = 6;

    color("black")
    linear_extrude(height = 0.12)
    difference() {
        square([W, H], center = false);
        translate([B, B]) square([W - 2 * B, H - 2 * B], center = false);
    }

    color("black") translate([10, 286, 0]) linear_extrude(height = 0.12)
        text("Parts Inventory (modeled parts)", size = 3.6, halign = "left", font = "Liberation Sans:style=Bold");

    // Row 0
    tile(0,0,"a1","A1 gear","a1.scad",0.55) part_a1();
    tile(1,0,"a2","A2 ring","a2_ring.scad",1.2,68,0,0) part_a2();
    tile(2,0,"a3","A3 pin","a3_pin.scad",1.1,68,0,0) part_a3();
    tile(3,0,"a4","A4 block","a4_block.scad",1.0) part_a4();
    tile(4,0,"a5","A5 ring","a5_ring.scad",1.1,68,0,0) part_a5();
    tile(5,0,"a6","A6 bush","a6_bush.scad",0.95) part_a6();
    tile(6,0,"a7","A7 block","a7_block.scad",0.95) part_a7();
    tile(7,0,"a8","A8 rivet","a8_rivet_pin.scad",1.1,68,0,0) part_a8();
    tile(8,0,"a9","A9 axle","a9_axle.scad",0.75,68,0,0) part_a9();
    tile(9,0,"a10","A10 disc","a10_disc.scad",0.28) part_a10();

    // Row 1
    tile(0,1,"a12","A12 link","a12_link.scad",1.0,70,0,-10) part_a12();
    tile(1,1,"b0","B0 gear","b0_gear.scad",1.3) part_b0();
    tile(2,1,"b1","B1 main wheel","b1_main_wheel.scad",0.23) part_b1();
    tile(3,1,"b2","B2 gear ring","b2_gear_ring.scad",0.8) part_b2();
    tile(4,1,"b3","B3 gear","b3_gear.scad",1.0) part_b3();
    tile(5,1,"b4","B4 rivet pin","b4_rivet_pin.scad",1.1,68,0,0) part_b4();
    tile(6,1,"b5","B5 post","b5_post.scad",0.8,68,0,0) part_b5();
    tile(7,1,"b6","B6 clip","b6_clip.scad",1.1) part_b6();
    tile(8,1,"b7","B7 hub","b7_hub.scad",0.9) part_b7();
    tile(9,1,"b8","B8 rivet pin","b8_rivet_pin.scad",1.0,68,0,0) part_b8();

    // Row 2
    tile(0,2,"b9","B9 pin","b9_pin.scad",1.0,68,0,0) part_b9();
    tile(1,2,"b10","B10 disc","b10_disc.scad",0.65) part_b10();
    tile(2,2,"b11","B11 carrier","b11_carrier_block.scad",0.55) part_b11();
    tile(3,2,"b12","B12 pin","b12_pin.scad",0.9,68,0,0) part_b12();
    tile(4,2,"b13","B13 roller","b13_roller.scad",1.0,68,0,0) part_b13();
    tile(5,2,"b14","B14 pin","b14_pin.scad",1.0,68,0,0) part_b14();
    tile(6,2,"b15","B15 wire link","b15_wire_link.scad",0.9,70,0,10) part_b15();
    tile(7,2,"b16","B16 rivet","b16_rivet.scad",1.0,68,0,0) part_b16();
    tile(8,2,"b17","B17 standoff","b17_standoff_pin.scad",0.7,68,0,0) part_b17();
    tile(9,2,"b18","B18 link plate","b18_link_plate.scad",0.35,70,0,18) part_b18();

    // Row 3
    tile(0,3,"cp1","CP1 pointer","cp1_pointer_small.scad",1.1,70,0,18) part_cp1();
    tile(1,3,"cp2","CP2 slider","cp2_slider.scad",0.8) part_cp2();
    tile(2,3,"cp3","CP3 rivet","cp3_rivet.scad",1.2,68,0,0) part_cp3();
    tile(3,3,"cp4","CP4 stopper","cp4_stopper.scad",1.0,68,0,0) part_cp4();
    tile(4,3,"cp5","CP5 spacer","cp5_spacer.scad",1.0,68,0,0) part_cp5();
    tile(5,3,"cp6","CP6 bush","cp6_bush.scad",1.0,68,0,0) part_cp6();
    tile(6,3,"cp7","CP7 bush","cp7_bush.scad",1.0,68,0,0) part_cp7();
    tile(7,3,"cp8","CP8 pin","cp8_pin.scad",1.0,68,0,0) part_cp8();
    tile(8,3,"cp9","CP9 pin","cp9_pin.scad",1.0,68,0,0) part_cp9();
    tile(9,3,"cp-r1","CPR1 rivet","cpr1_rivet.scad",1.0,68,0,0) part_cpr1();

    // Row 4
    tile(0,4,"cp-r2","CPR2 rivet","cpr2_rivet.scad",1.0,68,0,0) part_cpr2();
    tile(1,4,"cp-r3","CPR3 rivet","cpr3_rivet.scad",1.0,68,0,0) part_cpr3();
    tile(2,4,"cp-r4","CPR4 rivet","cpr4_rivet.scad",1.0,68,0,0) part_cpr4();
    tile(3,4,"cp-r5","CPR5 rivet","cpr5_rivet.scad",1.0,68,0,0) part_cpr5();
    tile(4,4,"cp-r6","CPR6 rivet","cpr6_rivet.scad",1.0,68,0,0) part_cpr6();
    tile(5,4,"cp-f1","CPF1 fork","cpf1_fork.scad",1.0,70,0,18) part_cpf1();
    tile(6,4,"cp-f2","CPF2 fork","cpf2_fork.scad",1.0,70,0,18) part_cpf2();
    tile(7,4,"cp-f3","CPF3 fork","cpf3_fork.scad",1.0,70,0,18) part_cpf3();
    tile(8,4,"cp-f4","CPF4 fork","cpf4_fork.scad",1.0,70,0,18) part_cpf4();
    tile(9,4,"cp-f5","CPF5 fork","cpf5_fork.scad",0.9,70,0,18) part_cpf5();

    // Row 5
    tile(0,5,"cp-f6","CPF6 fork","cpf6_fork.scad",1.0,70,0,18) part_cpf6();
    tile(1,5,"sp1","SP1 superior gear","sp1_superior_gear.scad",0.45) part_sp1();
    tile(2,5,"sp2","SP2 gear axle","sp2_gear_axle_subassembly.scad",0.7) part_sp2();
    tile(3,5,"sp3","SP3 superior plate","sp3_superior_plate.scad",0.22,68,0,0) part_sp3();
    tile(4,5,"sp4","SP4 press pin","sp4_press_pin.scad",1.0,68,0,0) part_sp4();
    tile(5,5,"sp5","SP5 superior wheel","sp5_superior_plate.scad",0.22,68,0,0) part_sp5();
    tile(6,5,"sp6","SP6 rivet pin","sp6_rivet_pin.scad",1.0,68,0,0) part_sp6();
    tile(7,5,"sp7","SP7 companion gear","sp7_companion_gear.scad",0.75) part_sp7();
    tile(8,5,"sat6","SAT6 axle","sat6_date_pointer_axle.scad",1.0,68,0,0) part_sat6();
    tile(9,5,"spp17","SPP17 base","spp17_date_pointer_base.scad",0.9) part_spp17();

    // Row 6 (DRW-010 front-plate parts)
    tile(0,6,"fp1","FP1 front plate","fp1_front_plate.scad",0.11,68,0,0) part_fp1();
    tile(1,6,"fp2","FP2 dial frame","fp2_front_panel_dial_frame.scad",0.19,68,0,0) part_fp2();
    tile(2,6,"fp3","FP3 zodiac dial","fp3_zodiac_dial.scad",0.20,68,0,0) part_fp3();
    tile(3,6,"fp4","FP4 egyptian dial","fp4_egyptian_dial.scad",0.18,68,0,0) part_fp4();
    tile(4,6,"fp5","FP5 rivet","fp5_rivet.scad",0.9,68,0,0) part_fp5();
    tile(5,6,"fp6","FP6 post long","fp6_post.scad",0.65,68,0,0) part_fp6();
    tile(6,6,"fp7","FP7 post short","fp7_post.scad",0.95,68,0,0) part_fp7();
    tile(7,6,"fp8","FP8 post tall","fp8_post.scad",0.75,68,0,0) part_fp8();
    tile(8,6,"fp9","FP9 bush","fp9_bush.scad",0.9,68,0,0) part_fp9();
    tile(9,6,"fp10","FP10 pointer","fp10_zodiac_pointer.scad",0.20,70,0,18) part_fp10();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    parts_inventory();
}
