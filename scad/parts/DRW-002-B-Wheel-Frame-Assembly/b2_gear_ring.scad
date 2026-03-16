// part_id: b2
// name: B2 gear ring
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.4
// SPDX-License-Identifier: MIT

module b2_trial_tooth_2d(base_r = 14.55, tip_r = 16.15, half_base_w = 0.52) {
    polygon(points = [
        [-half_base_w, base_r],
        [half_base_w, base_r],
        [0, tip_r]
    ]);
}

module b2_teeth_2d(tooth_count = 64, clip_r = 15.50) {
    pitch_deg = 360 / tooth_count;

    intersection() {
        union() {
            for (i = [0 : tooth_count - 1])
                rotate(i * pitch_deg) b2_trial_tooth_2d();
        }
        circle(r = clip_r, $fn = 180);
    }
}

module b2_gear_2d(
    root_d = 29.10,
    center_d = 11.0,
    rivet_d = 3.0,
    rivet_pitch = 20.0
) {
    difference() {
        union() {
            circle(d = root_d, $fn = 180);
            b2_teeth_2d();
        }
        circle(d = center_d, $fn = 60);
        for (a = [0, 90, 180, 270])
            rotate(a) translate([rivet_pitch / 2, 0]) circle(d = rivet_d, $fn = 28);
    }
}

module part_b2(thickness = 2.0) {
    translate([0, 0, -thickness / 2])
        linear_extrude(height = thickness)
            b2_gear_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b2();
}
