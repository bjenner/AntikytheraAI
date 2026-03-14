// DRW-010 part router.
// SPDX-License-Identifier: MIT

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

PART_MODES_DRW010 = [
    "part_fp1", "part_fp2", "part_fp3", "part_fp4", "part_fp5",
    "part_fp6", "part_fp7", "part_fp8", "part_fp9", "part_fp10"
];

module route_parts_drw010(mode) {
    if (mode == "part_fp1") {
        part_fp1();
    } else if (mode == "part_fp2") {
        part_fp2();
    } else if (mode == "part_fp3") {
        part_fp3();
    } else if (mode == "part_fp4") {
        part_fp4();
    } else if (mode == "part_fp5") {
        part_fp5();
    } else if (mode == "part_fp6") {
        part_fp6();
    } else if (mode == "part_fp7") {
        part_fp7();
    } else if (mode == "part_fp8") {
        part_fp8();
    } else if (mode == "part_fp9") {
        part_fp9();
    } else if (mode == "part_fp10") {
        part_fp10();
    }
}
