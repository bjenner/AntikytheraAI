// DRW-004 provisional E4 comparison scene.
// Shows e4_alt and e4_cut side by side plus an optional overlay.
// SPDX-License-Identifier: MIT

use <../../parts/DRW-004-IP-Plate-Gear-Assembly/e4_alt_gear.scad>
use <../../parts/DRW-004-IP-Plate-Gear-Assembly/e4_cut_gear.scad>

module drw004_e4_compare(
    spacing_x = 120,
    show_overlay = true,
    overlay_z_gap = 4.0
) {
    color([0.45, 0.30, 0.18])
        translate([-spacing_x / 2, 0, 0])
            part_e4_alt();

    color([0.30, 0.26, 0.20])
        translate([spacing_x / 2, 0, 0])
            part_e4_cut();

    if (show_overlay) {
        color([0.45, 0.30, 0.18, 0.55])
            translate([0, 0, 0])
                part_e4_alt();

        color([0.30, 0.26, 0.20, 0.55])
            translate([0, 0, overlay_z_gap])
                part_e4_cut();
    }
}

// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) {
    drw004_e4_compare();
}
