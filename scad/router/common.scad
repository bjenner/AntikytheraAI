// Shared router helpers.
// SPDX-License-Identifier: MIT

function route_has(modes, target, index = 0) =
    index >= len(modes) ? false :
    modes[index] == target || route_has(modes, target, index + 1);
