// part_id: a3
// name: A3 pin
// source_drawing_ids: DRW-001
// units: mm
// revision: 0.2
// SPDX-License-Identifier: MIT

module a3_lobed_top_2d(d = 9.8) {
    r_major = d * (2.5 / 9.8); // center R2.5
    r_minor = d * (1.0 / 9.8); // side R1.0 bumps
    side_dx = r_major;         // side bump centers offset from origin

    union() {
        circle(r = r_major, $fn = 72);
        translate([ side_dx, 0]) circle(r = r_minor, $fn = 42);
        translate([-side_dx, 0]) circle(r = r_minor, $fn = 42);
    }
}

module a3_height_ruler(total_h = 16.6, tick_step = 1, major_step = 2, x = 8.5, y = 0) {
    // Vertical spine
    color([0.15, 0.15, 0.15])
        translate([x, y, 0]) cube([0.25, 0.25, total_h], center = false);

    // Tick marks (1 mm minor, 2 mm major)
    for (z = [0 : tick_step : ceil(total_h)]) {
        tick_len = (z % major_step == 0) ? 2.2 : 1.2;
        color([0.05, 0.05, 0.05])
            translate([x - tick_len, y, z]) cube([tick_len, 0.25, 0.15], center = false);
    }
}

module part_a3(d = 9.8, h = 16.6, show_ruler = false) {
    // Height stack (mm), bottom -> top:
    // 2.5, 1.0, 2.3, 8.8, 2.0  (total = 16.6)
    lower_h = 2.5; // green
    waist_h = 1.0; // red (slot band)
    mid_h   = 2.3; // purple
    upper_h = 8.8; // orange
    top_h   = 2.0; // blue

    z0 = 0;
    z1 = z0 + lower_h;
    z2 = z1 + waist_h;
    // Wide body is positioned from the top:
    // starts 2.0 mm down and runs for 8.8 mm.
    z3 = h - (top_h + upper_h);
    z4 = h - top_h;

    waist_d = d * (8.0 / 9.8);     // Ø8.0 region callout
    slot_w = d * (3.0 / 9.8);      // 3.0 slot callout
    hole_d = d * (1.5 / 9.8);      // Ø1.5 cross-hole callout

    difference() {
        union() {
            // Lower stepped stack.
            color("green")
            cylinder(d = waist_d, h = lower_h, center = false);
            color("red")
            translate([0, 0, z1]) cylinder(d = waist_d, h = waist_h, center = false);
            color("purple")
            translate([0, 0, z2]) cylinder(d = waist_d, h = mid_h, center = false);

            // Main wide body (Ø9.8): top-referenced placement.
            color("orange")
            translate([0, 0, z3]) cylinder(d = d, h = upper_h, center = false);

            // Keyed/lobed top boss.
            translate([0, 0, z4]) linear_extrude(height = top_h) a3_lobed_top_2d(d = d);
        }

        // Opposing side slots in lower Ø8.0 section (leave 3.0 mm center web).
        // Slot band matches the full 1.0 mm red section.
        slot_band_h = waist_h;
        slot_band_z = z1;
        half_web = slot_w / 2;
        // +X side slot
        translate([half_web, -waist_d, slot_band_z])
            cube([waist_d, 2 * waist_d, slot_band_h], center = false);
        // -X side slot
        translate([-waist_d - half_web, -waist_d, slot_band_z])
            cube([waist_d, 2 * waist_d, slot_band_h], center = false);

        // Transverse cross-hole (Ø1.5), tangent to top edge of the Ø8.0 band.
        hole_r = hole_d / 2;
        translate([0, 0, z2 + mid_h - hole_r])
            rotate([90, 0, 0])
                cylinder(d = hole_d, h = d + 2.0, center = true, $fn = 48);
    }

    if (show_ruler) {
        a3_height_ruler(total_h = h, x = d * 0.95);
    }
}


// ---- "main guard" ----
// Default to previewing when opened directly:
if (is_undef(__LIB_MODE__)) {
    part_a3(show_ruler = !is_undef(A3_SHOW_RULER) && A3_SHOW_RULER);
}
