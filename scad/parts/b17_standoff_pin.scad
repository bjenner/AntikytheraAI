// part_id: b17
// name: B17 standoff pin
// source_drawing_ids: DRW-002
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

// Axis is +X for easier placement on plate assemblies.
module part_b17(body_len = 13.3, body_w = 5.0, body_h = 5.0,
                left_pin_d = 3.0, left_pin_len = 3.6,
                left_collar_d = 4.2, left_collar_len = 1.6,
                right_pin_d = 3.0, right_pin_len = 1.5,
                top_tab_w = 1.8, top_tab_h = 1.8) {
    difference() {
        union() {
            // Main rectangular body.
            translate([0, -body_w / 2, -body_h / 2])
                cube([body_len, body_w, body_h], center = false);

            // Left-side fitted shaft and collar.
            translate([-left_pin_len - left_collar_len, 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = left_pin_d, h = left_pin_len, center = false);
            translate([-left_collar_len, 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = left_collar_d, h = left_collar_len, center = false);

            // Right-side short pin.
            translate([body_len, 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = right_pin_d, h = right_pin_len, center = false);

            // Small anti-rotation tab shown in drawing side detail.
            translate([body_len - top_tab_w, -body_w / 2, body_h / 2])
                cube([top_tab_w, body_w, top_tab_h], center = false);
        }

        // Light edge relief to match machined profile impression.
        for (sx = [1.8, body_len - 1.8])
            translate([sx, 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = 0.8, h = body_w + 0.2, center = true);
    }
}

// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_b17();
}
