// part_id: b10
// name: B10 disc plate
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module b10_profile_2d(od = 30, bore_d = 11, hole_d = 4, hole_pitch = 20) {
    difference() {
        circle(d = od, $fn = 96);
        circle(d = bore_d, $fn = 48);
        for (a = [90, 270])
            rotate(a) translate([hole_pitch / 2, 0]) circle(d = hole_d, $fn = 32);
    }
}

module part_b10(od = 30, thickness = 2.0) {
    linear_extrude(height = thickness)
        b10_profile_2d(od = od);
}
