// DRW-021 assembly router.
// SPDX-License-Identifier: MIT

use <../assemblies/DRW-021-Sun/drw021_true_sun_axle_subassembly.scad>

ASSEMBLY_MODES_DRW021 = [
    "drw021_true_sun_axle_subassembly"
];

module route_assemblies_drw021(mode) {
    if (mode == "drw021_true_sun_axle_subassembly") {
        drw021_true_sun_axle_subassembly();
    }
}
