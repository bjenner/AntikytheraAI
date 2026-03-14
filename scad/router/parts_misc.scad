// Misc part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-009-Exeligmos/i1_gear.scad>
use <../parts/DRW-009-Exeligmos/i2_hub.scad>
use <../parts/DRW-009-Exeligmos/h1_gear.scad>
use <../parts/DRW-009-Exeligmos/h2_pinion.scad>
use <../parts/DRW-009-Exeligmos/h3_hub.scad>
use <../parts/DRW-009-Exeligmos/exe1_rivet_pin.scad>
use <../parts/DRW-009-Exeligmos/g2_pinion.scad>

PART_MODES_MISC = [
    "part_i1", "part_i2", "part_h1", "part_h2", "part_h3", "part_exe1", "part_g2"
];

module route_parts_misc(mode) {
    if (mode == "part_i1") {
        part_i1();
    } else if (mode == "part_i2") {
        part_i2();
    } else if (mode == "part_h1") {
        part_h1();
    } else if (mode == "part_h2") {
        part_h2();
    } else if (mode == "part_h3") {
        part_h3();
    } else if (mode == "part_exe1") {
        part_exe1();
    } else if (mode == "part_g2") {
        part_g2();
    }
}
