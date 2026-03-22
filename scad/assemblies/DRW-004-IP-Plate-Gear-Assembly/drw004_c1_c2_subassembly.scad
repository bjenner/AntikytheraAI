// DRW-004 reusable C1/C2 subassembly.
// Centered on the gear axis at origin for easy reuse in sheet scenes.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-004-IP-Plate-Gear-Assembly/c1_gear.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/c2_gear.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/c3_pin.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/c4_bush.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/c6_washer.scad>
use <../../parts/DRW-005-Common-Parts/cpf3_fork.scad>

module drw004_c1_c2_subassembly(
    show_c1 = true,
    show_cpf3 = true,
    c1_z = -1.05,
    c2_z = 1.05,
    pin_pcd_r = 6.5,
    pin_z = 0,
    c4_z = 2.3,
    c4_rot_z = 270,
    c6_z = 5.3,
    c6_rot_z = 90,
    cpf3_z = 4.1+1,
    cpf3_rot_x = 0,
    cpf3_rot_y = 0,
    cpf3_rot_z = 90
) {
    color([0.45, 0.30, 0.18])
        translate([0, 0, c2_z])
            part_c2();

    if (show_c1) {
        color([0.45, 0.30, 0.18])
            translate([0, 0, c1_z])
                part_c1();
    }

    color([0.30, 0.26, 0.20])
        translate([0, 0, c4_z])
            rotate([0, 0, c4_rot_z])
                part_c4();

    color([0.30, 0.26, 0.20])
        translate([0, 0, c6_z])
            rotate([180, 0, c6_rot_z])
                part_c6();

    if (show_cpf3) {
        color([0.45, 0.30, 0.18])
            translate([0, 0, cpf3_z])
                rotate([cpf3_rot_x, cpf3_rot_y, cpf3_rot_z])
                    part_cpf3();
    }

    color([0.30, 0.26, 0.20])
        for (x = [-pin_pcd_r, pin_pcd_r])
            translate([x, 0, pin_z])
                part_c3();
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw004_c1_c2_subassembly();
}
