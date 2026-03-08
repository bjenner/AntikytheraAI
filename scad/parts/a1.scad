// Part A1: toothed gear disc with keyed center cutout.
// SPDX-License-Identifier: MIT

function a1_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

// Cleaned tooth profile with explicit root/flank/tip segments.
// Radii align to DRW-001 callouts:
// R14.1 (tip), R13.7 (upper flank), R12.8 (mid flank), R12.4 (root).
module a1_gear_profile_2d(teeth = 56, r_tip = 14.1, r_flank = 13.7, r_mid = 12.8, r_root = 12.4) {
    step = 360 / teeth;

    union() {
        // Root body.
        circle(r = r_root, $fn = max(240, teeth * 6));

        // Trapezoid-like teeth with a small flat at the tip.
        for (i = [0 : teeth - 1]) {
            a = i * step;
            polygon(points = [
                a1_polar(r_root,  a - 0.48 * step),
                a1_polar(r_mid,   a - 0.34 * step),
                a1_polar(r_flank, a - 0.21 * step),
                a1_polar(r_tip,   a - 0.07 * step),
                a1_polar(r_tip,   a + 0.07 * step),
                a1_polar(r_flank, a + 0.21 * step),
                a1_polar(r_mid,   a + 0.34 * step),
                a1_polar(r_root,  a + 0.48 * step)
            ]);
        }
    }
}

module a1_center_cutout_2d(bore_d = 5.0, key_r = 1.0, key_dx = 1.65, key_dy = -1.9, paired_detents = true) {
    union() {
        circle(d = bore_d, $fn = 60);
        // Auxiliary detent feature.
        translate([key_dx, key_dy]) circle(r = key_r, $fn = 48);
        // Opposed detent for symmetric keyed profile.
        if (paired_detents) {
            translate([-key_dx, -key_dy]) circle(r = key_r, $fn = 48);
        }
    }
}

module part_a1(
    body_d = 28.2,
    thickness = 2.0,
    bore_d = 5.0,
    spoke_count = 6,   // legacy compatibility; no longer used for geometry.
    teeth = 56,
    flank_offset = 0.4,
    mid_offset = 1.3,
    root_offset = 1.7,
    tooth_edge_angle_deg = 78
) {
    tip_r = body_d / 2;
    flank_r = tip_r - flank_offset;
    mid_r = tip_r - mid_offset;
    root_r = tip_r - root_offset;
    // 78 deg edge angle interpreted from the part axis (vertical),
    // equivalent to 12 deg draft from a vertical wall.
    draft_deg = max(0, 90 - tooth_edge_angle_deg);
    draft_delta = thickness * tan(draft_deg);
    top_scale = max(0.5, (tip_r - draft_delta) / tip_r);

    difference() {
        linear_extrude(height = thickness, scale = top_scale)
            a1_gear_profile_2d(
                teeth = teeth,
                r_tip = tip_r,
                r_flank = flank_r,
                r_mid = mid_r,
                r_root = root_r
            );

        translate([0, 0, -0.1])
            linear_extrude(height = thickness + 0.2)
                a1_center_cutout_2d(bore_d = bore_d);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a1();
}
