// part_id: b1
// name: B1 main wheel plate
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b1_wheel_2d(outer_d = 132, root_d = 128, tooth_count = 180,
                   hub_d = 11.0, hole_d = 3.0) {
    difference() {
        union() {
            // Toothed outer ring.
            circle(d = root_d, $fn = 220);
            for (i = [0 : tooth_count - 1])
                rotate(i * 360 / tooth_count)
                    translate([outer_d / 2 - 0.35, 0])
                        square([0.75, 0.75], center = true);

            // Cross braces and center hub field.
            for (a = [0, 90]) rotate(a) square([88, 10], center = true);
            circle(d = 24, $fn = 90);
        }

        // Central bore.
        circle(d = hub_d, $fn = 48);

        // Four big quadrant cutouts.
        for (a = [45, 135, 225, 315])
            rotate(a) translate([34, 0]) offset(r = 3) square([42, 28], center = true);

        // Auxiliary hole pattern.
        for (a = [0, 90, 180, 270])
            rotate(a) translate([18, 0]) circle(d = hole_d, $fn = 28);
        for (a = [30, 150, 210, 330])
            rotate(a) translate([53, 0]) circle(d = 4.0, $fn = 28);
    }
}

module part_b1(thickness = 2.0) {
    linear_extrude(height = thickness)
        b1_wheel_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b1();
}
