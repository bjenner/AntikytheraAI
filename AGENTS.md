# Agents Configuration

This repository is an OpenSCAD-first codebase for modeling parts and recreating engineering drawing sheets.
Agents should keep changes checkpoint-friendly and preserve drawing/part traceability.

## Project

- Name: `AntikytheraAI`
- Primary stack: OpenSCAD (`.scad`), Markdown (`.md`), CSV metadata (`.csv`)
- Supporting tools: Bash scripts, small Python utilities, GitHub Actions, Git LFS
- Core folders:
  - `scad/parts/` one file per reusable part
  - `scad/assemblies/` one file per drawing sheet or assembly scene
  - `scad/configs/presets.scad` render mode selector
  - `scad/main.scad` top-level router for all modes
  - `docs/sources/drawing_index.csv` drawing coverage metadata
  - `docs/sources/parts_list.csv` part metadata and reconciliation evidence

## Commands

Prerequisites:
- `openscad` in `PATH`, or the macOS app at `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD`
- `bash`
- `python3` for helper scripts
- `git-lfs` if using repo hooks or working with tracked LFS assets

Build / export:
- Full compile check: `bash scripts/check_all.sh`
- Stop on first compile failure: `bash scripts/check_all.sh --stop-on-error`
- Export changed `.scad` files: `bash scripts/export.sh --changed`
- Export one file explicitly: `bash scripts/export.sh --file scad/parts/a1.scad`
- Python wrapper for local exports: `python3 scripts/export.py --changed`
- Side-by-side QA preview: `python3 scripts/qa_preview.py drw001_sheet2`
- Sheet PNG exports use a fixed orthographic camera for closer source-drawing alignment
- Example direct STL export: `openscad -o exports/stl/part_a1.stl scad/parts/a1.scad`
- Example direct PNG export: `openscad -o exports/png/drw001_sheet1.png scad/assemblies/drw001_sheet1.scad`

Lint / policy:
- Validate root agent policy file: `bash scripts/check_agents_policy.sh`

Tests in this repo are primarily compile checks:
- Compile one part file: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' scad/parts/<file>.scad`
- Compile one assembly file: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' scad/assemblies/<file>.scad`
- Compile one router mode through `main.scad`: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' -D 'mode="part_a1"' scad/main.scad`
- Compile one sheet mode through `main.scad`: `openscad --export-format csg -o /tmp/scad_check.csg -D '__LIB_MODE__=1' -D 'mode="drw001_sheet1"' scad/main.scad`

Single-test guidance:
- For part geometry issues, compile the part file directly first.
- For wiring issues, compile `scad/main.scad` with the relevant `mode` override.
- For broad QA before handoff, run `bash scripts/check_all.sh`.

Local hooks:
- Install repo hooks: `bash scripts/install-hooks.sh`
- Current hooks run AGENTS policy checks and Git LFS integration.

CI:
- GitHub Actions validates AGENTS policy via `.github/workflows/agents-policy.yml`.

Cursor / Copilot rules:
- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` files exist in this repository at the time of writing.

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

- Purpose: create/update part files under `scad/parts/`.
- Outputs: `part_<id>()` modules with main-guard preview behavior.
- Rules:
  - File naming: `<part_id>_<slug>.scad`.
  - Keep units in mm.
  - Include short header metadata comments.
  - Keep geometry parametric where practical.

### 3) `assembly_modeler`

- Purpose: create/update drawing sheet scenes under `scad/assemblies/`.
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
  - Always add/update `scad_file=...` evidence or equivalent notes.
  - Keep part IDs stable once introduced.

### 5) `qa_reviewer`

- Purpose: run compile and consistency checks.
- Outputs: pass/fail status + issue list.
- Minimum checks:
  - `bash scripts/check_agents_policy.sh`
  - `bash scripts/check_all.sh`
  - Compile changed router modes through `scad/main.scad` when wiring was touched.
  - Confirm CSV rows exist for new parts and new sheets.

## Code Style Guidelines

General:
- Prefer small, local edits over broad refactors.
- Keep source files ASCII unless an existing file already requires otherwise.
- Use millimeters for all dimensions.
- Favor explicit geometry and readable layout over clever compactness.

Formatting:
- Use 4-space indentation.
- Keep braces on the same line for `module`, `if`, `for`, `union`, `difference`, and `intersection`.
- Split long parameter lists across lines when readability improves.
- Preserve existing style in touched files when it is already consistent.

Imports and includes:
- Use `use <...>` for part and assembly dependencies.
- Use `include <...>` only when importing shared variables/configs such as presets.
- In assembly files, prefer relative paths such as `use <../parts/a1.scad>`.
- When adding a new file, wire it in `scad/main.scad` and update the mode comment list in `scad/configs/presets.scad`.

Types and parameters:
- OpenSCAD is dynamically typed; use clear parameter names instead of relying on implicit meaning.
- Suffix dimensions consistently where practical: `_d`, `_r`, `_h`, `_w`, `_th`, `_count`.
- Prefer parameters over magic numbers for dimensions that are likely to change.
- Use helper functions/modules for repeated geometric patterns.

Naming conventions:
- Part files: lowercase snake_case, ASCII only, no spaces.
- Part IDs should preserve source IDs when available: `a1`, `b1`, `sp3`, `mar12`.
- Part modules: `part_<part_id>()`.
- Assembly files: `drwXXX_sheetY.scad`.
- Assembly modules: `drwXXX_sheetY()` or a clearly scoped assembly name.
- Helper modules/functions: lowercase snake_case.

Headers and main guards:
- Start files with a brief description and `SPDX-License-Identifier: MIT` when matching surrounding files.
- Every part file must include:
  - `// ---- "main guard" ----`
  - `if (is_undef(__LIB_MODE__)) { part_<id>(); }`
- Every assembly file must include the same main-guard pattern for its top-level module.

Error handling:
- Bash scripts should use `set -euo pipefail`.
- Fail fast on invalid project state or missing prerequisites.
- Print actionable error messages to stderr.
- In OpenSCAD, use `assert(...)` only when invalid inputs would otherwise create misleading geometry.

Metadata and traceability:
- New parts must be reflected in `docs/sources/parts_list.csv`.
- New drawing coverage must be reflected in `docs/sources/drawing_index.csv`.
- Keep `scad_file=...` evidence populated for traceability.
- Do not rename stable part IDs casually; metadata continuity matters.

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
- `bash scripts/check_agents_policy.sh` passes.
- `bash scripts/check_all.sh` passes.
- Checkpoint commit created with a clear message when the user asks for one.

## Commit Conventions

- Suggested format: `type(scope): why`
- Examples:
  - `feat(drw013-s5): add mar3 mar4 and sheet assembly`
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

## Project-Specific Defaults

- Primary fidelity priority: dimensional fidelity
- Default render quality: preview
- Preferred checkpoint cadence: every drawing sheet
- Include source PNGs in git: yes, via Git LFS where tracked
- Branching strategy: main only unless the user requests otherwise
