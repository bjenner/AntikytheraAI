// part_id: jup19
// name: Jupiter pointer ring inner
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup19(
    outer_d = 21.5,
    inner_d = 15.5,
    thickness = 1.0,
    rivet_d = 1.0,
    rivet_pcd = 17.5,
    rivet_count = 4
) {
    difference() {
        difference() {
            cylinder(d = outer_d, h = thickness, $fn = 90);
            translate([0, 0, -0.05]) cylinder(d = inner_d, h = thickness + 0.1, $fn = 72);
        }
        for (i = [0 : rivet_count - 1]) {
            a = i * 360 / rivet_count;
            translate([(rivet_pcd / 2) * cos(a), (rivet_pcd / 2) * sin(a), -0.1])
                cylinder(d = rivet_d, h = thickness + 0.2, $fn = 18);
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup19();
}
