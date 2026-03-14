// part_id: b6
// name: B6 clip block
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module chamfered_rect_2d(w = 5.0, d = 3.0, c = 0.3) {
    polygon(points = [
        [-w / 2 + c, -d / 2],
        [ w / 2 - c, -d / 2],
        [ w / 2, -d / 2 + c],
        [ w / 2,  d / 2 - c],
        [ w / 2 - c,  d / 2],
        [-w / 2 + c,  d / 2],
        [-w / 2,  d / 2 - c],
        [-w / 2, -d / 2 + c]
    ]);
}

module part_b6(
    w = 5.0,
    d = 3.0,
    h = 5.3,
    pin_d = 2.5,
    pin_h = 2.0,
    hole_d = 2.5,
    hole_center_z = 3.0,
    edge_chamfer = 0.3
) {
    difference() {
        union() {
            // Main body with a small vertical edge chamfer.
            translate([0, 0, pin_h])
                linear_extrude(height = h)
                    chamfered_rect_2d(w = w, d = d, c = edge_chamfer);
            // Bottom fitted pin.
            cylinder(d = pin_d, h = pin_h, center = false, $fn = 36);
        }

        // Through-hole for the fitted pin/slot pair.
        translate([0, 0, pin_h + h - hole_center_z])
            rotate([90, 0, 0])
                cylinder(d = hole_d, h = d + 0.2, center = true, $fn = 36);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b6();
}
