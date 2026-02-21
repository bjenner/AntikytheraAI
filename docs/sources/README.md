# Source Data Templates

Licensing and attribution for redistributed third-party source materials in
this folder are documented in `THIRD_PARTY_NOTICES.md` at the repository root.

## `drawing_index.csv`
One row per drawing/image/source artifact in scope.

Field notes:
- `drawing_id`: stable ID like `DRW-001`
- `source_citation`: bibliographic citation or short source label
- `file_path_or_url`: local path under `docs/sources/` or external URL
- `legibility_confidence`: suggested scale `high|medium|low`
- `metadata_confidence`: confidence that extracted metadata is correct

## `parts_list.csv`
One row per distinct part (not per instance).

Field notes:
- `part_id`: stable ID like `PRT-001`
- `category`: one of `gear|shaft|plate|pin|pointer|fastener|spacer|other`
- `quantity`: preferred known quantity when fixed
- `min_qty` / `max_qty`: use when exact quantity is uncertain
- `key_dimensions_mm`: concise structured text, e.g. `OD=32; thickness=2.5; bore=3`
- `source_drawing_ids`: semicolon-separated references, e.g. `DRW-001;DRW-014`
- `confidence`: suggested scale `high|medium|low`
- `status`: suggested values `identified|inferred|needs_review`

## `parts_dedup_map.csv`
A proposed dedup/canonicalization map for parts that may represent the same physical component.

Field notes:
- `canonical_part_id`: preferred ID to keep if merged
- `candidate_part_id`: potentially duplicate ID
- `confidence`: confidence in duplication (`high|medium|low`)
- `decision`: current state (e.g. `candidate_merge`)
- `reason`: why these are suspected duplicates
- `next_action`: evidence needed before merging
