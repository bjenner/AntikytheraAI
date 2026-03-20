// part_id: cp-f6
// name: Fork 3W 10L 6D 10T
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

use <cpf_fork_common.scad>

module part_cpf6(th = 1.0) {
    cpf_fork_part(
        body_r = 5.0,
        slot_w = 3.0,
        slot_l = 10.0,
        overall_w = 6.6,
        overall_l = 10.0,
        shoulder_r = 3.0,
        tip_r = 0.3,
        thickness = th
    );
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cpf6();
}
