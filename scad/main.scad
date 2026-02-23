// Antikyth main entrypoint.
// Set mode/quality in configs/presets.scad.
// SPDX-License-Identifier: MIT

include <configs/presets.scad>
use <parts/a1.scad>
use <parts/b0_gear.scad>
use <parts/b1_main_wheel.scad>
use <parts/b2_gear_ring.scad>
use <parts/b3_gear.scad>
use <parts/b4_rivet_pin.scad>
use <parts/b5_post.scad>
use <parts/b6_clip.scad>
use <parts/b7_hub.scad>
use <parts/b8_rivet_pin.scad>
use <parts/b9_pin.scad>
use <parts/b10_disc.scad>
use <parts/b11_carrier_block.scad>
use <parts/b12_pin.scad>
use <parts/b13_roller.scad>
use <parts/b14_pin.scad>
use <parts/b15_wire_link.scad>
use <parts/b16_rivet.scad>
use <parts/b17_standoff_pin.scad>
use <parts/b18_link_plate.scad>
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
use <assemblies/drw002_sheet6.scad>
use <assemblies/drw002_sheet7.scad>
use <assemblies/drw002_sheet8.scad>
use <assemblies/drw002_sheet9.scad>
use <assemblies/drw002_sheet10.scad>

$fn = quality == "render" ? 160 : 72;

spin_theta = mode == "animate" ? 360 * spin_turns * $t : 0;

if (mode == "part_a1") {
    part_a1();
} else if (mode == "part_b0") {
    part_b0();
} else if (mode == "part_b1") {
    part_b1();
} else if (mode == "part_b2") {
    part_b2();
} else if (mode == "part_b3") {
    part_b3();
} else if (mode == "part_b4") {
    part_b4();
} else if (mode == "part_b5") {
    part_b5();
} else if (mode == "part_b6") {
    part_b6();
} else if (mode == "part_b7") {
    part_b7();
} else if (mode == "part_b8") {
    part_b8();
} else if (mode == "part_b9") {
    part_b9();
} else if (mode == "part_b10") {
    part_b10();
} else if (mode == "part_b11") {
    part_b11();
} else if (mode == "part_b12") {
    part_b12();
} else if (mode == "part_b13") {
    part_b13();
} else if (mode == "part_b14") {
    part_b14();
} else if (mode == "part_b15") {
    part_b15();
} else if (mode == "part_b16") {
    part_b16();
} else if (mode == "part_b17") {
    part_b17();
} else if (mode == "part_b18") {
    part_b18();
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
} else if (mode == "drw002_sheet6") {
    drw002_sheet6();
} else if (mode == "drw002_sheet7") {
    drw002_sheet7();
} else if (mode == "drw002_sheet8") {
    drw002_sheet8();
} else if (mode == "drw002_sheet9") {
    drw002_sheet9();
} else if (mode == "drw002_sheet10") {
    drw002_sheet10();
} else if (mode == "assembly") {
    full_mechanism(theta = 0, exploded_gap = 0);
} else if (mode == "exploded") {
    full_mechanism(theta = 0, exploded_gap = exploded_gap);
} else if (mode == "animate") {
    full_mechanism(theta = spin_theta, exploded_gap = 0);
} else {
    echo(str("Unknown mode: ", mode));
}
