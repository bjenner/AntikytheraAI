// Antikyth main entrypoint.
// Set mode/quality in configs/presets.scad.
// SPDX-License-Identifier: MIT

include <configs/presets.scad>
use <parts/a1.scad>
use <parts/sp1_superior_gear.scad>
use <parts/sp2_gear_axle_subassembly.scad>
use <parts/sp3_superior_plate.scad>
use <parts/sp4_press_pin.scad>
use <parts/sp5_superior_plate.scad>
use <parts/sp6_rivet_pin.scad>
use <parts/sp7_companion_gear.scad>
use <parts/sat6_date_pointer_axle.scad>
use <parts/spp17_date_pointer_base.scad>
use <assemblies/full_mechanism.scad>
use <assemblies/drw022_sheet5.scad>
use <assemblies/drw001_sheet1.scad>
use <assemblies/drw001_sheet2.scad>
use <assemblies/drw001_sheet4.scad>
use <assemblies/drw001_sheet5.scad>
use <assemblies/drw001_sheet6.scad>
use <assemblies/drw001_sheet7.scad>

$fn = quality == "render" ? 160 : 72;

spin_theta = mode == "animate" ? 360 * spin_turns * $t : 0;

if (mode == "part_a1") {
    part_a1();
} else if (mode == "part_sp1") {
    part_sp1();
} else if (mode == "part_sp2") {
    part_sp2();
} else if (mode == "part_sp3") {
    part_sp3();
} else if (mode == "part_sp4") {
    part_sp4();
} else if (mode == "part_sp5") {
    part_sp5();
} else if (mode == "part_sp6") {
    part_sp6();
} else if (mode == "part_sp7") {
    part_sp7();
} else if (mode == "part_sat6") {
    part_sat6();
} else if (mode == "part_spp17") {
    part_spp17();
} else if (mode == "drw022_sheet5") {
    drw022_sheet5();
} else if (mode == "drw001_sheet1") {
    drw001_sheet1();
} else if (mode == "drw001_sheet2") {
    drw001_sheet2();
} else if (mode == "drw001_sheet4") {
    drw001_sheet4();
} else if (mode == "drw001_sheet5") {
    drw001_sheet5();
} else if (mode == "drw001_sheet6") {
    drw001_sheet6();
} else if (mode == "drw001_sheet7") {
    drw001_sheet7();
} else if (mode == "assembly") {
    full_mechanism(theta = 0, exploded_gap = 0);
} else if (mode == "exploded") {
    full_mechanism(theta = 0, exploded_gap = exploded_gap);
} else if (mode == "animate") {
    full_mechanism(theta = spin_theta, exploded_gap = 0);
} else {
    echo(str("Unknown mode: ", mode));
}
