// part_id: sun17
// name: Sun slotted shaft
// source_drawing_ids: DRW-021
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_sun17(
    outer_d = 5.30,
    inner_d = 4.0,
    top_d = 5.0,
    top_h = 2.5,
    body_h = 49.2,
    tip_d = 5.0,
    split_h = 3.1,
    split_w = 1.0
) {
    total_h = body_h + top_h;
    main_body_h = body_h - split_h;

    translate([0, 0, -total_h / 2]) difference() {
        union() {
            cylinder(d = tip_d, h = split_h, center = false, $fn = 72);
            translate([0, 0, split_h])
                cylinder(d = outer_d, h = main_body_h, center = false, $fn = 80);
            translate([0, 0, body_h])
                cylinder(d = top_d, h = top_h, center = false, $fn = 72);
        }

        translate([0, 0, -0.05])
            cylinder(d = inner_d, h = total_h + 0.1, center = false, $fn = 72);

        // Split the lower end to create the spring collet shown on sheet 8.
        translate([-split_w / 2, -tip_d, -0.05])
            cube([split_w, tip_d * 2, split_h + 0.1], center = false);
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    part_sun17();
}
