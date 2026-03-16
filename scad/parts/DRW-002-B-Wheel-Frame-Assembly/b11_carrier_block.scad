// part_id: b11
// name: B11 carrier block
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module rounded_rect_xy(w = 8, h = 5.2, r = 1.0) {
    hull() {
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([sx * (w / 2 - r), sy * (h / 2 - r)])
                    circle(r = r, $fn = 32);
    }
}

module b11_base_2d(w = 16, h = 24, corner_r = 3) {
    hull() {
        translate([corner_r, corner_r]) circle(r = corner_r, $fn = 40);
        translate([w - corner_r, corner_r]) circle(r = corner_r, $fn = 40);
        translate([corner_r, h - corner_r]) circle(r = corner_r, $fn = 40);
        translate([w - corner_r, h - corner_r]) circle(r = corner_r, $fn = 40);
    }
}

module b11_profile_2d(
    w = 16,
    h = 24,
    corner_r = 3,
    window_w = 8.0,
    window_h = 5.2,
    window_r = 1.0,
    window_bottom_offset = 9.4,
    big_hole_d = 3.0,
    big_hole_spacing = 8.0,
    bottom_hole_offset = 4.0,
    small_hole_r = 0.75,
    small_top_offset = 2.5,
    small_bottom_offset = 4.0
) {
    difference() {
        b11_base_2d(w = w, h = h, corner_r = corner_r);
        translate([w / 2, window_bottom_offset + window_h / 2])
            rounded_rect_xy(w = window_w, h = window_h, r = window_r);
        for (x = [w / 2 - big_hole_spacing / 2, w / 2 + big_hole_spacing / 2])
            translate([x, bottom_hole_offset])
                circle(d = big_hole_d, $fn = 32);
        translate([w / 2, h - small_top_offset])
            circle(r = small_hole_r, $fn = 24);
        translate([w / 2, small_bottom_offset])
            circle(r = small_hole_r, $fn = 24);
    }
}

module b11_slot_segment_3d(
    y0,
    y1,
    x = 8.0,
    top_z = 3.0,
    slot_r = 0.6,
    slot_center_drop = 0.8
) {
    slot_w = 2 * slot_r;
    rect_h = slot_center_drop;
    len = y1 - y0;

    translate([x - slot_w / 2, y0, top_z - rect_h])
        cube([slot_w, len, rect_h + 0.02], center = false);

    translate([x, y0, top_z - slot_center_drop])
        rotate([-90, 0, 0])
            cylinder(r = slot_r, h = len, center = false, $fn = 28);
}

module part_b11(
    w = 16,
    h = 24,
    t = 3.0,
    window_w = 8.0,
    window_h = 5.2,
    window_bottom_offset = 9.4,
    small_top_offset = 2.5,
    small_bottom_offset = 4.0,
    slot_depth = 1.4,
    slot_center_drop = 0.8
) {
    slot_r = slot_depth - slot_center_drop;

    translate([-w / 2, -h / 2, -t / 2])
        difference() {
            linear_extrude(height = t)
                b11_profile_2d(
                    w = w,
                    h = h,
                    window_w = window_w,
                    window_h = window_h,
                    window_bottom_offset = window_bottom_offset,
                    small_top_offset = small_top_offset,
                    small_bottom_offset = small_bottom_offset
                );

            // Full-height center groove: shallow top-face cut, not a through-slot.
            b11_slot_segment_3d(
                y0 = 0,
                y1 = h,
                x = w / 2,
                top_z = t,
                slot_r = slot_r,
                slot_center_drop = slot_center_drop
            );
        }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b11();
}
