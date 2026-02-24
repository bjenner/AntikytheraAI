// part_id: b14
// name: B14 pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b14(d = 1.5, h = 5.0) {
    cylinder(d = d, h = h, center = false, $fn = 30);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b14();
}
