# Gridfinity Stack Labels

This module generates customizable gridfinity-compatible stackable labels. The labels mimic the base of gridfinity bins, allowing them to stack on top of each other or on any gridfinity bin.

## Features

- Customizable grid dimensions (X and Y number of cells)
- Customizable text content and size
- Choice between engraved text (cut into the label) or raised text (on top of the label)
- Gridfinity-compatible stacking design

## Parameters

- **grid_x**: Number of grid units in X direction (default: 2, range: 1-10)
- **grid_y**: Number of grid units in Y direction (default: 1, range: 1-10)
- **label_text**: Text to display on the label (default: "GRIDFINITY LABEL")
- **text_size**: Size of the text (default: 20, range: 5-50)
- **text_style**: Whether text is engraved into or raised on top of the label (default: 0, options: 0=engraved, 1=raised)

## Usage

Run the module to generate the OpenSCAD file:

```bash
python scadpy/gridfinity_stack_labels/gridfinity_stack_labels.py
```

Then open `scadpy/gridfinity_stack_labels/out/gridfinity_stack_labels.scad` in OpenSCAD to customize and render the label.