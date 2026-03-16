// part_id: b7
// name: B7 hub base
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

// Axis is +Z. Geometry is being rebuilt from the innermost turned cylinder outward.
module part_b7(
    core_r = 4.0,
    core_h = 13.9,
    upper_core_z = 3.2,
    upper_core_r = 4.5,
    top_core_offset = 2.0,
    top_core_r = 5.5,
    flange_d = 20.0,
    flange_h = 2.2,
    top_cap_r = 5.9,
    top_cap_h = 1.9,
    bore_d = 4.0,
    bore_h = 13.0,
    top_bore_d = 5.0,
    top_bore_h = 1.9,
    side_hole_offset = 4.0,
    side_hole_r = 0.75,
    side_hole_h = 6.0,
    top_side_hole_offset = 5.9,
    top_side_hole_r = 1.0,
    top_side_hole_h = 3.6
) {
    translate([0, 0, -core_h / 2])
        difference() {
            union() {
                cylinder(r = core_r, h = core_h, center = false, $fn = 72);
                translate([0, 0, upper_core_z])
                    cylinder(r = upper_core_r, h = core_h - upper_core_z, center = false, $fn = 72);
                translate([0, 0, upper_core_z + top_core_offset])
                    cylinder(r = top_core_r, h = core_h - upper_core_z - top_core_offset, center = false, $fn = 72);
                translate([0, 0, core_h - top_cap_h - flange_h])
                    cylinder(d = flange_d, h = flange_h, center = false, $fn = 96);
                translate([0, 0, core_h - top_cap_h])
                    cylinder(r = top_cap_r, h = top_cap_h, center = false, $fn = 96);
            }
            translate([0, 0, -0.1])
                cylinder(d = bore_d, h = bore_h + 0.2, center = false, $fn = 48);
            translate([0, 0, core_h - top_bore_h])
                cylinder(d = top_bore_d, h = top_bore_h + 0.1, center = false, $fn = 48);
            for (sx = [-1, 1])
                translate([sx * side_hole_offset, 0, -0.1])
                    cylinder(r = side_hole_r, h = side_hole_h + 0.2, center = false, $fn = 36);
            translate([-top_side_hole_offset, 0, core_h - top_side_hole_h])
                cylinder(r = top_side_hole_r, h = top_side_hole_h + 0.1, center = false, $fn = 36);
        }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b7();
}
