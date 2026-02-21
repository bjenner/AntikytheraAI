# Vision

## Long-term objectives (high level)
- Build an animated, parametric OpenSCAD “digital twin” of the Antikythera mechanism.
- Use the animation to learn and validate kinematics before printing.
- Produce printable parts with documented tolerances and assembly steps.
- Keep the project reproducible: scripts for renders/exports and clear references.

## Design objectives (part-first architecture)
- Model each physical component as its own OpenSCAD part file (one primary part per file).
- Treat part files as reusable building blocks used by multiple higher-level scenes.
- Keep assemblies as composition layers only: minimal duplicated geometry in assembly files.
- Keep all part parameters stable and documented so scenes can reuse the same part definitions.

## Required usage modes
- `Single-part manufacturing`: render/export one part at a time for printing or other fabrication methods.
- `Engineering drawing recreation`: compose drawing-style scenes from the same part modules.
- `Assembly process animation`: sequence parts and subassemblies into step-by-step build animations.
- `Assembled mechanism animation`: run kinematic motion on the fully assembled model.
- `Exploded device view`: generate exploded layouts from the same assembly definition.

## Modeling principles
- One source of truth for geometry: part files under `scad/parts/`.
- One source of truth for relationships: assembly files under `scad/assemblies/`.
- Config-driven scene selection via `scad/main.scad` and preset files.
- Export workflows should consume the same scenes/modules used in OpenSCAD preview.

## Non-goals (for now)
- Perfect historical accuracy of every missing fragment
- High-detail decorative geometry
