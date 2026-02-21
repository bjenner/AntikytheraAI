// Antikyth main entrypoint.
// Set mode/quality in configs/presets.scad.
// SPDX-License-Identifier: MIT

include <configs/presets.scad>
use <parts/a1.scad>
use <assemblies/full_mechanism.scad>

$fn = quality == "render" ? 160 : 72;

spin_theta = mode == "animate" ? 360 * spin_turns * $t : 0;

if (mode == "part_a1") {
    part_a1();
} else if (mode == "assembly") {
    full_mechanism(theta = 0, exploded_gap = 0);
} else if (mode == "exploded") {
    full_mechanism(theta = 0, exploded_gap = exploded_gap);
} else if (mode == "animate") {
    full_mechanism(theta = spin_theta, exploded_gap = 0);
} else {
    echo(str("Unknown mode: ", mode));
}
