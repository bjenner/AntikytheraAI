// part_id: b7
// name: B7 hub base
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

// Axis is +Z. Geometry is a stepped turned hub with rivet holes for b8/b9.
module part_b7(base_d = 20, base_h = 3.2,
               step1_d = 11, step1_h = 3.6,
               step2_d = 9,  step2_h = 2.2,
               step3_d = 8,  step3_h = 2.0,
               top_post_d = 4.0, top_post_h = 1.9,
               bore_d = 4.0,
               rivet_d = 1.5,
               rivet_pitch = 9.0) {
    total_h = base_h + step1_h + step2_h + step3_h + top_post_h;

    difference() {
        union() {
            cylinder(d = base_d, h = base_h, center = false, $fn = 96);
            translate([0, 0, base_h]) cylinder(d = step1_d, h = step1_h, center = false, $fn = 72);
            translate([0, 0, base_h + step1_h]) cylinder(d = step2_d, h = step2_h, center = false, $fn = 72);
            translate([0, 0, base_h + step1_h + step2_h]) cylinder(d = step3_d, h = step3_h, center = false, $fn = 64);
            translate([0, 0, base_h + step1_h + step2_h + step3_h]) cylinder(d = top_post_d, h = top_post_h, center = false, $fn = 48);
        }

        // Main through bore.
        translate([0, 0, -0.1]) cylinder(d = bore_d, h = total_h + 0.3, center = false, $fn = 48);

        // b8/b9 rivet holes near the top shoulder.
        for (a = [45, 225])
            rotate([0, 0, a])
                translate([rivet_pitch / 2, 0, base_h + 0.8])
                    cylinder(d = rivet_d, h = step1_h + step2_h + 1.2, center = false, $fn = 28);
    }
}
