// part_id: dat7
// name: Date pointer friction ring (outer)
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_dat7(
    outer_d = 28.5,
    inner_d = 18.5,
    base_h = 1.0,
    shoulder_od = 24.5,
    shoulder_h = 1.0,
    rivet_d = 1.0,
    rivet_pcd = 17.0,
    rivet_count = 4
) {
    difference() {
        union() {
            difference() {
                cylinder(d = outer_d, h = base_h, center = false);
                translate([0, 0, -0.05]) cylinder(d = inner_d, h = base_h + 0.1, center = false);
            }

            translate([0, 0, base_h])
            difference() {
                cylinder(d = shoulder_od, h = shoulder_h, center = false);
                translate([0, 0, -0.05]) cylinder(d = inner_d, h = shoulder_h + 0.1, center = false);
            }
        }

        for (i = [0 : rivet_count - 1]) {
            a = i * 360 / rivet_count;
            translate([
                (rivet_pcd / 2) * cos(a),
                (rivet_pcd / 2) * sin(a),
                -0.1
            ]) cylinder(d = rivet_d, h = base_h + shoulder_h + 0.2, center = false, $fn = 20);
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_dat7();
}
