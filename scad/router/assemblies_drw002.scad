// DRW-002 assembly router.
// SPDX-License-Identifier: MIT

use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet1.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet2.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet3.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet4.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet5.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet6.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet7.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet8.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet9.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_sheet10.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_b2_subassembly.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_b7_subassembly.scad>
use <../assemblies/DRW-002-B-Wheel-Frame-Assembly/drw002_b9_subassembly.scad>

ASSEMBLY_MODES_DRW002 = [
    "drw002_sheet1", "drw002_sheet2", "drw002_sheet3", "drw002_sheet4", "drw002_sheet5",
    "drw002_sheet6", "drw002_sheet7", "drw002_sheet8", "drw002_sheet9", "drw002_sheet10",
    "drw002_b2_subassembly", "drw002_b7_subassembly", "drw002_b9_subassembly"
];

module route_assemblies_drw002(mode) {
    if (mode == "drw002_sheet1") {
        drw002_sheet1();
    } else if (mode == "drw002_sheet2") {
        drw002_sheet2();
    } else if (mode == "drw002_sheet3") {
        drw002_sheet3();
    } else if (mode == "drw002_sheet4") {
        drw002_sheet4();
    } else if (mode == "drw002_sheet5") {
        drw002_sheet5();
    } else if (mode == "drw002_sheet6") {
        drw002_sheet6();
    } else if (mode == "drw002_sheet7") {
        drw002_sheet7();
    } else if (mode == "drw002_sheet8") {
        drw002_sheet8();
    } else if (mode == "drw002_sheet9") {
        drw002_sheet9();
    } else if (mode == "drw002_sheet10") {
        drw002_sheet10();
    } else if (mode == "drw002_b2_subassembly") {
        drw002_b2_subassembly();
    } else if (mode == "drw002_b7_subassembly") {
        drw002_b7_subassembly();
    } else if (mode == "drw002_b9_subassembly") {
        drw002_b9_subassembly();
    }
}
