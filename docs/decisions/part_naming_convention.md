# Decision: Part File and Naming Convention

## Status
Accepted

## Scope
All new files under `scad/parts/` and their primary module interfaces.

## Convention
1. File naming
- Format: `<part_id>_<slug>.scad`
- Examples: `a1_crank_handle.scad`, `b1_main_wheel.scad`, `sun_01_pointer_arm.scad`
- Rules: lowercase, snake_case, ASCII only, no spaces

2. Part IDs
- Preserve source IDs when available (`a1`, `b1`, `ip`, `sp3`)
- If no source ID exists, use `<subsystem>_<nn>` (for example `sun_01`, `node_03`, `housing_02`)

3. Module naming
- Primary module in each part file: `part_<part_id>()`
- Optional view/mode modules:
  - `part_<part_id>_print()`
  - `part_<part_id>_draw()`
  - `part_<part_id>_asm()`

4. Origin and orientation
- Z-up
- Mounted/base face on `Z=0`
- Mechanical centerline on world origin when practical
- `+X` points to nominal forward/radial reference

5. Required header metadata (comment block at top of each part file)
- `part_id`
- `name`
- `source_drawing_ids`
- `units` (`mm`)
- `revision`

## Rationale
This convention supports reuse of the same part model across:
- single-part manufacturing exports
- engineering drawing recreation
- assembly animation
- assembled mechanism animation
- exploded views

It also creates stable naming for scripts, scene composition, and traceability back to source drawings.
