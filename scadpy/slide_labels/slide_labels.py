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
    ["Arial", "Arial Black", "Times", "Times New Roman", "Courier", "Courier New", "Helvetica", "DejaVu Sans", "Liberation Sans", "Ubuntu", "FreeSans"],
    label="Font for the text"
)

text_style = CustomizerDropdownVariable(
    "text_style",
    0,
    [0, 1],
    label="0: Engraved text, 1: Raised text"
)

# Create the base rectangle
base = cuboid(
    [label_width, label_height, label_thickness],
    anchor=CENTER
)

# Create engraved text (cut into base)
engraved_text_3d = linear_extrude(height=label_thickness + 1)(
    text(
        text=label_text,
        size=text_size,
        font=text_font,
        halign="center",
        valign="center"
    )
).translate([0, 0, -label_thickness / 2])

# Create raised text (added on top)
raised_text_3d = linear_extrude(height=label_thickness)(
    text(
        text=label_text,
        size=text_size,
        font=text_font,
        halign="center",
        valign="center"
    )
).translate([0, 0, label_thickness / 2])

# Combine based on text style using scaling to show/hide parts
# Scale factor: 1 to show, 0 to hide
show_engraved = 1 - text_style  # 1 when text_style=0, 0 when text_style=1
show_raised = text_style        # 0 when text_style=0, 1 when text_style=1

engraved_label = (base - engraved_text_3d).scale([show_engraved, show_engraved, show_engraved])
raised_label = (base + raised_text_3d).scale([show_raised, show_raised, show_raised])

slide_label = engraved_label + raised_label

slide_label.save_as_scad("scadpy/slide_labels/out/slide_labels.scad")