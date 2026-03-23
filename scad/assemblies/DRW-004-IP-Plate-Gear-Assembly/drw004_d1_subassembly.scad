// DRW-004 reusable D1 subassembly.
// D1 gear friction-fit onto D3 pin.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-004-IP-Plate-Gear-Assembly/d1_gear.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/d3_pin.scad>

module drw004_d1_subassembly(
    d1_z = 3.0,
    d1_rot_z = 90,
    d3_z = 0.3,
    d3_rot_x = 180
) {
    color([0.45, 0.30, 0.18])
        translate([0, 0, d1_z])
            rotate([0, 0, d1_rot_z])
                part_d1();

    color([0.30, 0.26, 0.20])
        translate([0, 0, d3_z])
            rotate([d3_rot_x, 0, 0])
                part_d3();
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw004_d1_subassembly();
}
