// Antikyth main entrypoint.
// Set mode/quality in configs/presets.scad.
// SPDX-License-Identifier: MIT

include <configs/presets.scad>
use <parts/a1.scad>
use <parts/a2_ring.scad>
use <parts/a3_pin.scad>
use <parts/a4_block.scad>
use <parts/a5_ring.scad>
use <parts/a6_bush.scad>
use <parts/a7_block.scad>
use <parts/a8_rivet_pin.scad>
use <parts/a9_axle.scad>
use <parts/a10_disc.scad>
use <parts/a12_link.scad>
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
use <parts/sp8_large_gear.scad>
use <parts/sp9_latch.scad>
use <parts/sp10_disc.scad>
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
use <parts/i1_gear.scad>
use <parts/i2_hub.scad>
use <parts/h1_gear.scad>
use <parts/h2_pinion.scad>
use <parts/h3_hub.scad>
use <parts/exe1_rivet_pin.scad>
use <parts/g2_pinion.scad>
use <parts/fp1_front_plate.scad>
use <parts/fp2_front_panel_dial_frame.scad>
use <parts/fp3_zodiac_dial.scad>
use <parts/fp4_egyptian_dial.scad>
use <parts/fp5_rivet.scad>
use <parts/fp6_post.scad>
use <parts/fp7_post.scad>
use <parts/fp8_post.scad>
use <parts/fp9_bush.scad>
use <parts/fp10_zodiac_pointer.scad>
use <parts/jup1_gear.scad>
use <parts/jup3_gear.scad>
use <parts/mar1_gear.scad>
use <parts/jup4_gear.scad>
use <parts/jup9_rivet_pin.scad>
use <parts/jup10_hub.scad>
use <parts/jup13_pointer_arm.scad>
use <parts/jup14_orb_large.scad>
use <parts/jup15_orb_rod_large.scad>
use <parts/jup16_orb_small.scad>
use <parts/jup17_orb_rod_small.scad>
use <parts/jup18_pointer_ring_outer.scad>
use <parts/jup19_pointer_ring_inner.scad>
use <parts/jup5_gear.scad>
use <parts/jup11_sleeve.scad>
use <parts/jup2_gear.scad>
use <parts/jup7_hub.scad>
use <parts/jup8_spacer.scad>
use <parts/mar2_gear.scad>
use <parts/mar3_gear.scad>
use <parts/mar4_gear.scad>
use <parts/mar6_hub.scad>
use <parts/mar7_axle.scad>
use <parts/mar8_rivet_pin.scad>
use <parts/mar9_hub.scad>
use <parts/mar10_disc.scad>
use <parts/mar5_gear.scad>
use <parts/mar11_sleeve.scad>
use <parts/mar12_pointer_arm.scad>
use <parts/mar13_orb_large.scad>
use <parts/mar14_orb_rod_large.scad>
use <parts/mar15_orb_small.scad>
use <parts/mar16_orb_rod_small.scad>
use <parts/mar17_pointer_ring_outer.scad>
use <parts/mar18_pointer_ring_inner.scad>
use <assemblies/full_mechanism.scad>
use <assemblies/drw022_sheet1.scad>
use <assemblies/drw022_sheet2.scad>
use <assemblies/drw022_sheet3.scad>
use <assemblies/drw022_sheet4.scad>
use <assemblies/drw022_sheet5.scad>
use <assemblies/drw022_sheet6.scad>
use <assemblies/drw022_sheet7.scad>
use <assemblies/drw010_sheet1.scad>
use <assemblies/drw010_sheet4.scad>
use <assemblies/drw010_sheet5.scad>
use <assemblies/drw010_sheet6.scad>
use <assemblies/drw010_sheet7.scad>
use <assemblies/drw010_sheet8.scad>
use <assemblies/drw010_sheet9.scad>
use <assemblies/drw012_sheet2.scad>
use <assemblies/drw012_sheet4.scad>
use <assemblies/drw012_sheet5.scad>
use <assemblies/drw012_sheet6.scad>
use <assemblies/drw010_sheet2.scad>
use <assemblies/drw012_sheet7.scad>
use <assemblies/drw012_sheet8.scad>
use <assemblies/drw012_sheet9.scad>
use <assemblies/drw013_sheet4.scad>
use <assemblies/drw013_sheet5.scad>
use <assemblies/drw013_sheet6.scad>
use <assemblies/drw013_sheet7.scad>
use <assemblies/drw008_sheet5.scad>
use <assemblies/drw008_sheet4.scad>
use <assemblies/drw008_sheet3.scad>
use <assemblies/drw008_sheet2.scad>
use <assemblies/drw009_sheet6.scad>
use <assemblies/drw009_sheet5.scad>
use <assemblies/drw009_sheet4.scad>
use <assemblies/drw009_sheet3.scad>
use <assemblies/drw009_sheet2.scad>
use <assemblies/drw009_sheet1.scad>
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
} else if (mode == "part_a2") {
    part_a2();
} else if (mode == "part_a3") {
    part_a3();
} else if (mode == "part_a4") {
    part_a4();
} else if (mode == "part_a5") {
    part_a5();
} else if (mode == "part_a6") {
    part_a6();
} else if (mode == "part_a7") {
    part_a7();
} else if (mode == "part_a8") {
    part_a8();
} else if (mode == "part_a9") {
    part_a9();
} else if (mode == "part_a10") {
    part_a10();
} else if (mode == "part_a12") {
    part_a12();
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
} else if (mode == "part_sp8") {
    part_sp8();
} else if (mode == "part_sp9") {
    part_sp9();
} else if (mode == "part_sp10") {
    part_sp10();
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
} else if (mode == "part_i1") {
    part_i1();
} else if (mode == "part_i2") {
    part_i2();
} else if (mode == "part_h1") {
    part_h1();
} else if (mode == "part_h2") {
    part_h2();
} else if (mode == "part_h3") {
    part_h3();
} else if (mode == "part_exe1") {
    part_exe1();
} else if (mode == "part_g2") {
    part_g2();
} else if (mode == "part_fp1") {
    part_fp1();
} else if (mode == "part_fp2") {
    part_fp2();
} else if (mode == "part_fp3") {
    part_fp3();
} else if (mode == "part_fp4") {
    part_fp4();
} else if (mode == "part_fp5") {
    part_fp5();
} else if (mode == "part_fp6") {
    part_fp6();
} else if (mode == "part_fp7") {
    part_fp7();
} else if (mode == "part_fp8") {
    part_fp8();
} else if (mode == "part_fp9") {
    part_fp9();
} else if (mode == "part_fp10") {
    part_fp10();
} else if (mode == "part_jup1") {
    part_jup1();
} else if (mode == "part_jup3") {
    part_jup3();
} else if (mode == "part_jup4") {
    part_jup4();
} else if (mode == "part_jup9") {
    part_jup9();
} else if (mode == "part_jup10") {
    part_jup10();
} else if (mode == "part_jup5") {
    part_jup5();
} else if (mode == "part_jup2") {
    part_jup2();
} else if (mode == "part_jup7") {
    part_jup7();
} else if (mode == "part_jup8") {
    part_jup8();
} else if (mode == "part_jup11") {
    part_jup11();
} else if (mode == "part_mar1") {
    part_mar1();
} else if (mode == "part_mar2") {
    part_mar2();
} else if (mode == "part_mar3") {
    part_mar3();
} else if (mode == "part_mar4") {
    part_mar4();
} else if (mode == "part_mar6") {
    part_mar6();
} else if (mode == "part_mar7") {
    part_mar7();
} else if (mode == "part_mar8") {
    part_mar8();
} else if (mode == "part_mar9") {
    part_mar9();
} else if (mode == "part_mar10") {
    part_mar10();
} else if (mode == "part_mar5") {
    part_mar5();
} else if (mode == "part_mar11") {
    part_mar11();
} else if (mode == "part_mar12") {
    part_mar12();
} else if (mode == "part_mar13") {
    part_mar13();
} else if (mode == "part_mar14") {
    part_mar14();
} else if (mode == "part_mar15") {
    part_mar15();
} else if (mode == "part_mar16") {
    part_mar16();
} else if (mode == "part_mar17") {
    part_mar17();
} else if (mode == "part_mar18") {
    part_mar18();
} else if (mode == "part_jup13") {
    part_jup13();
} else if (mode == "part_jup14") {
    part_jup14();
} else if (mode == "part_jup15") {
    part_jup15();
} else if (mode == "part_jup16") {
    part_jup16();
} else if (mode == "part_jup17") {
    part_jup17();
} else if (mode == "part_jup18") {
    part_jup18();
} else if (mode == "part_jup19") {
    part_jup19();
} else if (mode == "drw022_sheet1") {
    drw022_sheet1();
} else if (mode == "drw022_sheet2") {
    drw022_sheet2();
} else if (mode == "drw022_sheet3") {
    drw022_sheet3();
} else if (mode == "drw022_sheet4") {
    drw022_sheet4();
} else if (mode == "drw022_sheet5") {
    drw022_sheet5();
} else if (mode == "drw022_sheet6") {
    drw022_sheet6();
} else if (mode == "drw022_sheet7") {
    drw022_sheet7();
} else if (mode == "drw012_sheet2") {
    drw012_sheet2();
} else if (mode == "drw012_sheet4") {
    drw012_sheet4();
} else if (mode == "drw012_sheet5") {
    drw012_sheet5();
} else if (mode == "drw012_sheet6") {
    drw012_sheet6();
} else if (mode == "drw012_sheet7") {
    drw012_sheet7();
} else if (mode == "drw012_sheet8") {
    drw012_sheet8();
} else if (mode == "drw012_sheet9") {
    drw012_sheet9();
} else if (mode == "drw013_sheet4") {
    drw013_sheet4();
} else if (mode == "drw013_sheet5") {
    drw013_sheet5();
} else if (mode == "drw013_sheet6") {
    drw013_sheet6();
} else if (mode == "drw013_sheet7") {
    drw013_sheet7();
} else if (mode == "drw010_sheet1") {
    drw010_sheet1();
} else if (mode == "drw010_sheet4") {
    drw010_sheet4();
} else if (mode == "drw010_sheet2") {
    drw010_sheet2();
} else if (mode == "drw010_sheet5") {
    drw010_sheet5();
} else if (mode == "drw010_sheet6") {
    drw010_sheet6();
} else if (mode == "drw010_sheet7") {
    drw010_sheet7();
} else if (mode == "drw010_sheet8") {
    drw010_sheet8();
} else if (mode == "drw010_sheet9") {
    drw010_sheet9();
} else if (mode == "drw008_sheet3") {
    drw008_sheet3();
} else if (mode == "drw008_sheet2") {
    drw008_sheet2();
} else if (mode == "drw009_sheet6") {
    drw009_sheet6();
} else if (mode == "drw009_sheet5") {
    drw009_sheet5();
} else if (mode == "drw009_sheet4") {
    drw009_sheet4();
} else if (mode == "drw009_sheet3") {
    drw009_sheet3();
} else if (mode == "drw009_sheet2") {
    drw009_sheet2();
} else if (mode == "drw009_sheet1") {
    drw009_sheet1();
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
