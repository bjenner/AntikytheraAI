// DRW-013 part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-013-Mars/mar1_gear.scad>
use <../parts/DRW-013-Mars/mar2_gear.scad>
use <../parts/DRW-013-Mars/mar3_gear.scad>
use <../parts/DRW-013-Mars/mar4_gear.scad>
use <../parts/DRW-013-Mars/mar5_gear.scad>
use <../parts/DRW-013-Mars/mar6_hub.scad>
use <../parts/DRW-013-Mars/mar7_axle.scad>
use <../parts/DRW-013-Mars/mar8_rivet_pin.scad>
use <../parts/DRW-013-Mars/mar9_hub.scad>
use <../parts/DRW-013-Mars/mar10_disc.scad>
use <../parts/DRW-013-Mars/mar11_sleeve.scad>
use <../parts/DRW-013-Mars/mar12_pointer_arm.scad>
use <../parts/DRW-013-Mars/mar13_orb_large.scad>
use <../parts/DRW-013-Mars/mar14_orb_rod_large.scad>
use <../parts/DRW-013-Mars/mar15_orb_small.scad>
use <../parts/DRW-013-Mars/mar16_orb_rod_small.scad>
use <../parts/DRW-013-Mars/mar17_pointer_ring_outer.scad>
use <../parts/DRW-013-Mars/mar18_pointer_ring_inner.scad>

PART_MODES_DRW013 = [
    "part_mar1", "part_mar2", "part_mar3", "part_mar4", "part_mar5", "part_mar6",
    "part_mar7", "part_mar8", "part_mar9", "part_mar10", "part_mar11", "part_mar12",
    "part_mar13", "part_mar14", "part_mar15", "part_mar16", "part_mar17", "part_mar18"
];

module route_parts_drw013(mode) {
    if (mode == "part_mar1") {
        part_mar1();
    } else if (mode == "part_mar2") {
        part_mar2();
    } else if (mode == "part_mar3") {
        part_mar3();
    } else if (mode == "part_mar4") {
        part_mar4();
    } else if (mode == "part_mar5") {
        part_mar5();
    } else if (mode == "part_mar6") {
        part_mar6();
    } else if (mode == "part_mar7") {
        part_mar7();
    } else if (mode == "part_mar8") {
        part_mar8();
    } else if (mode == "part_mar9") {
        part_mar9();
    } else if (mode == "part_mar10") {
        part_mar10();
    } else if (mode == "part_mar11") {
        part_mar11();
    } else if (mode == "part_mar12") {
        part_mar12();
    } else if (mode == "part_mar13") {
        part_mar13();
    } else if (mode == "part_mar14") {
        part_mar14();
    } else if (mode == "part_mar15") {
        part_mar15();
    } else if (mode == "part_mar16") {
        part_mar16();
    } else if (mode == "part_mar17") {
        part_mar17();
    } else if (mode == "part_mar18") {
        part_mar18();
    }
}
