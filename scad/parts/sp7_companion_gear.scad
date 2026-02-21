// part_id: sp7
// name: SP7 companion ring
// source_drawing_ids: DRW-022;DRW-056
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_sp7(od = 32.0, thickness = 1.0, bore_d = 20.2, bolt_d = 3.0, bolt_r = 13.0) {
    difference() {
        cylinder(d = od, h = thickness, center = false);
        translate([0, 0, -0.1]) cylinder(d = bore_d, h = thickness + 0.2, center = false);
        for (a = [0, 90, 180, 270]) {
            rotate([0, 0, a]) translate([bolt_r, 0, -0.1])
                cylinder(d = bolt_d, h = thickness + 0.2, center = false);
        }
    }
}
