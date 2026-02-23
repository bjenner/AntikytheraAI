// part_id: b4
// name: B4 rivet pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_b4(pin_d = 3.0, pin_h = 4.0, head_d = 4.0, head_h = 1.0) {
    union() {
        cylinder(d = pin_d, h = pin_h, center = false, $fn = 30);
        cylinder(d = head_d, h = head_h, center = false, $fn = 30);
    }
}
