from solid2 import (
    CustomizerSliderVariable,
    CustomizerTextboxVariable,
    CustomizerDropdownVariable,
    linear_extrude,
    text,
    set_global_fn,
)
from solid2.extensions.bosl2 import cuboid, CENTER

set_global_fn(50)

# Customizable parameters for the slide label
label_width = CustomizerSliderVariable(
    "label_width",
    50,
    min_=10,
    max_=200,
    label="Width of the label in mm"
)

label_height = CustomizerSliderVariable(
    "label_height",
    20,
    min_=5,
    max_=100,
    label="Height of the label in mm"
)

label_thickness = CustomizerSliderVariable(
    "label_thickness",
    2,
    min_=0.5,
    max_=10,
    label="Thickness of the label in mm"
)

label_text = CustomizerTextboxVariable(
    "label_text",
    "LABEL",
    label="Text to display on the label"
)

text_size = CustomizerSliderVariable(
    "text_size",
    8,
    min_=1,
    max_=50,
    label="Size of the text"
)

text_font = CustomizerDropdownVariable(
    "text_font",
    "Arial",
    ["Arial", "Times", "Courier", "Helvetica"],
    label="Font for the text"
)

text_depth = CustomizerSliderVariable(
    "text_depth",
    0.5,
    min_=0.1,
    max_=5,
    label="Depth of the text engraving (0 for raised text)"
)

# Create the base rectangle
base = cuboid(
    [label_width, label_height, label_thickness],
    anchor=CENTER
)

# Create the text - engraved into the top surface
label_text_3d = linear_extrude(height=label_thickness + 1)(
    text(
        text=label_text,
        size=text_size,
        font=text_font,
        halign="center",
        valign="center"
    )
).translate([0, 0, -label_thickness / 2])

# Combine base and text (engraved)
slide_label = base - label_text_3d

slide_label.save_as_scad("scadpy/slide_labels/out/slide_labels.scad")