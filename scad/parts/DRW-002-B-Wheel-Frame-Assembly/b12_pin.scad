// part_id: b12
// name: B12 pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b12(d = 3.0, h = 9.0, edge_r = 0.5) {
    // Slightly softened cylinder for press/rivet pin visual.
    translate([0, 0, -h / 2])
        minkowski() {
            cylinder(d = d - 2 * edge_r, h = h - 2 * edge_r, center = false, $fn = 42);
            sphere(r = edge_r, $fn = 18);
        }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b12();
}
