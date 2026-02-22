// part_id: a8
// name: A8 rivet pin
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.1-placeholder
// SPDX-License-Identifier: MIT

module part_a8(pin_d = 3, pin_h = 11, head_d = 6, head_h = 1.6) {
    union() {
        cylinder(d = pin_d, h = pin_h, center = false);
        cylinder(d = head_d, h = head_h, center = false);
    }
}

