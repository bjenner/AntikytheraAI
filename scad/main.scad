// Antikyth main entrypoint.
// Set mode/quality in configs/presets.scad.
// SPDX-License-Identifier: MIT

include <configs/presets.scad>
include <router/common.scad>
include <router/parts_drw001.scad>
include <router/parts_drw002.scad>
include <router/parts_drw005.scad>
include <router/parts_drw008.scad>
include <router/parts_drw022.scad>
include <router/parts_misc.scad>
include <router/parts_drw010.scad>
include <router/parts_drw012.scad>
include <router/parts_drw013.scad>
include <router/assemblies_drw001.scad>
include <router/assemblies_drw002.scad>
include <router/assemblies_misc.scad>
include <router/assemblies_general.scad>

$fn = quality == "render" ? 160 : 72;

spin_theta = mode == "animate" ? 360 * spin_turns * $t : 0;

if (route_has(PART_MODES_DRW001, mode)) {
    route_parts_drw001(mode);
} else if (route_has(PART_MODES_DRW002, mode)) {
    route_parts_drw002(mode);
} else if (route_has(PART_MODES_DRW005, mode)) {
    route_parts_drw005(mode);
} else if (route_has(PART_MODES_DRW008, mode)) {
    route_parts_drw008(mode);
} else if (route_has(PART_MODES_DRW022, mode)) {
    route_parts_drw022(mode);
} else if (route_has(PART_MODES_MISC, mode)) {
    route_parts_misc(mode);
} else if (route_has(PART_MODES_DRW010, mode)) {
    route_parts_drw010(mode);
} else if (route_has(PART_MODES_DRW012, mode)) {
    route_parts_drw012(mode);
} else if (route_has(PART_MODES_DRW013, mode)) {
    route_parts_drw013(mode);
} else if (route_has(ASSEMBLY_MODES_DRW001, mode)) {
    route_assemblies_drw001(mode, spin_turns, exploded_gap);
} else if (route_has(ASSEMBLY_MODES_DRW002, mode)) {
    route_assemblies_drw002(mode);
} else if (route_has(ASSEMBLY_MODES_MISC, mode)) {
    route_assemblies_misc(mode);
} else if (route_has(ASSEMBLY_MODES_GENERAL, mode)) {
    route_assemblies_general(mode, spin_theta, exploded_gap);
} else {
    echo(str("Unknown mode: ", mode));
}
