// part_id: b0
// name: B0 small gear
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

function b0_polar(r, a_deg) = [r * cos(a_deg), r * sin(a_deg)];

module b0_tooth_2d(
    outer_r = 5.75,
    shoulder_r = 5.32,
    neck_r = 4.92,
    root_r = 4.58,
    pitch_deg = 18,
    tooth_tip_w = 1.0,
    shoulder_ratio = 1.85,
    neck_ratio = 1.25
) {
    tip_half_deg = (tooth_tip_w / outer_r) * 180 / PI / 2;
    shoulder_half_deg = min(pitch_deg * 0.42, tip_half_deg * shoulder_ratio);
    neck_half_deg = min(pitch_deg * 0.29, tip_half_deg * neck_ratio);
    root_half_deg = pitch_deg * 0.16;

    polygon(points = [
        b0_polar(root_r, -root_half_deg),
        b0_polar(neck_r, -neck_half_deg),
        b0_polar(shoulder_r, -shoulder_half_deg),
        b0_polar(outer_r, -tip_half_deg),
        b0_polar(outer_r, tip_half_deg),
        b0_polar(shoulder_r, shoulder_half_deg),
        b0_polar(neck_r, neck_half_deg),
        b0_polar(root_r, root_half_deg)
    ]);
}

module b0_gear_2d(
    outer_d = 11.5,
    root_d = 9.16,
    shoulder_d = 10.64,
    neck_d = 9.84,
    tooth_count = 20,
    bore_d = 4.6,
    tooth_tip_w = 1.0
) {
    pitch_deg = 360 / tooth_count;

    difference() {
        union() {
            circle(d = root_d, $fn = 80);
            for (i = [0 : tooth_count - 1])
                rotate(i * 360 / tooth_count)
                    b0_tooth_2d(
                        outer_r = outer_d / 2,
                        shoulder_r = shoulder_d / 2,
                        neck_r = neck_d / 2,
                        root_r = root_d / 2,
                        pitch_deg = pitch_deg,
                        tooth_tip_w = tooth_tip_w
                    );
        }
        circle(d = bore_d, $fn = 42);
    }
}

module part_b0(thickness = 1.6, taper = 0.92) {
    // Slight taper improves the isometric read against the source drawing,
    // while the sheet-cut profile remains defined by b0_gear_2d().
    linear_extrude(height = thickness, scale = taper)
        b0_gear_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b0();
}
