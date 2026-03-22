// DRW-004 assembly router.
// SPDX-License-Identifier: MIT

use <../assemblies/DRW-004-IP-Plate-Gear-Assembly/drw004_c1_c2_subassembly.scad>

ASSEMBLY_MODES_DRW004 = ["drw004_c1_c2_subassembly"];

module route_assemblies_drw004(mode) {
    if (mode == "drw004_c1_c2_subassembly") {
        drw004_c1_c2_subassembly();
    }
}
