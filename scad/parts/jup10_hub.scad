// part_id: jup10
// name: Jupiter axle spacer hub
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup10(
    base_d = 6.4,
    body_d = 4.1,
    top_d = 4.0,
    total_h = 6.7,
    base_h = 1.7,
    body_h = 2.6,
    top_h = 2.4,
    center_d = 4.0
) {
    difference() {
        union() {
            cylinder(d = base_d, h = base_h, center = false, $fn = 56);
            translate([0, 0, base_h]) cylinder(d = body_d, h = body_h, center = false, $fn = 56);
            translate([0, 0, base_h + body_h]) cylinder(d = top_d, h = top_h, center = false, $fn = 56);
        }
        translate([0, 0, -0.05]) cylinder(d = center_d, h = total_h + 0.1, center = false, $fn = 48);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup10();
}
