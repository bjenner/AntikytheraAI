// part_id: fp2
// name: Front panel dial frame
// source_drawing_ids: DRW-010
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module fp2_profile_2d(
    panel_w = 184.0,
    panel_h = 184.0,
    panel_taper = 6.0,
    center_cutout_d = 163.4,
    mount_hole_d = 5.0,
    hole_offset = 7.5
) {
    difference() {
        polygon(points = [
            [-panel_w / 2 + panel_taper, -panel_h / 2],
            [ panel_w / 2 - panel_taper, -panel_h / 2],
            [ panel_w / 2, panel_h / 2],
            [-panel_w / 2, panel_h / 2]
        ]);

        circle(d = center_cutout_d, $fn = 180);

        for (sx = [-1, 1], sy = [-1, 1]) {
            translate([sx * (panel_w / 2 - hole_offset), sy * (panel_h / 2 - hole_offset)])
                circle(d = mount_hole_d, $fn = 36);
        }
    }
}

module part_fp2(
    thickness = 1.6
) {
    linear_extrude(height = thickness)
        fp2_profile_2d();
}
