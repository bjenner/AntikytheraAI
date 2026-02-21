# Current Goal: Source-drawing analysis and parts inventory (Milestone B)

## Status update
- Milestone A (animated scaffold) is on hold.

## Outcome
Create a reliable analysis baseline from source drawings that includes:
- structured metadata for each drawing
- a normalized, traceable master parts list for the full device
- explicit links from parts to drawing evidence

## Acceptance criteria
- A metadata record exists for every drawing currently in scope, with at least:
  - drawing ID
  - title/description
  - source/citation
  - file path or URL
  - revision/version (if known)
  - scale and units (if known)
  - legibility/confidence notes
- A complete parts list exists for the full mechanism in machine-readable form (CSV or JSON), including at least:
  - part ID
  - name
  - category (gear, shaft, plate, pin, pointer, fastener, spacer, other)
  - quantity
  - key dimensions (or unknown markers)
  - source drawing references
  - confidence level and open questions
- Every part entry is traceable to one or more drawing references.
- A short assumptions/ambiguities section documents unresolved conflicts between drawings.

## Milestone A (on hold)
Animated scaffold work remains paused until Milestone B is accepted.

## Next milestone (after B)
Resume animation/modeling using the validated parts inventory as the source of truth.
