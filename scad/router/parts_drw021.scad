// DRW-021 part router.
// SPDX-License-Identifier: MIT

use <../parts/DRW-021-Sun/sun16_pointer_arm.scad>
use <../parts/DRW-021-Sun/sun17_slotted_shaft.scad>

PART_MODES_DRW021 = [
    "part_sun16", "part_sun17"
];

module route_parts_drw021(mode) {
    if (mode == "part_sun16") {
        part_sun16();
    } else if (mode == "part_sun17") {
        part_sun17();
    }
}
