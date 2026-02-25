# Claude Code Project Instructions

## Project

- Name: `AntikytheraAI`
- Primary stack: `OpenSCAD`, Markdown, CSV metadata
- Core folders:
  - `scad/parts` — one file per part
  - `scad/assemblies` — one file per drawing/sheet or assembly scene
  - `scad/configs/presets.scad` — render mode selector
  - `docs/sources/drawing_index.csv` — drawing metadata
  - `docs/sources/parts_list.csv` — part metadata and reconciliation

## Goals

- Build reusable part modules from source drawings.
- Recreate engineering sheets as OpenSCAD assembly scenes.
- Keep part metadata and drawing metadata synchronized.
- Maintain checkpoint-friendly commits.

## Guidelines

### Planning
- Break work into small, testable tasks — prefer one drawing sheet at a time.
- Call out assumptions explicitly.
- Avoid mixing unrelated refactors with drawing work.

### Parts (`scad/parts/`)
- File naming: `<part_id>_<slug>.scad` (example: `mar5_gear.scad`).
- Expose a top-level `part_<id>()` module.
- Keep units in mm.
- Include header metadata comments.
- Keep geometry parametric where practical.

### Assemblies (`scad/assemblies/`)
- File naming: `drwXXX_sheetY.scad`.
- Expose a `drwXXX_sheetY()` module or clearly named assembly module.
- Reuse part modules; do not duplicate part geometry in assembly files.
- Include a simple title block and labels for traceability.
- Keep layout readable over exact artistic fidelity.

### Metadata (`docs/sources/`)
- Always add/update `scad_file=...` in `parts_list.csv` for new parts.
- Add rows to `drawing_index.csv` for newly covered drawings/sheets.
- Keep part IDs stable once introduced.

### QA Checks (run after each sheet)
- `openscad` compile check for changed part files.
- `openscad` compile check for changed assembly file.
- Validate `main.scad` wiring and `presets.scad` mode list.
- Confirm CSV rows exist for all new parts.

## Coding Standards

### Parts
Every part file must include:
```
// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) { part_<id>(); }
```

### Assemblies
Every assembly file must include the same main-guard pattern:
```
// ---- "main guard" ----
if (is_undef(__LIB_MODE__)) { drwXXX_sheetY(); }
```

### Main Router (`scad/main.scad`)
- Add `use <parts/...>` and `use <assemblies/...>` imports for new files.
- Add mode branches for new parts and sheets.

### Presets (`scad/configs/presets.scad`)
- Keep the mode comment list updated when adding new parts or sheets.

## Workflow Per Drawing Sheet

1. Confirm target sheet (`DRW-### Sheet #`) and scope.
2. Identify new vs existing parts.
3. Create/update part files.
4. Create/update assembly sheet file.
5. Wire `main.scad` modes and imports.
6. Update `parts_list.csv` and optionally `drawing_index.csv`.
7. Run compile checks.
8. Commit checkpoint.

## Definition of Done

- All new parts have standalone files and render via main guard.
- Sheet assembly renders from its own file and via `main.scad` mode.
- CSV metadata updated for new parts and drawing coverage.
- No syntax/compile errors in modified files.
- Checkpoint commit created with clear message.

## Commit Conventions

Format: `type(scope): description`

Examples:
- `feat(drw013-s5): add mar3/mar4/mar8-mar10 and sheet assembly`
- `chore(metadata): reconcile parts_list for DRW-013 Sheet 5`
- `fix(scad): repair manifold issue in mar3 tooth ring`

## Project-Specific Settings

- Primary fidelity priority: `dimensional fidelity`
- Default render quality: `preview`
- Preferred checkpoint cadence: `every drawing`
- Include source PNGs in git: `yes` (tracked via Git LFS — `.gitattributes` covers `*.png`, `*.PNG`, `*.csg`)
- Branching strategy: `main only`
