## Using Agent Prompts

These prompt files are intended to set up a fresh chat for one focused task in this repository.

`AGENTS.md` remains the global repo policy. The files in `docs/agents/` are lightweight role presets that narrow the assistant to one kind of work.

## Recommended Pattern

1. Open a new chat.
2. Pick one role.
3. State the target immediately.
4. Keep the chat scoped to that single purpose.

In this repo, the preferred pattern is to use the role trigger phrase defined in `AGENTS.md` instead of pasting the whole prompt file.

Example:

```text
Take the role of part-modeler. Target: scad/parts/DRW-004-IP-Plate-Gear-Assembly/c1_gear.scad.
```

Another example:

```text
Take the role of planner. Target: DRW-004 Sheet 9.
```

## When To Use Each Role

- `planner`: break work into small, testable steps before implementation
- `part-modeler`: create or refine one part file under `scad/parts/`
- `assembly-modeler`: create or refine one drawing sheet or subassembly under `scad/assemblies/`
- `metadata-curator`: update metadata in `ref/meta/`
- `qa-reviewer`: run validation and report concrete issues

## Best Practices

- Use one chat per role.
- Prefer one drawing sheet or one part at a time.
- Include the exact file path when you already know it.
- Add constraints up front if they matter.
- Start a new chat when switching roles.

Useful constraint examples:

- `Constraint: stop after one part for visual review.`
- `Constraint: do not touch metadata in this pass.`
- `Constraint: validate only the changed router mode.`

## Copy-Paste Starters

Planner:

```text
Take the role of planner. Target: DRW-004 Sheet 9.
Goal: break the work into small checkpoints.
Constraint: keep scope to one sheet.
```

Part modeler:

```text
Take the role of part-modeler. Target: scad/parts/DRW-004-IP-Plate-Gear-Assembly/c1_gear.scad.
Focus: create or refine one part.
Constraint: keep the part centered on the gear axis and pause for review after this file.
```

Assembly modeler:

```text
Take the role of assembly-modeler. Target: scad/assemblies/DRW-004-IP-Plate-Gear-Assembly/drw004_sheet9.scad.
Focus: update the sheet layout using existing part modules.
Constraint: keep placement logic in the assembly only.
```

Metadata curator:

```text
Take the role of metadata-curator. Target: ref/meta/parts_list.csv.
Focus: add or reconcile rows for the parts introduced by DRW-004 Sheet 9.
Constraint: make minimal CSV edits only.
```

QA reviewer:

```text
Take the role of qa-reviewer. Target: DRW-004 Sheet 9.
Focus: validate the changed files only, then report pass/fail and file-level issues.
Constraint: do not make speculative feature changes.
```

## Fallback Pattern

If your chat client does not honor the repo's role invocation convention, paste the full contents of the relevant file from `docs/agents/` into a fresh chat, then add:

```text
Target: ...
Focus: ...
Constraint: ...
```

## Suggested Workflow Across Chats

1. Start with `planner` for a target sheet or part.
2. Move to `part-modeler` or `assembly-modeler` for implementation.
3. Use `metadata-curator` if CSV updates are needed.
4. Finish with `qa-reviewer` for validation.

This keeps work checkpoint-friendly and aligned with the repository workflow in `AGENTS.md`.
