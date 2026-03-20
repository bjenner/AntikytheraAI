// part_id: cp-f5
// name: Fork 3W 12D 12L 12T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

use <cpf_fork_common.scad>

module part_cpf5(th = 1.0) {
    cpf_fork_part(
        body_r = 6.0,
        slot_w = 3.0,
        slot_l = 12.0,
        overall_w = 8.5,
        overall_l = 12.0,
        shoulder_r = 3.0,
        tip_r = 0.5,
        thickness = th
    );
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf5();
}
