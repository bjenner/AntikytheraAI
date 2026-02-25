// part_id: jup15
// name: Jupiter orb rod large
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup15(d = 1.5, h = 14.3) {
    cylinder(d = d, h = h, center = false, $fn = 24);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup15();
}
