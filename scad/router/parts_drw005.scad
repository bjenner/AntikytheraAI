// DRW-005 part router.
// SPDX-License-Identifier: MIT

use <../parts/cp1_pointer_small.scad>
use <../parts/cp2_slider.scad>
use <../parts/cp3_rivet.scad>
use <../parts/cp4_stopper.scad>
use <../parts/cp5_spacer.scad>
use <../parts/cp6_bush.scad>
use <../parts/cp7_bush.scad>
use <../parts/cp8_pin.scad>
use <../parts/cp9_pin.scad>
use <../parts/cpr1_rivet.scad>
use <../parts/cpr2_rivet.scad>
use <../parts/cpr3_rivet.scad>
use <../parts/cpr4_rivet.scad>
use <../parts/cpr5_rivet.scad>
use <../parts/cpr6_rivet.scad>
use <../parts/cpf1_fork.scad>
use <../parts/cpf2_fork.scad>
use <../parts/cpf3_fork.scad>
use <../parts/cpf4_fork.scad>
use <../parts/cpf5_fork.scad>
use <../parts/cpf6_fork.scad>

PART_MODES_DRW005 = [
    "part_cp1", "part_cp2", "part_cp3", "part_cp4", "part_cp5", "part_cp6",
    "part_cp7", "part_cp8", "part_cp9", "part_cpr1", "part_cpr2", "part_cpr3",
    "part_cpr4", "part_cpr5", "part_cpr6", "part_cpf1", "part_cpf2", "part_cpf3",
    "part_cpf4", "part_cpf5", "part_cpf6"
];

module route_parts_drw005(mode) {
    if (mode == "part_cp1") {
        part_cp1();
    } else if (mode == "part_cp2") {
        part_cp2();
    } else if (mode == "part_cp3") {
        part_cp3();
    } else if (mode == "part_cp4") {
        part_cp4();
    } else if (mode == "part_cp5") {
        part_cp5();
    } else if (mode == "part_cp6") {
        part_cp6();
    } else if (mode == "part_cp7") {
        part_cp7();
    } else if (mode == "part_cp8") {
        part_cp8();
    } else if (mode == "part_cp9") {
        part_cp9();
    } else if (mode == "part_cpr1") {
        part_cpr1();
    } else if (mode == "part_cpr2") {
        part_cpr2();
    } else if (mode == "part_cpr3") {
        part_cpr3();
    } else if (mode == "part_cpr4") {
        part_cpr4();
    } else if (mode == "part_cpr5") {
        part_cpr5();
    } else if (mode == "part_cpr6") {
        part_cpr6();
    } else if (mode == "part_cpf1") {
        part_cpf1();
    } else if (mode == "part_cpf2") {
        part_cpf2();
    } else if (mode == "part_cpf3") {
        part_cpf3();
    } else if (mode == "part_cpf4") {
        part_cpf4();
    } else if (mode == "part_cpf5") {
        part_cpf5();
    } else if (mode == "part_cpf6") {
        part_cpf6();
    }
}
