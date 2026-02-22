// part_id: b8
// name: B8 rivet pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b8(pin_d = 1.5, pin_h = 6.2, head_d = 2.4, head_h = 0.9) {
    union() {
        cylinder(d = pin_d, h = pin_h, center = false, $fn = 30);
        cylinder(d = head_d, h = head_h, center = false, $fn = 30);
    }
}
