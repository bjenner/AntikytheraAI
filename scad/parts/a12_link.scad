// part_id: a12
// name: A12 link
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a12(th = 1.0) {
    linear_extrude(height = th)
        difference() {
            hull() {
                translate([-5, 0]) circle(r = 4.5, $fn = 64);
                translate([ 5, 0]) circle(r = 5.0, $fn = 64);
            }
            translate([-5, 0]) circle(d = 3.0, $fn = 48);
            translate([ 5, 0]) circle(d = 3.0, $fn = 48);
        }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a12();
}
