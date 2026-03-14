// part_id: b15
// name: B15 wire link
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module wire_segment(a = [0, 0, 0], b = [10, 0, 0], d = 0.4) {
    hull() {
        translate(a) sphere(d = d, $fn = 20);
        translate(b) sphere(d = d, $fn = 20);
    }
}

module part_b15(run = 17, hook_len = 0.9, wire_d = 0.4) {
    // Planar bent wire with short 90-degree return hooks.
    union() {
        wire_segment([0, 0, 0], [run, 0, 0], wire_d);
        wire_segment([0, 0, 0], [0, 0, -hook_len], wire_d);
        wire_segment([run, 0, 0], [run, 0, -hook_len], wire_d);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b15();
}
