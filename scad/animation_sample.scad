// Self-contained OpenSCAD animation sample.
// Open this file directly in OpenSCAD.
// SPDX-License-Identifier: MIT

// ------------------------------
// Controls
// ------------------------------
mode = "spin_exploded"; // "spin", "exploded", "spin_exploded"
turns = 1.0;            // full revolutions during one animation cycle
explode_mm = 12;        // separation distance in exploded modes

$fn = 96;

module gear_like(d = 44, th = 4, teeth = 36, tooth_h = 1.6) {
    difference() {
        union() {
            cylinder(d = d, h = th, center = true);
            for (i = [0 : teeth - 1])
                rotate([0, 0, i * 360 / teeth])
                    translate([d / 2, 0, 0])
                        cube([tooth_h, 1.2, th], center = true);
        }
        cylinder(d = 8, h = th + 1, center = true);
    }
}

module pin_part(h = 24, d1 = 10, d2 = 6) {
    union() {
        cylinder(d = d1, h = h * 0.65, center = false);
        translate([0, 0, h * 0.65]) cylinder(d = d2, h = h * 0.35, center = false);
    }
}

module sample_assembly(explode = 0, theta = 0) {
    rotate([0, 0, theta]) {
        color([0.72, 0.52, 0.25])
            gear_like();

        // Move second part along Z for exploded view.
        color([0.25, 0.65, 0.85])
            translate([0, 0, 2 + explode])
                pin_part();
    }
}

if (mode == "spin") {
    sample_assembly(explode = 0, theta = 360 * turns * $t);
} else if (mode == "exploded") {
    sample_assembly(explode = explode_mm * $t, theta = 0);
} else {
    // spin_exploded
    sample_assembly(explode = explode_mm * $t, theta = 360 * turns * $t);
}
