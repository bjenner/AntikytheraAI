// Misc drawing assembly router.
// SPDX-License-Identifier: MIT

use <../assemblies/drw005_sheet1.scad>
use <../assemblies/drw005_sheet2.scad>
use <../assemblies/drw005_sheet3.scad>
use <../assemblies/drw008_sheet1.scad>
use <../assemblies/drw008_sheet2.scad>
use <../assemblies/drw008_sheet3.scad>
use <../assemblies/drw008_sheet4.scad>
use <../assemblies/drw008_sheet5.scad>
use <../assemblies/drw009_sheet1.scad>
use <../assemblies/drw009_sheet2.scad>
use <../assemblies/drw009_sheet3.scad>
use <../assemblies/drw009_sheet4.scad>
use <../assemblies/drw009_sheet5.scad>
use <../assemblies/drw009_sheet6.scad>
use <../assemblies/drw010_sheet1.scad>
use <../assemblies/drw010_sheet2.scad>
use <../assemblies/drw010_sheet4.scad>
use <../assemblies/drw010_sheet5.scad>
use <../assemblies/drw010_sheet6.scad>
use <../assemblies/drw010_sheet7.scad>
use <../assemblies/drw010_sheet8.scad>
use <../assemblies/drw010_sheet9.scad>
use <../assemblies/drw012_sheet2.scad>
use <../assemblies/drw012_sheet4.scad>
use <../assemblies/drw012_sheet5.scad>
use <../assemblies/drw012_sheet6.scad>
use <../assemblies/drw012_sheet7.scad>
use <../assemblies/drw012_sheet8.scad>
use <../assemblies/drw012_sheet9.scad>
use <../assemblies/drw013_sheet4.scad>
use <../assemblies/drw013_sheet5.scad>
use <../assemblies/drw013_sheet6.scad>
use <../assemblies/drw013_sheet7.scad>
use <../assemblies/drw022_sheet1.scad>
use <../assemblies/drw022_sheet2.scad>
use <../assemblies/drw022_sheet3.scad>
use <../assemblies/drw022_sheet4.scad>
use <../assemblies/drw022_sheet5.scad>
use <../assemblies/drw022_sheet6.scad>
use <../assemblies/drw022_sheet7.scad>

ASSEMBLY_MODES_MISC = [
    "drw005_sheet1", "drw005_sheet2", "drw005_sheet3",
    "drw008_sheet1", "drw008_sheet2", "drw008_sheet3", "drw008_sheet4", "drw008_sheet5",
    "drw009_sheet1", "drw009_sheet2", "drw009_sheet3", "drw009_sheet4", "drw009_sheet5", "drw009_sheet6",
    "drw010_sheet1", "drw010_sheet2", "drw010_sheet4", "drw010_sheet5", "drw010_sheet6", "drw010_sheet7", "drw010_sheet8", "drw010_sheet9",
    "drw012_sheet2", "drw012_sheet4", "drw012_sheet5", "drw012_sheet6", "drw012_sheet7", "drw012_sheet8", "drw012_sheet9",
    "drw013_sheet4", "drw013_sheet5", "drw013_sheet6", "drw013_sheet7",
    "drw022_sheet1", "drw022_sheet2", "drw022_sheet3", "drw022_sheet4", "drw022_sheet5", "drw022_sheet6", "drw022_sheet7"
];

module route_assemblies_misc(mode) {
    if (mode == "drw005_sheet1") {
        drw005_sheet1();
    } else if (mode == "drw005_sheet2") {
        drw005_sheet2();
    } else if (mode == "drw005_sheet3") {
        drw005_sheet3();
    } else if (mode == "drw008_sheet1") {
        drw008_sheet1();
    } else if (mode == "drw008_sheet2") {
        drw008_sheet2();
    } else if (mode == "drw008_sheet3") {
        drw008_sheet3();
    } else if (mode == "drw008_sheet4") {
        drw008_sheet4();
    } else if (mode == "drw008_sheet5") {
        drw008_sheet5();
    } else if (mode == "drw009_sheet1") {
        drw009_sheet1();
    } else if (mode == "drw009_sheet2") {
        drw009_sheet2();
    } else if (mode == "drw009_sheet3") {
        drw009_sheet3();
    } else if (mode == "drw009_sheet4") {
        drw009_sheet4();
    } else if (mode == "drw009_sheet5") {
        drw009_sheet5();
    } else if (mode == "drw009_sheet6") {
        drw009_sheet6();
    } else if (mode == "drw010_sheet1") {
        drw010_sheet1();
    } else if (mode == "drw010_sheet2") {
        drw010_sheet2();
    } else if (mode == "drw010_sheet4") {
        drw010_sheet4();
    } else if (mode == "drw010_sheet5") {
        drw010_sheet5();
    } else if (mode == "drw010_sheet6") {
        drw010_sheet6();
    } else if (mode == "drw010_sheet7") {
        drw010_sheet7();
    } else if (mode == "drw010_sheet8") {
        drw010_sheet8();
    } else if (mode == "drw010_sheet9") {
        drw010_sheet9();
    } else if (mode == "drw012_sheet2") {
        drw012_sheet2();
    } else if (mode == "drw012_sheet4") {
        drw012_sheet4();
    } else if (mode == "drw012_sheet5") {
        drw012_sheet5();
    } else if (mode == "drw012_sheet6") {
        drw012_sheet6();
    } else if (mode == "drw012_sheet7") {
        drw012_sheet7();
    } else if (mode == "drw012_sheet8") {
        drw012_sheet8();
    } else if (mode == "drw012_sheet9") {
        drw012_sheet9();
    } else if (mode == "drw013_sheet4") {
        drw013_sheet4();
    } else if (mode == "drw013_sheet5") {
        drw013_sheet5();
    } else if (mode == "drw013_sheet6") {
        drw013_sheet6();
    } else if (mode == "drw013_sheet7") {
        drw013_sheet7();
    } else if (mode == "drw022_sheet1") {
        drw022_sheet1();
    } else if (mode == "drw022_sheet2") {
        drw022_sheet2();
    } else if (mode == "drw022_sheet3") {
        drw022_sheet3();
    } else if (mode == "drw022_sheet4") {
        drw022_sheet4();
    } else if (mode == "drw022_sheet5") {
        drw022_sheet5();
    } else if (mode == "drw022_sheet6") {
        drw022_sheet6();
    } else if (mode == "drw022_sheet7") {
        drw022_sheet7();
    }
}
