// part_id: sp3
// name: SP3 superior plate
// source_drawing_ids: DRW-056;DRW-022
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_sp3(width = 120, depth = 90, thickness = 2.5, drive_bore_d = 8, mount_bore_d = 3) {
    difference() {
        translate([-width / 2, -depth / 2, 0]) cube([width, depth, thickness], center = false);

        // Center drive-shaft hole.
        translate([0, 0, -0.1]) cylinder(d = drive_bore_d, h = thickness + 0.2, center = false);

        // Intentionally uneven mount pattern from section 8.11.5 text.
        for (p = [[-40, -28], [34, -22], [41, 26], [-31, 24]]) {
            translate([p[0], p[1], -0.1]) cylinder(d = mount_bore_d, h = thickness + 0.2, center = false);
        }
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_sp3();
}
