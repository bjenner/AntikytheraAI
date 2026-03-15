# DRW-001 Sheet 5 Overlay Workflow

This workflow is the current repeatable path for producing a composite animation
of the DRW-001 Sheet 5 part rotation over the source drawing image.

It is designed around the current OpenSCAD GUI frame-dump behavior on macOS.

## Goal

Produce:
- a deterministic parts-pass frame sequence
- a deterministic composite frame sequence over `a_page05.png`

## Standard Paths

- Shared workflow config:
  - `config/sheet5_overlay.env`
- Source drawing page:
  - `ref/drawings/DRW-001-A-Assembly/a_page05.png`
- GUI-dumped raw frames:
  - `scad/frame00000.png` etc.
- Ingested parts-pass frames:
  - `exports/DRW-001-A-Assembly/sheet5_parts_pass/`
- Composite frames:
  - `exports/DRW-001-A-Assembly/sheet5_composite/`

## Render Mode

Use:
- `mode = "drw001_sheet5_parts_animate"`

This mode is wired through `scad/main.scad` and renders only the rotating Sheet 5
parts scene, not the static reconstructed sheet.

## Shared Settings

The workflow now uses:
- `config/sheet5_overlay.env`

This file stores:
- render mode
- frame count
- image size
- optional explicit OpenSCAD camera string
- standard input/output directories
- composite offsets and white-key threshold

## Camera Capture

For deterministic CLI export, capture a known-good OpenSCAD camera string from the GUI
and store it in:
- `config/sheet5_overlay.env`

Set:
- `CAMERA="..."`

Recommended process:
- open `scad/main.scad`
- set `mode = "drw001_sheet5_parts_animate"`
- adjust the viewport until the framing looks right
- copy the viewport/camera parameters from OpenSCAD
- paste that string into `CAMERA=...`

When `CAMERA` is non-empty, the render helper will use it directly.
When `CAMERA` is empty, the helper falls back to:
- `--viewall`
- `--autocenter`

## Workflow

### 1. Dump frames from the OpenSCAD GUI

Open:
- `scad/main.scad`

Set:
- `mode = "drw001_sheet5_parts_animate"`

In the OpenSCAD GUI:
- use a fixed window size
- keep the same camera/view for the whole dump
- export the full animation frame sequence

The dumped files currently land in:
- `scad/frame00000.png` etc.

### 2. Ingest the GUI dump into the standard exports location

Copy the raw GUI dump into the standard parts-pass directory:

```bash
bash scripts/ingest_sheet5_gui_frames.sh
```

Or move them instead of copying:

```bash
bash scripts/ingest_sheet5_gui_frames.sh --move
```

This step:
- validates that the frame sequence is contiguous
- copies or moves the frames into
  `exports/DRW-001-A-Assembly/sheet5_parts_pass/`

### 3. Composite the parts over the source drawing page

Run:

```bash
python3 scripts/compose_sheet5_overlay.py
```

The default alignment values now come from:
- `config/sheet5_overlay.env`

This writes composite frames to:
- `exports/DRW-001-A-Assembly/sheet5_composite/`

### 4. Assemble the composite frames into a movie

Outside the repo workflow, use one of:
- QuickTime image-sequence import
- `ffmpeg`
- another editor that supports image sequences

## Notes

- This is the current practical workflow, not the final ideal one.
- The long-term improvement is a fully deterministic OpenSCAD render pipeline
  with fixed camera, fixed output size, and no manual GUI frame dump.
- The current workflow is still good enough to produce shareable results
  consistently once the same GUI view is reused.
