// part_id: mar14
// name: Mars pointer orb rod large
// source_drawing_ids: DRW-013
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_mar14(d = 1.5, h = 10.4) {
    cylinder(d = d, h = h, center = false, $fn = 24);
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_mar14();
}
