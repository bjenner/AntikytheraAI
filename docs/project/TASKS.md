# Tasks (next actions)

## Now (do next)
- [ ] Define canonical drawing index file format (`docs/sources/drawing_index.csv` or `.json`)
- [ ] Inventory all source drawings currently in scope and assign stable drawing IDs
- [ ] Create per-drawing metadata records with required fields:
      - drawing ID, title/description, citation, file/URL
      - revision/version (if known), scale/units (if known)
      - legibility/confidence notes
- [ ] Define canonical parts list schema (`docs/sources/parts_list.csv` or `.json`):
      - part ID, name, category, quantity
      - key dimensions, drawing references
      - confidence and open questions
- [ ] Build first complete draft of the full parts list from the drawings

## Soon
- [ ] Add traceability check: every part maps to one or more drawing IDs
- [ ] Normalize naming/aliases (single preferred name per part + synonyms)
- [ ] Record drawing conflicts and unresolved assumptions in `docs/decisions/`
- [ ] Add coverage summary: total drawings indexed, total parts identified, low-confidence items

## Later
- [ ] Freeze Milestone B baseline (versioned metadata + parts list)
- [ ] Prepare handoff package for resumed modeling (Milestone A continuation)

## Done
- [x] Pause Milestone A and switch active goal to Milestone B
