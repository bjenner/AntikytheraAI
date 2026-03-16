// part_id: b13
// name: B13 roller
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b13(
    roller_d = 5.0,
    roller_len = 5.0,
    bore_d = 1.5,
    edge_chamfer = 0.1
) {
    translate([-roller_len / 2, 0, 0])
        difference() {
            union() {
                if (roller_len > 2 * edge_chamfer) {
                    translate([edge_chamfer, 0, 0])
                        rotate([0, 90, 0])
                            cylinder(
                                d = roller_d,
                                h = roller_len - 2 * edge_chamfer,
                                center = false,
                                $fn = 48
                            );
                }

                rotate([0, 90, 0])
                    cylinder(
                        d1 = roller_d - 2 * edge_chamfer,
                        d2 = roller_d,
                        h = edge_chamfer,
                        center = false,
                        $fn = 48
                    );

                translate([roller_len - edge_chamfer, 0, 0])
                    rotate([0, 90, 0])
                        cylinder(
                            d1 = roller_d,
                            d2 = roller_d - 2 * edge_chamfer,
                            h = edge_chamfer,
                            center = false,
                            $fn = 48
                        );
            }

            translate([-0.1, 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = bore_d, h = roller_len + 0.2, center = false, $fn = 32);
        }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b13();
}
