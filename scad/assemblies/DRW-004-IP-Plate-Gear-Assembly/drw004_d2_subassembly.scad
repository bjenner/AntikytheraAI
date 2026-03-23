// DRW-004 reusable D2 subassembly.
// D2 gear pressed onto D6 disk.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-004-IP-Plate-Gear-Assembly/d2_gear.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/d6_disk.scad>

module drw004_d2_subassembly(
    d6_z = 0,
    d2_z = 2.6,
    d2_rot_z = 0
) {
    color([0.30, 0.26, 0.20])
        translate([0, 0, d6_z])
            part_d6();

    color([0.45, 0.30, 0.18])
        translate([0, 0, d2_z])
            rotate([0, 0, d2_rot_z])
                part_d2();
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw004_d2_subassembly();
}
