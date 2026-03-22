// DRW-004 part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-004-IP-Plate-Gear-Assembly/c1_gear.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/c2_gear.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/c3_pin.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/c4_bush.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/c5_washer.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/c6_washer.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/d1_gear.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/d2_gear.scad>
use <../parts/DRW-004-IP-Plate-Gear-Assembly/d3_pin.scad>

PART_MODES_DRW004 = ["part_c1", "part_c2", "part_c3", "part_c4", "part_c5", "part_c6", "part_d1", "part_d2", "part_d3"];

module route_parts_drw004(mode) {
    if (mode == "part_c1") {
        part_c1();
    } else if (mode == "part_c2") {
        part_c2();
    } else if (mode == "part_c3") {
        part_c3();
    } else if (mode == "part_c4") {
        part_c4();
    } else if (mode == "part_c5") {
        part_c5();
    } else if (mode == "part_c6") {
        part_c6();
    } else if (mode == "part_d1") {
        part_d1();
    } else if (mode == "part_d2") {
        part_d2();
    } else if (mode == "part_d3") {
        part_d3();
    }
}
