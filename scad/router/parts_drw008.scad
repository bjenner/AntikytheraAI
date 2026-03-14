// DRW-008 part router.
// SPDX-License-Identifier: MIT

use <../parts/sat6_date_pointer_axle.scad>
use <../parts/spp17_date_pointer_base.scad>
use <../parts/dat1_pointer.scad>
use <../parts/dat2_pin.scad>
use <../parts/dat3_ball_tip.scad>
use <../parts/dat4_post.scad>
use <../parts/dat5_ball_tip_small.scad>
use <../parts/dat6_post_small.scad>
use <../parts/dat7_ring.scad>
use <../parts/dat8_ring.scad>
use <../parts/dat9_base_plate.scad>
use <../parts/dat10_spoked_wheel.scad>

PART_MODES_DRW008 = [
    "part_sat6", "part_spp17", "part_dat1", "part_dat2", "part_dat3", "part_dat4",
    "part_dat5", "part_dat6", "part_dat7", "part_dat8", "part_dat9", "part_dat10"
];

module route_parts_drw008(mode) {
    if (mode == "part_sat6") {
        part_sat6();
    } else if (mode == "part_spp17") {
        part_spp17();
    } else if (mode == "part_dat1") {
        part_dat1();
    } else if (mode == "part_dat2") {
        part_dat2();
    } else if (mode == "part_dat3") {
        part_dat3();
    } else if (mode == "part_dat4") {
        part_dat4();
    } else if (mode == "part_dat5") {
        part_dat5();
    } else if (mode == "part_dat6") {
        part_dat6();
    } else if (mode == "part_dat7") {
        part_dat7();
    } else if (mode == "part_dat8") {
        part_dat8();
    } else if (mode == "part_dat9") {
        part_dat9();
    } else if (mode == "part_dat10") {
        part_dat10();
    }
}
