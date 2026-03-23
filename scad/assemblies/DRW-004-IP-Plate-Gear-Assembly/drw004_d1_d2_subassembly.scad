// DRW-004 reusable D1/D2 combined subassembly.
// Includes D1, D2, D3, D5, D6, and CP-F2.
// SPDX-License-Identifier: MIT

use <../../assemblies/DRW-004-IP-Plate-Gear-Assembly/drw004_d1_subassembly.scad>
use <../../assemblies/DRW-004-IP-Plate-Gear-Assembly/drw004_d2_subassembly.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/d5_washer.scad>
use <../../parts/DRW-005-Common-Parts/cpf2_fork.scad>

module drw004_d1_d2_subassembly(
    d1_stack_z = 0,
    d5_z = 4.05,
    d2_stack_z = 5.60,
    cpf2_z = 6.90,
    cpf2_rot_z = 25
) {
    drw004_d1_subassembly(
        d3_z = d1_stack_z + 6.0,
        d1_z = d1_stack_z + 3.0,
        d1_rot_z = 90
    );

    color([0.30, 0.26, 0.20])
        translate([0, 0, d5_z])
            part_d5();

    drw004_d2_subassembly(
        d6_z = d2_stack_z,
        d2_z = d2_stack_z + 2.6,
        d2_rot_z = 0
    );

    color([0.30, 0.26, 0.20])
        translate([0, 0, cpf2_z])
            rotate([0, 0, cpf2_rot_z])
                part_cpf2();
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw004_d1_d2_subassembly();
}
