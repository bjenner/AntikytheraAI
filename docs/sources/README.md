# Source Data Templates

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
