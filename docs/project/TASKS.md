# Tasks (next actions)

## Now (do next)
- [x] Split manual into section PDFs (append page ranges in filenames):
      - `manual_sec6_assembly_disassembly_pXXX-YYY.pdf`
      - `manual_sec61_main_assembly_pXXX-YYY.pdf`
      - `manual_sec62_back_internal_plate_subassembly_pXXX-YYY.pdf`
      - `manual_sec63_planet_gear_box_assembly_pXXX-YYY.pdf`
      - `manual_sec64_superior_planet_subassembly_pXXX-YYY.pdf`
      - `manual_sec641_saturn_sun_subassembly_pXXX-YYY.pdf`
      - `manual_sec642_jupiter_subassembly_pXXX-YYY.pdf`
      - `manual_sec643_mars_subassembly_pXXX-YYY.pdf`
      - `manual_sec644_sun_slot_axle_subassembly_pXXX-YYY.pdf`
      - `manual_sec65_b1_subassembly_pXXX-YYY.pdf`
      - `manual_sec66_housing_subassembly_pXXX-YYY.pdf`
- [x] Split manufacturing-order PDFs (append page ranges in filenames):
      - `manual_sec811_manufacturing_order_pXXX-YYY.pdf`
      - `manual_sec811x_subsections_pXXX-YYY.pdf` (or one PDF per subsection)
- [x] Split supporting-reference PDFs (append page ranges in filenames):
      - `manual_sec83_engineering_manufacturing_drawings_pXXX-YYY.pdf`
      - `manual_sec88_gear_teeth_profile_pXXX-YYY.pdf`
      - `manual_sec75_gear_ratio_size_estimates_pXXX-YYY.pdf`
      - `manual_sec74_3d_computer_models_pXXX-YYY.pdf`
- [x] Place extracted page-range PDFs in `docs/sources/Antikythera Mechanism/extracted/`
- [x] Add each extracted PDF to `docs/sources/drawing_index.csv` with page-range in title/notes
- [x] Define part-file convention for `scad/parts/`:
      - one physical part per file
      - canonical module name per part ID
      - standard origin/orientation convention
      - documented in `docs/decisions/part_naming_convention.md`
- [ ] Create usage-mode scene stubs in `scad/assemblies/`:
      - single-part scene
      - engineering-drawing scene
      - assembly-process scene
      - assembled-motion scene
      - exploded-view scene
- [ ] Define scene-selection contract in `scad/main.scad` (mode -> module mapping)
- [x] Run QA pass on `docs/sources/drawing_index.csv` for consistency:
      - `date_estimate` completeness (`unknown` vs extracted dates)
      - naming consistency for `fragment_scope`
      - duplicate/near-duplicate description cleanup
- [x] Run QA pass on `docs/sources/parts_list.csv`:
      - category consistency
      - quantity/min-max consistency
      - low-confidence rows needing immediate clarification
- [x] Resolve QA finding: `PRT-HOU-004` quantity/max range mismatch
- [x] Attempt secondary extraction for missing `date_estimate` on `DRW-009` and `DRW-017`
- [x] Perform next dedup pass:
      - resolve medium-confidence candidates in `docs/sources/parts_dedup_map.csv`
      - promote/reject candidates with rationale
- [ ] Record key conflicts/assumptions in `docs/decisions/`

## Soon
- [ ] Map canonical part IDs from `docs/sources/parts_list.csv` to planned `scad/parts/*.scad` files
- [ ] Add automated traceability check: every part maps to one or more drawing IDs
- [ ] Normalize naming/aliases (single preferred name per part + synonyms)
- [ ] Add coverage summary: total drawings indexed, total parts identified, low-confidence items
- [ ] Add simple validation script (`scripts/validate_sources.py`) for CSV lint checks

## Later
- [ ] Freeze Milestone B baseline (versioned metadata + parts list)
- [ ] Prepare handoff package for resumed modeling (Milestone A continuation)

## Done
- [x] Pause Milestone A and switch active goal to Milestone B
- [x] Define canonical drawing index format in `docs/sources/drawing_index.csv`
- [x] Define canonical parts list format in `docs/sources/parts_list.csv`
- [x] Create source-data field documentation in `docs/sources/README.md`
- [x] Inventory and index all current source PDFs in scope (23 drawings: `DRW-001` to `DRW-023`)
- [x] Create per-drawing metadata records for all currently indexed drawings
- [x] Build first full draft parts list from all currently indexed drawings
- [x] Add initial dedup map in `docs/sources/parts_dedup_map.csv`
- [x] Apply high-confidence dedup merge pass (merged `PRT-B1-005` into `PRT-B-005`)
- [x] Run QA Round 1 and record findings in `docs/decisions/qa_round_1.md`
- [x] Complete low-confidence dedup pass (mark unresolved pairs as rejected pending stronger evidence)
