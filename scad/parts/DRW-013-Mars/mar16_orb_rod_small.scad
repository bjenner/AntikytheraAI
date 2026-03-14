// part_id: mar16
// name: Mars pointer orb rod small
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar16(d = 1.0, h = 10.4) {
    cylinder(d = d, h = h, center = false, $fn = 24);
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar16();
}
