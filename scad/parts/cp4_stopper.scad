// part_id: cp4
// name: Stopper D3 L3
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cp4(core_d = 3.0, core_h = 3.0, flange_d = 4.5, flange_h = 1.5, neck_d = 2.0, neck_h = 1.5) {
    union() {
        cylinder(d = core_d, h = core_h, center = false, $fn = 40);
        translate([0, 0, core_h]) cylinder(d = flange_d, h = flange_h, center = false, $fn = 42);
        translate([0, 0, 0]) cylinder(d = neck_d, h = neck_h, center = false, $fn = 30);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_cp4();
}
