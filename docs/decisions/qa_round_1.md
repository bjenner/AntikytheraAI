# QA Round 1 (Source CSV Integrity)

Date: 2026-02-21
Scope:
- `ref/meta/drawing_index.csv`
- `ref/meta/parts_list.csv`
- `ref/meta/parts_dedup_map.csv` (reference only)

## Summary
- Drawings indexed: 23 (`DRW-001` to `DRW-023`)
- Parts rows: 197
- High severity issues: 0
- Medium severity issues: 0
- Low severity issues: 1

## Findings
1. Low: `PRT-HOU-004` has `quantity=1` and `max_qty=2` mismatch in `ref/meta/parts_list.csv`.

## Informational Notes
- `date_estimate` is currently `unknown` for:
  - `DRW-009`
  - `DRW-017`
- No duplicate drawing IDs or part IDs detected.
- No orphan drawings detected (every drawing has at least one linked part row).
- All part `source_drawing_ids` resolve to known drawing IDs.

## Recommended Follow-up
1. Decide whether `PRT-HOU-004` should be fixed to exact quantity (`1`) or uncertain range (`1..2`) and keep fields consistent.
2. Optionally attempt secondary metadata extraction path for `DRW-009` and `DRW-017` creation dates.
3. Start medium-confidence dedup resolution from `ref/meta/parts_dedup_map.csv`.


## Post-QA Update
- Resolved medium-confidence duplicate candidates (6 merges) using `ref/meta/parts_dedup_map.csv`.
- Removed merged candidate rows from `ref/meta/parts_list.csv` and consolidated references/ranges into canonical rows.
- Current counts after merge pass: 23 drawings, 191 part rows.
- Re-ran integrity checks: 0 blocking issues.

- Low-confidence dedup pass complete: remaining low-confidence candidates marked `rejected_low_confidence` pending stronger evidence.
