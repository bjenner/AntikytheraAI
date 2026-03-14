// DRW-012 part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-012-Jupiter/jup1_gear.scad>
use <../parts/DRW-012-Jupiter/jup2_gear.scad>
use <../parts/DRW-012-Jupiter/jup3_gear.scad>
use <../parts/DRW-012-Jupiter/jup4_gear.scad>
use <../parts/DRW-012-Jupiter/jup5_gear.scad>
use <../parts/DRW-012-Jupiter/jup7_hub.scad>
use <../parts/DRW-012-Jupiter/jup8_spacer.scad>
use <../parts/DRW-012-Jupiter/jup9_rivet_pin.scad>
use <../parts/DRW-012-Jupiter/jup10_hub.scad>
use <../parts/DRW-012-Jupiter/jup11_sleeve.scad>
use <../parts/DRW-012-Jupiter/jup13_pointer_arm.scad>
use <../parts/DRW-012-Jupiter/jup14_orb_large.scad>
use <../parts/DRW-012-Jupiter/jup15_orb_rod_large.scad>
use <../parts/DRW-012-Jupiter/jup16_orb_small.scad>
use <../parts/DRW-012-Jupiter/jup17_orb_rod_small.scad>
use <../parts/DRW-012-Jupiter/jup18_pointer_ring_outer.scad>
use <../parts/DRW-012-Jupiter/jup19_pointer_ring_inner.scad>

PART_MODES_DRW012 = [
    "part_jup1", "part_jup2", "part_jup3", "part_jup4", "part_jup5", "part_jup7",
    "part_jup8", "part_jup9", "part_jup10", "part_jup11", "part_jup13", "part_jup14",
    "part_jup15", "part_jup16", "part_jup17", "part_jup18", "part_jup19"
];

module route_parts_drw012(mode) {
    if (mode == "part_jup1") {
        part_jup1();
    } else if (mode == "part_jup2") {
        part_jup2();
    } else if (mode == "part_jup3") {
        part_jup3();
    } else if (mode == "part_jup4") {
        part_jup4();
    } else if (mode == "part_jup5") {
        part_jup5();
    } else if (mode == "part_jup7") {
        part_jup7();
    } else if (mode == "part_jup8") {
        part_jup8();
    } else if (mode == "part_jup9") {
        part_jup9();
    } else if (mode == "part_jup10") {
        part_jup10();
    } else if (mode == "part_jup11") {
        part_jup11();
    } else if (mode == "part_jup13") {
        part_jup13();
    } else if (mode == "part_jup14") {
        part_jup14();
    } else if (mode == "part_jup15") {
        part_jup15();
    } else if (mode == "part_jup16") {
        part_jup16();
    } else if (mode == "part_jup17") {
        part_jup17();
    } else if (mode == "part_jup18") {
        part_jup18();
    } else if (mode == "part_jup19") {
        part_jup19();
    }
}
