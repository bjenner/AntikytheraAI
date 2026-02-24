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
use <parts/cp1_pointer_small.scad>
use <parts/cp2_slider.scad>
use <parts/cp3_rivet.scad>
use <parts/cp4_stopper.scad>
use <parts/cp5_spacer.scad>
use <parts/cp6_bush.scad>
use <parts/cp7_bush.scad>
use <parts/cp8_pin.scad>
use <parts/cp9_pin.scad>
use <parts/cpr1_rivet.scad>
use <parts/cpr2_rivet.scad>
use <parts/cpr3_rivet.scad>
use <parts/cpr4_rivet.scad>
use <parts/cpr5_rivet.scad>
use <parts/cpr6_rivet.scad>
use <parts/cpf1_fork.scad>
use <parts/cpf2_fork.scad>
use <parts/cpf3_fork.scad>
use <parts/cpf4_fork.scad>
use <parts/cpf5_fork.scad>
use <parts/cpf6_fork.scad>
use <parts/sp1_superior_gear.scad>
use <parts/sp2_gear_axle_subassembly.scad>
use <parts/sp3_superior_plate.scad>
use <parts/sp4_press_pin.scad>
use <parts/sp5_superior_plate.scad>
use <parts/sp6_rivet_pin.scad>
use <parts/sp7_companion_gear.scad>
use <parts/sat6_date_pointer_axle.scad>
use <parts/spp17_date_pointer_base.scad>
use <parts/dat7_ring.scad>
use <parts/dat8_ring.scad>
use <parts/dat1_pointer.scad>
use <parts/dat2_pin.scad>
use <parts/dat3_ball_tip.scad>
use <parts/dat4_post.scad>
use <parts/dat5_ball_tip_small.scad>
use <parts/dat6_post_small.scad>
use <parts/dat9_base_plate.scad>
use <parts/dat10_spoked_wheel.scad>
use <assemblies/full_mechanism.scad>
use <assemblies/drw022_sheet5.scad>
use <assemblies/drw008_sheet5.scad>
use <assemblies/drw008_sheet4.scad>
use <assemblies/drw008_sheet3.scad>
use <assemblies/drw008_sheet2.scad>
use <assemblies/drw001_sheet1.scad>
use <assemblies/drw001_sheet2.scad>
use <assemblies/drw001_sheet4.scad>
use <assemblies/drw001_sheet5.scad>
use <assemblies/drw001_sheet6.scad>
use <assemblies/drw001_sheet7.scad>
use <assemblies/drw002_sheet1.scad>
use <assemblies/drw002_sheet2.scad>
use <assemblies/drw002_sheet6.scad>
use <assemblies/drw002_sheet7.scad>
use <assemblies/drw002_sheet8.scad>
use <assemblies/drw002_sheet9.scad>
use <assemblies/drw002_sheet10.scad>
use <assemblies/drw005_sheet1.scad>
use <assemblies/drw005_sheet2.scad>
use <assemblies/drw005_sheet3.scad>
use <assemblies/parts_inventory.scad>

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
} else if (mode == "part_cp1") {
    part_cp1();
} else if (mode == "part_cp2") {
    part_cp2();
} else if (mode == "part_cp3") {
    part_cp3();
} else if (mode == "part_cp4") {
    part_cp4();
} else if (mode == "part_cp5") {
    part_cp5();
} else if (mode == "part_cp6") {
    part_cp6();
} else if (mode == "part_cp7") {
    part_cp7();
} else if (mode == "part_cp8") {
    part_cp8();
} else if (mode == "part_cp9") {
    part_cp9();
} else if (mode == "part_cpr1") {
    part_cpr1();
} else if (mode == "part_cpr2") {
    part_cpr2();
} else if (mode == "part_cpr3") {
    part_cpr3();
} else if (mode == "part_cpr4") {
    part_cpr4();
} else if (mode == "part_cpr5") {
    part_cpr5();
} else if (mode == "part_cpr6") {
    part_cpr6();
} else if (mode == "part_cpf1") {
    part_cpf1();
} else if (mode == "part_cpf2") {
    part_cpf2();
} else if (mode == "part_cpf3") {
    part_cpf3();
} else if (mode == "part_cpf4") {
    part_cpf4();
} else if (mode == "part_cpf5") {
    part_cpf5();
} else if (mode == "part_cpf6") {
    part_cpf6();
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
} else if (mode == "part_dat7") {
    part_dat7();
} else if (mode == "part_dat8") {
    part_dat8();
} else if (mode == "part_dat1") {
    part_dat1();
} else if (mode == "part_dat2") {
    part_dat2();
} else if (mode == "part_dat3") {
    part_dat3();
} else if (mode == "part_dat4") {
    part_dat4();
} else if (mode == "part_dat5") {
    part_dat5();
} else if (mode == "part_dat6") {
    part_dat6();
} else if (mode == "part_dat9") {
    part_dat9();
} else if (mode == "part_dat10") {
    part_dat10();
} else if (mode == "drw022_sheet5") {
    drw022_sheet5();
} else if (mode == "drw008_sheet3") {
    drw008_sheet3();
} else if (mode == "drw008_sheet2") {
    drw008_sheet2();
} else if (mode == "drw008_sheet5") {
    drw008_sheet5();
} else if (mode == "drw008_sheet4") {
    drw008_sheet4();
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
} else if (mode == "drw002_sheet1") {
    drw002_sheet1();
} else if (mode == "drw002_sheet2") {
    drw002_sheet2();
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
} else if (mode == "drw005_sheet1") {
    drw005_sheet1();
} else if (mode == "drw005_sheet2") {
    drw005_sheet2();
} else if (mode == "drw005_sheet3") {
    drw005_sheet3();
} else if (mode == "parts_inventory") {
    parts_inventory();
} else if (mode == "assembly") {
    full_mechanism(theta = 0, exploded_gap = 0);
} else if (mode == "exploded") {
    full_mechanism(theta = 0, exploded_gap = exploded_gap);
} else if (mode == "animate") {
    full_mechanism(theta = spin_theta, exploded_gap = 0);
} else {
    echo(str("Unknown mode: ", mode));
}
