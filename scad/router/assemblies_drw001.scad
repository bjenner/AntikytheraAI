// DRW-001 assembly router.
// SPDX-License-Identifier: MIT

use <../assemblies/DRW-001-A-Assembly/drw001_sheet1.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_sheet2.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_sheet3.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_sheet4.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_sheet5.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_sheet6.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_sheet7.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_a1_subassembly.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_a1_gear_assembly.scad>
use <../assemblies/DRW-001-A-Assembly/drw001_a8_subassembly.scad>

ASSEMBLY_MODES_DRW001 = [
    "drw001_sheet1", "drw001_sheet2", "drw001_sheet3", "drw001_sheet4", "drw001_sheet5",
    "drw001_sheet5_parts_animate", "drw001_sheet6", "drw001_sheet7", "drw001_a1_subassembly", "drw001_a1_subassembly_exploded",
    "drw001_a1_subassembly_animate", "drw001_a1_gear_assembly", "drw001_a1_gear_assembly_animate",
    "drw001_a8_subassembly"
];

module route_assemblies_drw001(mode, spin_turns, exploded_gap) {
    if (mode == "drw001_sheet1") {
        drw001_sheet1();
    } else if (mode == "drw001_sheet2") {
        drw001_sheet2();
    } else if (mode == "drw001_sheet3") {
        drw001_sheet3();
    } else if (mode == "drw001_sheet4") {
        drw001_sheet4();
    } else if (mode == "drw001_sheet5") {
        drw001_sheet5();
    } else if (mode == "drw001_sheet5_parts_animate") {
        drw001_sheet5_parts_animate(turns = spin_turns);
    } else if (mode == "drw001_sheet6") {
        drw001_sheet6();
    } else if (mode == "drw001_sheet7") {
        drw001_sheet7();
    } else if (mode == "drw001_a1_subassembly") {
        drw001_a1_subassembly();
    } else if (mode == "drw001_a1_subassembly_exploded") {
        drw001_a1_subassembly_exploded(explode = exploded_gap);
    } else if (mode == "drw001_a1_subassembly_animate") {
        drw001_a1_subassembly_spin(explode = exploded_gap, turns = spin_turns);
    } else if (mode == "drw001_a1_gear_assembly") {
        drw001_a1_gear_assembly();
    } else if (mode == "drw001_a1_gear_assembly_animate") {
        drw001_a1_gear_assembly_spin(turns = spin_turns, explode = exploded_gap);
    } else if (mode == "drw001_a8_subassembly") {
        drw001_a8_subassembly();
    }
}
