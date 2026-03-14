// DRW-008 part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-022-Superior-Planet-Plate/sat6_date_pointer_axle.scad>
use <../parts/DRW-022-Superior-Planet-Plate/spp17_date_pointer_base.scad>
use <../parts/DRW-008-Date/dat1_pointer.scad>
use <../parts/DRW-008-Date/dat2_pin.scad>
use <../parts/DRW-008-Date/dat3_ball_tip.scad>
use <../parts/DRW-008-Date/dat4_post.scad>
use <../parts/DRW-008-Date/dat5_ball_tip_small.scad>
use <../parts/DRW-008-Date/dat6_post_small.scad>
use <../parts/DRW-008-Date/dat7_ring.scad>
use <../parts/DRW-008-Date/dat8_ring.scad>
use <../parts/DRW-008-Date/dat9_base_plate.scad>
use <../parts/DRW-008-Date/dat10_spoked_wheel.scad>

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
