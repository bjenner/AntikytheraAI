// part_id: cp-f2
// name: Fork 2W 4D 6L 7T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

use <cpf_fork_common.scad>

module part_cpf2(th = 1.0) {
    cpf_fork_part(
        body_r = 4.0,
        slot_w = 2.0,
        slot_l = 6.0,
        overall_w = 6.0,
        overall_l = 7.0,
        shoulder_r = 2.0,
        tip_r = 0.4,
        thickness = th
    );
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf2();
}
