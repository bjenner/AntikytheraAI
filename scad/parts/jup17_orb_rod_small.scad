// part_id: jup17
// name: Jupiter orb rod small
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup17(d = 1.0, h = 14.4) {
    cylinder(d = d, h = h, center = false, $fn = 20);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup17();
}
