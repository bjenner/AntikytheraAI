// part_id: b3
// name: B3 companion gear
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

function b3_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

module b3_tooth_2d(
    outer_r = 8.60,
    root_r = 7.48,
    pitch_deg = 11.25,
    // Preserve more of the R7.48 root circle so the tooth valleys do not
    // collapse into sharp V-notches in the rendered profile.
    root_ratio = 0.88,
    tip_ratio = 0.34,
    shoulder_ratio = 0.62
) {
    tip_half_deg = pitch_deg * tip_ratio / 2;
    shoulder_half_deg = pitch_deg * shoulder_ratio / 2;
    root_half_deg = pitch_deg * root_ratio / 2;
    shoulder_r = root_r + (outer_r - root_r) * 0.58;

    polygon(points = [
        b3_polar(root_r, -root_half_deg),
        b3_polar(shoulder_r, -shoulder_half_deg),
        b3_polar(outer_r, -tip_half_deg),
        b3_polar(outer_r, tip_half_deg),
        b3_polar(shoulder_r, shoulder_half_deg),
        b3_polar(root_r, root_half_deg)
    ]);
}

module b3_gear_2d(outer_d = 17.2, root_d = 14.96, tooth_count = 32, bore_d = 4.0) {
    pitch_deg = 360 / tooth_count;

    difference() {
        union() {
            circle(d = root_d, $fn = 100);
            for (i = [0 : tooth_count - 1])
                rotate(i * 360 / tooth_count)
                    b3_tooth_2d(
                        outer_r = outer_d / 2,
                        root_r = root_d / 2,
                        pitch_deg = pitch_deg
                    );
        }
        circle(d = bore_d, $fn = 40);
    }
}

module part_b3(thickness = 1.6) {
    translate([0, 0, -thickness / 2])
        linear_extrude(height = thickness)
            b3_gear_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b3();
}
