// DRW-022 part router.
// SPDX-License-Identifier: MIT

use <../parts/sp1_superior_gear.scad>
use <../parts/sp2_gear_axle_subassembly.scad>
use <../parts/sp3_superior_plate.scad>
use <../parts/sp4_press_pin.scad>
use <../parts/sp5_superior_plate.scad>
use <../parts/sp6_rivet_pin.scad>
use <../parts/sp7_companion_gear.scad>
use <../parts/sp8_large_gear.scad>
use <../parts/sp9_latch.scad>
use <../parts/sp10_disc.scad>

PART_MODES_DRW022 = [
    "part_sp1", "part_sp2", "part_sp3", "part_sp4", "part_sp5",
    "part_sp6", "part_sp7", "part_sp8", "part_sp9", "part_sp10"
];

module route_parts_drw022(mode) {
    if (mode == "part_sp1") {
        part_sp1();
    } else if (mode == "part_sp2") {
        part_sp2();
    } else if (mode == "part_sp3") {
        part_sp3();
    } else if (mode == "part_sp4") {
        part_sp4();
    } else if (mode == "part_sp5") {
        part_sp5();
    } else if (mode == "part_sp6") {
        part_sp6();
    } else if (mode == "part_sp7") {
        part_sp7();
    } else if (mode == "part_sp8") {
        part_sp8();
    } else if (mode == "part_sp9") {
        part_sp9();
    } else if (mode == "part_sp10") {
        part_sp10();
    }
}
