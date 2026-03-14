// part_id: dat9
// name: Date dial base plate with annular scale field
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module dat9_scale_ticks(r = 61, n = 120, len_major = 3.2, len_minor = 1.5, w = 0.45) {
    for (i = [0 : n - 1]) {
        a = i * 360 / n;
        lm = (i % 10 == 0) ? len_major : len_minor;
        rotate([0, 0, a]) translate([r, 0, 0]) square([lm, w], center = true);
    }
}

module dat9_plate_2d(
    w = 224,
    h = 150,
    corner_r = 2,
    ring_od = 132,
    ring_id = 102,
    center_bore_d = 8,
    mount_hole_d = 3,
    panel_split_x = 38,
    panel_split_x2 = -38
) {
    difference() {
        minkowski() {
            square([w - 2 * corner_r, h - 2 * corner_r], center = true);
            circle(r = corner_r, $fn = 24);
        }

        // Corner mount holes
        for (sx = [-1, 1], sy = [-1, 1]) {
            translate([sx * (w / 2 - 8), sy * (h / 2 - 8)]) circle(d = mount_hole_d, $fn = 24);
        }

        // Center bore
        circle(d = center_bore_d, $fn = 48);

        // Ring region cut tracks to visually mimic scale annulus
        circle(d = ring_od, $fn = 120);
        circle(d = ring_id, $fn = 120);

        // Auxiliary holes in central region
        for (a = [18 : 36 : 342]) {
            translate([28 * cos(a), 28 * sin(a)]) circle(d = 2.1, $fn = 20);
        }
        for (a = [0 : 30 : 330]) {
            translate([45 * cos(a), 45 * sin(a)]) circle(d = 2.8, $fn = 20);
        }
    }

    // panel split lines
    translate([panel_split_x, 0]) square([0.5, h - 8], center = true);
    translate([panel_split_x2, 0]) square([0.5, h - 8], center = true);
}

module part_dat9(thickness = 2.0) {
    linear_extrude(height = thickness)
    difference() {
        dat9_plate_2d();
        // Subtract a narrow band where tick marks go; then add them in top layer separately if needed.
    }

    // Slightly raised ring and tick field.
    translate([0, 0, thickness])
    linear_extrude(height = 0.3)
    difference() {
        circle(d = 132, $fn = 140);
        circle(d = 102, $fn = 140);
    }

    translate([0, 0, thickness + 0.3])
    linear_extrude(height = 0.15)
    intersection() {
        dat9_scale_ticks();
        difference() {
            circle(d = 130, $fn = 140);
            circle(d = 104, $fn = 140);
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_dat9();
}
