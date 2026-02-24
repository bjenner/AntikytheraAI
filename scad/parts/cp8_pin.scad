// part_id: cp8
// name: Pin D1.5
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cp8(d = 1.5, h = 3.5) {
    cylinder(d = d, h = h, center = false, $fn = 24);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cp8();
}
