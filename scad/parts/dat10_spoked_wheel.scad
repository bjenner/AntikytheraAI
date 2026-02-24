// part_id: dat10
// name: Date central spoked wheel/carrier
// source_drawing_ids: DRW-008
// units: mm
// revision: 0.1
// SPDX-License-Identifier: MIT

module dat10_spoke_cutouts(outer_d = 96, hub_d = 28, n = 4) {
    for (i = [0 : n - 1]) {
        rotate([0, 0, i * 360 / n])
        hull() {
            translate([hub_d * 0.55, 0]) circle(d = 13, $fn = 40);
            translate([outer_d * 0.34, 0]) circle(d = 29, $fn = 50);
        }
    }
}

module part_dat10(
    outer_d = 98,
    inner_open_d = 22,
    hub_d = 30,
    thickness = 2.0,
    bore_d = 8,
    small_hole_d = 3.0,
    hole_count = 24,
    hole_pcd = 44
) {
    difference() {
        cylinder(d = outer_d, h = thickness, center = false, $fn = 140);

        // Spoke windows
        linear_extrude(height = thickness + 0.1)
        dat10_spoke_cutouts(outer_d = outer_d, hub_d = hub_d, n = 4);

        // center bore
        translate([0, 0, -0.05]) cylinder(d = bore_d, h = thickness + 0.2, center = false, $fn = 48);

        // Through holes
        for (i = [0 : hole_count - 1]) {
            a = i * 360 / hole_count;
            translate([(hole_pcd / 2) * cos(a), (hole_pcd / 2) * sin(a), -0.05])
                cylinder(d = small_hole_d, h = thickness + 0.2, center = false, $fn = 20);
        }
    }

    // Inner ring lip
    translate([0, 0, thickness])
    difference() {
        cylinder(d = 34, h = 1.6, center = false, $fn = 96);
        translate([0, 0, -0.05]) cylinder(d = inner_open_d, h = 1.7, center = false, $fn = 60);
    }
}
