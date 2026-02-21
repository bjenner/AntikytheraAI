# AntikytheraAI

OpenSCAD project for building and animating an Antikythera-inspired mechanism with AI assistants.

## Project Layout

- `docs/`: sources, design decisions, and assembly notes.
- `scad/`: reusable libraries, parts, assemblies, configs, and top-level entrypoint.
- `exports/`: generated STL, PNG, and DXF output.
- `scripts/`: helper scripts for exports and automation.

## Quick Start

1. Open `scad/main.scad` in OpenSCAD.
2. Edit `scad/configs/presets.scad`:
- `mode`: `"part_a1"`, `"assembly"`, `"exploded"`, or `"animate"`
- `quality`: `"preview"` or `"render"`
3. Press Preview (`F5`) for interactive checks.
4. For animation mode, use Design -> Animate and set FPS/Steps as needed. `spin_turns` controls revolutions per cycle.

## Current Starter Modules

- `scad/parts/a1.scad`: placeholder driven gear/disc.
- `scad/assemblies/full_mechanism.scad`: base plate + rotating A1 placement.
- `scad/main.scad`: top-level selector and animation driver.

## Next Build Targets

- Add tooth-profiled gears in `scad/lib/` and swap placeholders.
- Add additional historical part files under `scad/parts/`.
- Add kinematic links for coupled gear trains in `scad/assemblies/`.

## Source References

This project was developed using publicly available engineering drawings
and research materials for the Antikythera Mechanism.

Primary reference:

• Antikythera Mechanism Engineering Drawings  
  https://www.amclock.net/

These materials are not redistributed in this repository.
All original works remain the copyright of their respective owners.

Licensed under CC BY 4.0