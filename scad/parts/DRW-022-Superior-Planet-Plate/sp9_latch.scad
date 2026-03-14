// part_id: sp9
// name: SP9 Jupiter/Mars latch
// source_drawing_ids: DRW-022
// units: mm
// revision: 0.1-drw022
// SPDX-License-Identifier: MIT
//
// Dimensions from DRW-022 sheet 6:
//   Circular head: R16.5 outer, R9.5 inner lightening cutout, Ø4.0 pivot hole.
//   Arm: total length 51 mm, two segments 32.0 + 12.0 mm, tail R5 radius.
//   Fillet radii: R4 at root, R3 at transitions.
//   Thickness: 2.5 mm (placeholder, not explicitly dimensioned on sheet).

module part_sp9(
    thickness  = 2.5,
    head_r     = 16.5,
    inner_r    = 9.5,
    pivot_d    = 4.0,
    total_len  = 51.0,
    arm_w_root = 7.0,
    arm_w_tip  = 3.5,
    tail_r     = 5.0
) {
    arm_start_x = head_r - 3.0;
    arm_len     = total_len - arm_start_x;

    linear_extrude(height = thickness) {
        difference() {
            union() {
                // Circular head.
                circle(r = head_r, $fn = 120);
                // Tapered arm body extending from head.
                translate([arm_start_x, -arm_w_root / 2])
                    polygon([
                        [0,        0],
                        [arm_len,  -(arm_w_root - arm_w_tip) / 2],
                        [arm_len,   arm_w_tip + (arm_w_root - arm_w_tip) / 2],
                        [0,        arm_w_root]
                    ]);
                // Rounded tail cap.
                translate([total_len - tail_r, arm_w_root / 2 - (arm_w_root - arm_w_tip) / 2])
                    circle(r = tail_r, $fn = 60);
            }
            // Center pivot hole.
            circle(d = pivot_d, $fn = 40);
            // Inner head lightening cutout.
            circle(r = inner_r, $fn = 100);
        }
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_sp9();
}
