// DRW-001 part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-001-A-Assembly/a1.scad>
use <../parts/DRW-001-A-Assembly/a2_ring.scad>
use <../parts/DRW-001-A-Assembly/a3_pin.scad>
use <../parts/DRW-001-A-Assembly/a4_block.scad>
use <../parts/DRW-001-A-Assembly/a5_ring.scad>
use <../parts/DRW-001-A-Assembly/a6_bush.scad>
use <../parts/DRW-001-A-Assembly/a7_block.scad>
use <../parts/DRW-001-A-Assembly/a8_rivet_pin.scad>
use <../parts/DRW-001-A-Assembly/a9_axle.scad>
use <../parts/DRW-001-A-Assembly/a10_disc.scad>
use <../parts/DRW-001-A-Assembly/a11_gear_lock.scad>
use <../parts/DRW-001-A-Assembly/a12_link.scad>

PART_MODES_DRW001 = [
    "part_a1", "part_a2", "part_a3", "part_a4", "part_a5", "part_a6",
    "part_a7", "part_a8", "part_a9", "part_a10", "part_a11", "part_a12"
];

module route_parts_drw001(mode) {
    if (mode == "part_a1") {
        part_a1();
    } else if (mode == "part_a2") {
        part_a2();
    } else if (mode == "part_a3") {
        part_a3();
    } else if (mode == "part_a4") {
        part_a4();
    } else if (mode == "part_a5") {
        part_a5();
    } else if (mode == "part_a6") {
        part_a6();
    } else if (mode == "part_a7") {
        part_a7();
    } else if (mode == "part_a8") {
        part_a8();
    } else if (mode == "part_a9") {
        part_a9();
    } else if (mode == "part_a10") {
        part_a10();
    } else if (mode == "part_a11") {
        part_a11();
    } else if (mode == "part_a12") {
        part_a12();
    }
}
