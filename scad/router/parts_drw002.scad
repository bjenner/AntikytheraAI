// DRW-002 part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-002-B-Wheel-Frame-Assembly/b0_gear.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b1_main_wheel.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b2_gear_ring.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b3_gear.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b4_rivet_pin.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b5_post.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b6_clip.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b7_hub.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b8_rivet_pin.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b9_pin.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b10_disc.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b11_carrier_block.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b12_pin.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b13_roller.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b14_pin.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b15_wire_link.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b16_rivet.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b17_standoff_pin.scad>
use <../parts/DRW-002-B-Wheel-Frame-Assembly/b18_link_plate.scad>

PART_MODES_DRW002 = [
    "part_b0", "part_b1", "part_b2", "part_b3", "part_b4", "part_b5",
    "part_b6", "part_b7", "part_b8", "part_b9", "part_b10", "part_b11",
    "part_b12", "part_b13", "part_b14", "part_b15", "part_b16", "part_b17",
    "part_b18"
];

module route_parts_drw002(mode) {
    if (mode == "part_b0") {
        part_b0();
    } else if (mode == "part_b1") {
        part_b1();
    } else if (mode == "part_b2") {
        part_b2();
    } else if (mode == "part_b3") {
        part_b3();
    } else if (mode == "part_b4") {
        part_b4();
    } else if (mode == "part_b5") {
        part_b5();
    } else if (mode == "part_b6") {
        part_b6();
    } else if (mode == "part_b7") {
        part_b7();
    } else if (mode == "part_b8") {
        part_b8();
    } else if (mode == "part_b9") {
        part_b9();
    } else if (mode == "part_b10") {
        part_b10();
    } else if (mode == "part_b11") {
        part_b11();
    } else if (mode == "part_b12") {
        part_b12();
    } else if (mode == "part_b13") {
        part_b13();
    } else if (mode == "part_b14") {
        part_b14();
    } else if (mode == "part_b15") {
        part_b15();
    } else if (mode == "part_b16") {
        part_b16();
    } else if (mode == "part_b17") {
        part_b17();
    } else if (mode == "part_b18") {
        part_b18();
    }
}
