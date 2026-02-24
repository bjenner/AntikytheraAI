// part_id: cp1
// name: Pointer small (Olympic/Calippic/Exeligmos)
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module cp1_profile_2d(body_r = 2.0, bore_d = 1.5, tip_len = 4.8, tip_ang = 26) {
    difference() {
        union() {
            circle(r = body_r, $fn = 48);
            rotate([0, 0, -tip_ang / 2])
                polygon(points = [[0, -0.55], [tip_len, 0], [0, 0.55]]);
        }
        circle(d = bore_d, $fn = 28);
    }
}

module part_cp1(thickness = 1.6) {
    linear_extrude(height = thickness)
        cp1_profile_2d();
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cp1();
}
