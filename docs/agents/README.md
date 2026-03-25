# Agent Prompts

These prompt files are lightweight role presets for Codex / ChatGPT in VS Code.
They are not first-class VS Code agents; they are reusable prompts you can paste
at the start of a chat when you want the assistant to stay focused on one kind of work.

Recommended usage:
- Keep `AGENTS.md` as the global repo policy.
- Start a fresh chat for each focused task.
- Paste one role prompt from this folder.
- Then add the immediate target, for example:
  - `Target: DRW-004 Sheet 9`
  - `Target: scad/parts/DRW-004-IP-Plate-Gear-Assembly/c1_gear.scad`
  - `Target: ref/meta/parts_list.csv`

Suggested roles:
- `planner.md`
- `part-modeler.md`
- `assembly-modeler.md`
- `metadata-curator.md`
- `qa-reviewer.md`

Good pattern:
1. Open a new chat.
2. Paste one role prompt.
3. Add the specific drawing, sheet, or file target.
4. Keep the chat scoped to that one purpose.

Example:

```text
<paste docs/agents/part-modeler.md>

Target: DRW-004 Sheet 9
Focus: create or refine `c1_gear.scad`
Constraint: keep the part centered on the gear axis and stop after one part for visual review.
```
