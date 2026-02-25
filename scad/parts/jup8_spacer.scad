// part_id: jup8
// name: Jupiter press-fit spacer
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup8(
    base_d = 4.9,
    mid_d = 4.0,
    top_d = 4.0,
    base_h = 2.2,
    mid_h = 2.2,
    top_h = 2.0,
    bore_d = 3.0
) {
    total_h = base_h + mid_h + top_h;
    difference() {
        union() {
            cylinder(d = base_d, h = base_h, center = false, $fn = 56);
            translate([0, 0, base_h]) cylinder(d = mid_d, h = mid_h, center = false, $fn = 56);
            translate([0, 0, base_h + mid_h]) cylinder(d = top_d, h = top_h, center = false, $fn = 56);
        }
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = total_h + 0.1, $fn = 48);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup8();
}
