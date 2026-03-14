// part_id: b16
// name: B16 rivet
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b16(body_d = 2.0, body_h = 3.0, taper_angle = 10, tip_r = 0.75) {
    taper_half_angle = taper_angle / 2;
    taper_h = max(0.1, body_h - tip_r);
    lower_d = max(2 * tip_r, body_d - 2 * taper_h * tan(taper_half_angle));

    union() {
        translate([0, 0, tip_r])
            cylinder(d1 = lower_d, d2 = body_d, h = taper_h, center = false, $fn = 48);
        translate([0, 0, tip_r])
            sphere(r = tip_r, $fn = 40);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b16();
}
