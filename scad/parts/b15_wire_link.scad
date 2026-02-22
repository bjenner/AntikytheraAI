// part_id: b15
// name: B15 wire link
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module wire_segment(a = [0, 0, 0], b = [10, 0, 0], d = 0.8) {
    hull() {
        translate(a) sphere(d = d, $fn = 16);
        translate(b) sphere(d = d, $fn = 16);
    }
}

module part_b15(run = 17, drop = 4, wire_d = 0.8) {
    // Bent wire with short return hooks at ends.
    union() {
        wire_segment([0, 0, 0], [run, 0, 0], wire_d);
        wire_segment([0, 0, 0], [-2.2, 0, -1.2], wire_d);
        wire_segment([run, 0, 0], [run + 2.2, 0, 1.2], wire_d);
    }
}
