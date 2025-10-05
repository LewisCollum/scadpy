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
    30,
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
    "SLIDE",
    label="Text to display on the label (single line)"
)

text_line_2 = CustomizerTextboxVariable(
    "text_line_2",
    "LABEL",
    label="Second line of text (leave empty for single line)"
)

text_line_3 = CustomizerTextboxVariable(
    "text_line_3",
    "",
    label="Third line of text (leave empty for fewer lines)"
)

text_size = CustomizerSliderVariable(
    "text_size",
    10,
    min_=1,
    max_=50,
    label="Size of the first line of text"
)

text_size_2 = CustomizerSliderVariable(
    "text_size_2",
    8,
    min_=1,
    max_=50,
    label="Size of the second line of text"
)

text_size_3 = CustomizerSliderVariable(
    "text_size_3",
    6,
    min_=1,
    max_=50,
    label="Size of the third line of text"
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

# Function to create multiline text
def create_multiline_text(line1, line2, line3, size1, size2, size3, font, height):
    """Create 3D text from multiple lines with different sizes"""
    # Use a fixed line spacing based on the largest typical text size
    # This ensures consistent spacing regardless of individual text sizes
    line_spacing = 12  # Fixed spacing that works well for text sizes 6-12
    
    # Create all three lines of text, positioned vertically
    text_objects = []
    
    # Line 1 (top) - use size1
    text_2d_1 = text(
        text=line1,
        size=size1,
        font=font,
        halign="center",
        valign="center"
    )
    text_3d_1 = linear_extrude(height=height)(text_2d_1).translate([0, line_spacing, 0])
    text_objects.append(text_3d_1)
    
    # Line 2 (middle) - use size2
    text_2d_2 = text(
        text=line2,
        size=size2,
        font=font,
        halign="center",
        valign="center"
    )
    text_3d_2 = linear_extrude(height=height)(text_2d_2).translate([0, 0, 0])
    text_objects.append(text_3d_2)
    
    # Line 3 (bottom) - use size3
    text_2d_3 = text(
        text=line3,
        size=size3,
        font=font,
        halign="center",
        valign="center"
    )
    text_3d_3 = linear_extrude(height=height)(text_2d_3).translate([0, -line_spacing, 0])
    text_objects.append(text_3d_3)
    
    # Combine all lines
    result = text_objects[0]
    for text_obj in text_objects[1:]:
        result += text_obj
    return result

# Create engraved text (cut into base)
engraved_text_3d = create_multiline_text(
    label_text, text_line_2, text_line_3, text_size, text_size_2, text_size_3, text_font, label_thickness + 1
).translate([0, 0, -label_thickness / 2])

# Create raised text (added on top)
raised_text_3d = create_multiline_text(
    label_text, text_line_2, text_line_3, text_size, text_size_2, text_size_3, text_font, label_thickness
).translate([0, 0, label_thickness / 2])

# Combine based on text style using scaling to show/hide parts
# Scale factor: 1 to show, 0 to hide
show_engraved = 1 - text_style  # 1 when text_style=0, 0 when text_style=1
show_raised = text_style        # 0 when text_style=0, 1 when text_style=1

engraved_label = (base - engraved_text_3d).scale([show_engraved, show_engraved, show_engraved])
raised_label = (base + raised_text_3d).scale([show_raised, show_raised, show_raised])

slide_label = engraved_label + raised_label

slide_label.save_as_scad("scadpy/slide_labels/out/slide_labels.scad")