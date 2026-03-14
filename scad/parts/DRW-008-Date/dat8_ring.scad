// part_id: dat8
// name: Date pointer friction ring (inner)
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_dat8(
    outer_d = 24.5,
    inner_d = 18.5,
    body_h = 1.0,
    shoulder_od = 22.5,
    shoulder_h = 0.45,
    rivet_d = 1.0,
    rivet_pcd = 18.5,
    rivet_count = 4,
    chamfer_h = 0.35
) {
    difference() {
        union() {
            difference() {
                cylinder(d = outer_d, h = body_h, center = false);
                translate([0, 0, -0.05]) cylinder(d = inner_d, h = body_h + 0.1, center = false);
            }

            translate([0, 0, body_h])
            difference() {
                cylinder(d = shoulder_od, h = shoulder_h, center = false);
                translate([0, 0, -0.05]) cylinder(d = inner_d, h = shoulder_h + 0.1, center = false);
            }
        }

        // Light outer chamfer to match the drawing profile style.
        translate([0, 0, body_h - chamfer_h])
            cylinder(d1 = outer_d + 0.02, d2 = outer_d - 0.9, h = chamfer_h + 0.02, center = false);

        for (i = [0 : rivet_count - 1]) {
            a = i * 360 / rivet_count;
            translate([
                (rivet_pcd / 2) * cos(a),
                (rivet_pcd / 2) * sin(a),
                -0.1
            ]) cylinder(d = rivet_d, h = body_h + shoulder_h + 0.2, center = false, $fn = 20);
        }
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_dat8();
}
