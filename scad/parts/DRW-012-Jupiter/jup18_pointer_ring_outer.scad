// part_id: jup18
// name: Jupiter pointer ring outer
// source_drawing_ids: DRW-012
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_jup18(
    outer_d = 25.5,
    inner_d = 14.0,
    shoulder_d = 15.5,
    base_h = 1.0,
    shoulder_h = 1.0,
    rivet_d = 1.0,
    rivet_pcd = 17.5,
    rivet_count = 4
) {
    difference() {
        union() {
            difference() {
                cylinder(d = outer_d, h = base_h, $fn = 96);
                translate([0, 0, -0.05]) cylinder(d = inner_d, h = base_h + 0.1, $fn = 80);
            }
            translate([0, 0, base_h])
                difference() {
                    cylinder(d = shoulder_d, h = shoulder_h, $fn = 80);
                    translate([0, 0, -0.05]) cylinder(d = inner_d, h = shoulder_h + 0.1, $fn = 80);
                }
        }
        for (i = [0 : rivet_count - 1]) {
            a = i * 360 / rivet_count;
            translate([(rivet_pcd / 2) * cos(a), (rivet_pcd / 2) * sin(a), -0.1])
                cylinder(d = rivet_d, h = base_h + shoulder_h + 0.2, $fn = 18);
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_jup18();
}
