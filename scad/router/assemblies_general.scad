// General assembly router.
// SPDX-License-Identifier: MIT

use <../assemblies/full_mechanism.scad>
use <../assemblies/parts_inventory.scad>

ASSEMBLY_MODES_GENERAL = ["parts_inventory", "assembly", "exploded", "animate"];

module route_assemblies_general(mode, spin_theta, exploded_gap) {
    if (mode == "parts_inventory") {
        parts_inventory();
    } else if (mode == "assembly") {
        full_mechanism(theta = 0, exploded_gap = 0);
    } else if (mode == "exploded") {
        full_mechanism(theta = 0, exploded_gap = exploded_gap);
    } else if (mode == "animate") {
        full_mechanism(theta = spin_theta, exploded_gap = 0);
    }
}
