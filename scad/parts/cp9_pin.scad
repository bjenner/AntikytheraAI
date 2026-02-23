// part_id: cp9
// name: Pin D1.0
// source_drawing_ids: DRW-005
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module part_cp9(d = 1.0, h = 3.5) {
    cylinder(d = d, h = h, center = false, $fn = 20);
}
