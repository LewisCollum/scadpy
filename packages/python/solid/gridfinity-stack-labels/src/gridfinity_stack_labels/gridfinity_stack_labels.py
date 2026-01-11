from solid2 import (
    CustomizerSliderVariable,
    CustomizerTextboxVariable,
    CustomizerDropdownVariable,
    linear_extrude,
    text,
    set_global_fn,
    cube,
    square,
    translate,
    union,
    difference,
)
import math

set_global_fn(50)

# Gridfinity constants
gf_pitch = 42
gf_zpitch = 7
gf_corner_radius = 3.75

# Lip constants
lip_lower_taper_height = 0.7
lip_riser_height = 1.8
lip_upper_taper_height = 1.9
lip_height = lip_lower_taper_height + lip_riser_height + lip_upper_taper_height
taper_angle_deg = 45
taper_factor = math.tan(math.radians(taper_angle_deg))
inner_reduction = 8  # Thickness of the lip ring

# Customizable parameters for the gridfinity stack labels
grid_x = CustomizerSliderVariable(
    "grid_x",
    2,
    min_=1,
    max_=10,
    label="Number of grid units in X direction"
)

grid_y = CustomizerSliderVariable(
    "grid_y",
    1,
    min_=1,
    max_=10,
    label="Number of grid units in Y direction"
)

label_text = CustomizerTextboxVariable(
    "label_text",
    "GRIDFINITY LABEL",
    label="Text to display on the label"
)

text_size = CustomizerSliderVariable(
    "text_size",
    20,
    min_=5,
    max_=50,
    label="Size of the text"
)

text_style = CustomizerDropdownVariable(
    "text_style",
    0,
    [0, 1],
    label="0: Engraved text, 1: Raised text"
)

# Create the base plate
width = grid_x * gf_pitch
depth = grid_y * gf_pitch
height = gf_zpitch

# Calculate lip scales
reduction_lower = 2 * lip_lower_taper_height * taper_factor
increase_upper = 2 * lip_upper_taper_height * taper_factor

scale_lower_x = (width - reduction_lower) / width
scale_lower_y = (depth - reduction_lower) / depth

width_upper_bottom = width - reduction_lower
depth_upper_bottom = depth - reduction_lower
width_upper_top = width_upper_bottom + increase_upper
depth_upper_top = depth_upper_bottom + increase_upper

scale_upper_rel_x = width_upper_top / width_upper_bottom
scale_upper_rel_y = depth_upper_top / depth_upper_bottom

# Create the base (hollow frame/rim)
base_outer = cube([width, depth, height]).translate([-width/2, -depth/2, -height/2])
base_inner = cube([width - inner_reduction, depth - inner_reduction, height]).translate([-(width - inner_reduction)/2, -(depth - inner_reduction)/2, -height/2])
base = base_outer - base_inner

# Create the lip ring
ring_outer = square([width, depth], center=True)
ring_inner = square([width - inner_reduction, depth - inner_reduction], center=True)
ring = ring_outer - ring_inner

# Lower taper - starts at the bottom of the base
lower_taper = linear_extrude(height=lip_lower_taper_height, scale=[scale_lower_x, scale_lower_y])(ring).translate([0, 0, -height/2])

# Riser - continues from lower taper
ring_riser = square([width * scale_lower_x, depth * scale_lower_y], center=True) - square([(width - inner_reduction) * scale_lower_x, (depth - inner_reduction) * scale_lower_y], center=True)
riser = linear_extrude(height=lip_riser_height)(ring_riser).translate([0, 0, -height/2 + lip_lower_taper_height])

# Upper taper - continues from riser
upper_taper = linear_extrude(height=lip_upper_taper_height, scale=[scale_upper_rel_x, scale_upper_rel_y])(ring_riser).translate([0, 0, -height/2 + lip_lower_taper_height + lip_riser_height])

# Combine lip
lip = lower_taper + riser + upper_taper

# Combine base and lip
label_base = union()(base, lip)

# Create text - positioned in the hollow area, attached to rim
text_2d = text(
    text=label_text,
    size=text_size,
    halign="center",
    valign="center"
)

# Create text plate that spans the hollow area and connects to the rim
text_plate_thickness = 1.5
text_plate = cube([width - inner_reduction, depth - inner_reduction, text_plate_thickness]).translate([-(width - inner_reduction)/2, -(depth - inner_reduction)/2, -height/2])

# Create engraved text (cut through the plate)
engraved_text_3d = linear_extrude(height=text_plate_thickness + 1)(text_2d).translate([0, 0, -height/2 - 0.5])

# Create raised text (added on top of plate)
raised_text_3d = linear_extrude(height=1.5)(text_2d).translate([0, 0, -height/2 + text_plate_thickness])

# Combine based on text style using scaling to show/hide parts
# Scale factor: 1 to show, 0 to hide
show_engraved = 1 - text_style  # 1 when text_style=0, 0 when text_style=1
show_raised = text_style        # 0 when text_style=0, 1 when text_style=1

engraved_label = (label_base + text_plate - engraved_text_3d).scale([show_engraved, show_engraved, show_engraved])
raised_label = (label_base + text_plate + raised_text_3d).scale([show_raised, show_raised, show_raised])

final_label = engraved_label + raised_label

final_label.save_as_scad("scadpy/gridfinity_stack_labels/out/gridfinity_stack_labels.scad")