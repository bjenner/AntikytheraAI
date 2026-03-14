// part_id: b10
// name: B10 disc plate
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b10_center_bore_2d(
    center_r = 4.5,
    lobe_r = 1.0,
    lobe_offset = 4.0
) {
    union() {
        circle(r = center_r, $fn = 64);
        for (sy = [-1, 1])
            translate([0, sy * lobe_offset])
                circle(r = lobe_r, $fn = 32);
    }
}

module b10_profile_2d(
    od = 30,
    center_r = 4.5,
    lobe_r = 1.0,
    lobe_offset = 4.0,
    hole_d = 4,
    hole_pitch = 20
) {
    difference() {
        circle(d = od, $fn = 96);
        b10_center_bore_2d(center_r = center_r, lobe_r = lobe_r, lobe_offset = lobe_offset);
        for (a = [90, 270])
            rotate(a) translate([hole_pitch / 2, 0]) circle(d = hole_d, $fn = 32);
    }
}

module part_b10(od = 30, thickness = 2.0) {
    linear_extrude(height = thickness)
        b10_profile_2d(od = od);
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b10();
}
