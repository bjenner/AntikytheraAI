// part_id: jup7
// name: Jupiter stepped hub
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup7(
    base_d = 7.0,
    body_d = 5.0,
    top_d = 6.4,
    h1 = 1.35,
    h2 = 3.10,
    h3 = 1.0,
    center_d = 1.0,
    slot_w = 1.6,
    slot_l = 3.2,
    slot_r = 2.0,
    slot_a = -22
) {
    total_h = h1 + h2 + h3;
    difference() {
        union() {
            cylinder(d = base_d, h = h1, center = false, $fn = 64);
            translate([0, 0, h1]) cylinder(d = body_d, h = h2, center = false, $fn = 64);
            translate([0, 0, h1 + h2]) cylinder(d = top_d, h = h3, center = false, $fn = 64);
        }
        translate([0, 0, -0.05]) cylinder(d = center_d, h = total_h + 0.1, $fn = 32);
        rotate([0, 0, slot_a]) translate([slot_r, 0, h1 - 0.05]) hull() {
            cylinder(d = slot_w, h = h2 + 0.1, $fn = 24);
            translate([slot_l, 0, 0]) cylinder(d = slot_w, h = h2 + 0.1, $fn = 24);
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup7();
}
