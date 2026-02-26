# Tasks (next actions)

## OpenSCAD Drawing Processing Status

Source PNGs live in `docs/sources/Drawings/` (gitignored — regenerate from PDFs as needed).
Assembly files: `scad/assemblies/drwXXX_sheetY.scad` · Parts: `scad/parts/<id>_<slug>.scad`

| DRW | Title | PNG Prefix | Pages | SCAD Status | Sheets Done |
|-----|-------|-----------|-------|-------------|-------------|
| DRW-001 | a assembly | `a_page*.png` | 7 | partial | 1,2,4,5,6,7 — missing p3 |
| DRW-002 | b wheel/frame | `b_page*.png` | 10 | partial | 1,2,6,7,8,9,10 — missing p3,4,5 |
| DRW-003 | b1 gear assembly | `b1_gear_assembly_page*.png` | 1 | not started | — |
| DRW-004 | ip plate/gear | `ip_page*.png` | 20 | not started | — |
| DRW-005 | common parts | `Common_Parts_page*.png` | 3 | **complete** | all |
| DRW-006 | back plate | `Back_Plate_page*.png` | 7 | not started | — |
| DRW-007 | callippic | `Callippic_page*.png` | 5 | not started | — |
| DRW-008 | date dial | `Date_page*.png` | 5 | partial | 2,3,4,5 — missing p1 |
| DRW-009 | exeligmos | `Exeligmos_page*.png` | 6 | **complete** | all |
| DRW-010 | front plate | `Front_Plate_page*.png` | 9 | partial | 1,2,4,5,6,7,8,9 — missing p3 |
| DRW-011 | housing | `Housing_page*.png` | 9 | not started | — |
| DRW-012 | jupiter | `Jupiter_page*.png` | 9 | partial | 2,4,5,6,7,8,9 — missing p1,3 |
| DRW-013 | mars | `Mars_page*.png` | 7 | partial | 4,5,6,7 — missing p1,2,3 |
| DRW-014 | mercury | `Mercury_page_*.png` | 10 | not started | — |
| DRW-015 | metonic | `Metonic_page_*.png` | 6 | not started | — |
| DRW-016 | moon | `Moon_page_*.png` | 10 | not started | — |
| DRW-017 | node | `Node_page_*.png` | 6 | not started | — |
| DRW-018 | olympiad | `Olympiad_page_*.png` | 4 | not started | — |
| DRW-019 | saros | `Saros_page_*.png` | 5 | not started | — |
| DRW-020 | saturn | `Saturn_page_*.png` | 8 | not started | — |
| DRW-021 | sun | `Sun_page_*.png` | 8 | not started | — |
| DRW-022 | superior planet plate | `Superior_Planet_Plate_page_*.png` | 7 | partial | 5 — missing p1,2,3,4,6,7 |
| DRW-023 | venus | `Venus_page_*.png` | 9 | not started | — |

**Summary:** 2 complete · 6 partial · 15 not started · 46 / 134 sheets done (34%)

---

## Active Focus (start here)
- [ ] Section `8.11.5 Superior Planet Plate` (`DRW-056`):
      - [x] extract part candidates and functional notes from pages `106-109`
      - [x] map candidate parts to canonical IDs in `docs/sources/parts_list.csv`
      - [x] tag all touched parts with `source_drawing_ids` including `DRW-056`
      - [x] record uncertainties/assumptions in `docs/decisions/`
      - [x] define initial OpenSCAD part-file targets under `scad/parts/` using the naming convention
      - [ ] resolve naming conflict between manual `SP4` pins and drawing `SP6` pins
      - [ ] refine placeholder geometry using section dimensions/tolerances from drawings

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
