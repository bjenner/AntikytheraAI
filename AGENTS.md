# Agents Configuration

Use this file to define the AI/human agent workflow for the project.
Customize sections marked with `[EDIT ME]`.

## Project

- Name: `AntikytheraAI`
- Primary stack: `OpenSCAD`, Markdown, CSV metadata
- Core folders:
  - `scad/parts` one file per part
  - `scad/assemblies` one file per drawing/sheet or assembly scene
  - `scad/configs/presets.scad` render mode selector
  - `docs/sources/drawing_index.csv` drawing metadata
  - `docs/sources/parts_list.csv` part metadata and reconciliation

## Goals

- Build reusable part modules from source drawings.
- Recreate engineering sheets as OpenSCAD assembly scenes.
- Keep part metadata and drawing metadata synchronized.
- Maintain checkpoint-friendly commits.

## Agent Roles

### 1) `planner`

- Purpose: break work into small, testable tasks.
- Inputs: user intent, current drawing/sheet target.
- Outputs: task list, scope boundaries, checkpoints.
- Rules:
  - Prefer one drawing sheet at a time.
  - Call out assumptions explicitly.
  - Avoid mixing unrelated refactors with drawing work.

### 2) `part_modeler`

- Purpose: create/update part files under `scad/parts`.
- Outputs: `part_<id>()` modules with main-guard preview behavior.
- Rules:
  - File naming: `<part_id>_<slug>.scad` (example: `mar5_gear.scad`).
  - Keep units in mm.
  - Include header metadata comments.
  - Keep geometry parametric where practical.

### 3) `assembly_modeler`

- Purpose: create/update drawing sheet scenes under `scad/assemblies`.
- Outputs: `drwXXX_sheetY()` module + main guard.
- Rules:
  - Reuse part modules; do not duplicate part geometry in assembly files.
  - Include simple title block + labels for traceability.
  - Keep layout readable over exact artistic fidelity.

### 4) `metadata_curator`

- Purpose: maintain source-of-truth CSV metadata.
- Outputs:
  - `drawing_index.csv` rows for newly covered drawings/sheets.
  - `parts_list.csv` rows for new part IDs and reconciliation fields.
- Rules:
  - Always add/update `scad_file=...` in evidence notes or equivalent column.
  - Keep part IDs stable once introduced.

### 5) `qa_reviewer`

- Purpose: run compile and consistency checks.
- Outputs: pass/fail status + issues list.
- Minimum checks:
  - `openscad` compile check for changed part modes.
  - `openscad` compile check for changed assembly mode.
  - Validate `main.scad` wiring and `presets.scad` mode list.
  - Confirm CSV rows exist for new parts.

## Coding Standards

- Parts:
  - Must expose a top-level `part_<id>()` module.
  - Must include:
    - `// ---- "main guard" ----`
    - `if (is_undef(__LIB_MODE__)) { part_<id>(); }`
- Assemblies:
  - Must expose `drwXXX_sheetY()` or clear assembly module name.
  - Must include same main-guard pattern.
- Main router:
  - Add `use <parts/...>` / `use <assemblies/...>` in `scad/main.scad`.
  - Add mode branches for new parts/sheets.
- Presets:
  - Keep mode comment list updated in `scad/configs/presets.scad`.

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

- Suggested format:
  - `feat(drw013-s5): add mar3/mar4/mar8-mar10 and sheet assembly`
  - `chore(metadata): reconcile parts_list for DRW-013 Sheet 5`
  - `fix(scad): repair manifold issue in mar3 tooth ring`

## Handoff Template

When an agent finishes, report:

- Scope completed
- Files added/modified
- Modes added
- Metadata updates
- Validation run + result
- Known gaps / next recommended sheet

## Project-Specific Overrides [EDIT ME]

- Primary fidelity priority: `[EDIT ME: visual match | dimensional fidelity | mixed]`
- Default render quality: `[EDIT ME]`
- Preferred checkpoint cadence: `[EDIT ME: every sheet | every 2 sheets | daily]`
- Include source PNGs in git: `[EDIT ME: yes/no]`
- Branching strategy: `[EDIT ME: main only | feature branches]`
