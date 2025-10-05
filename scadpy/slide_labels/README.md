# Slide Labels

This module generates customizable slide labels - simple extruded rectangles with text that can be either engraved into or raised on top of the label.

## Features

- Customizable label dimensions (width, height, thickness)
- **Multiline text support** - up to 3 lines of text
- Customizable text content, size, and font
- Choice between engraved text (cut into the label) or raised text (on top of the label)
- All parameters can be adjusted through the OpenSCAD customizer

## Parameters

- **label_width**: Width of the label in mm (default: 50, range: 10-200)
- **label_height**: Height of the label in mm (default: 30, range: 5-100)
- **label_thickness**: Thickness of the label in mm (default: 2, range: 0.5-10)
- **label_text**: First line of text to display on the label (default: "SLIDE LABEL")
- **text_line_2**: Second line of text (default: "", leave empty for single line)
- **text_line_3**: Third line of text (default: "", leave empty for fewer lines)
- **text_size**: Size of the text (default: 8, range: 1-50)
- **text_font**: Font for the text (default: "Arial", options: Arial, Arial Black, Times, Times New Roman, Courier, Courier New, Helvetica, DejaVu Sans, Liberation Sans, Ubuntu, FreeSans)
- **text_style**: Whether text is engraved into or raised on top of the label (default: 0, options: 0=engraved, 1=raised)

## Usage

Run the module to generate the OpenSCAD file:

```bash
poetry run python -m scadpy.slide_labels.slide_labels
```

Then open `out/slide_labels.scad` in OpenSCAD to customize and render the label.