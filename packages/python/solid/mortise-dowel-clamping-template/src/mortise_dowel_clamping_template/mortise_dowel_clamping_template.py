from solid2 import (
    CustomizerDropdownVariable,
    CustomizerSliderVariable,
    CustomizerSpinnerVariable,
    set_global_fn,
)
from solid2.extensions.bosl2 import (
    BACK,
    BOTTOM,
    FRONT,
    LEFT,
    TOP,
    RIGHT,
    cuboid,
    cyl,
    CENTER,
)
from solid2.extensions.bosl2.screws import screw, screw_hole


set_global_fn(50)


segment_count = CustomizerSliderVariable(
    "segment_count",
    2,
    min_="0",
    max_="10",
    label="For example, one segment is one mortise and two dowel holes",
)
dowel_diameter = CustomizerSpinnerVariable(
    "dowel_diameter",
    15.875,
    label="1/2 = 12.7mm, 5/8 = 15.875mm, 3/4 = 19.05mm, 1 = 25.4mm",
)
dowel_spacing = CustomizerSliderVariable(
    "dowel_spacing", 72.39, label="Center-to-center spacing between dowels"
)
adjusting_screw_spec = CustomizerDropdownVariable(
    "screw_specification", "M10", ["M8", "M10", "M12"]
)
inner_width = CustomizerSliderVariable(
    "inner_width", 38.1, label="Greater than the piece width to clamp to"
)
wall_length = CustomizerSliderVariable(
    "wall_length", 20, label="Clamping wall width, adjust to screw size"
)
wall_height = CustomizerSliderVariable(
    "wall_height", 16, label="Clamping wall height, adjust to screw size"
)
wall_thickness = CustomizerSliderVariable(
    "wall_thickness", 4, label="Greater thickness for more wall strength"
)
plate_thickness = CustomizerSliderVariable(
    "plate_thickness",
    4,
    label="Ensure enough thickness for shallow mortise with flush trim router bit, or to prevent flexing when clamping",
)
plate_margin = CustomizerSliderVariable(
    "plate_margin", 3, label="Extra length on each side of the plate"
)

mortise_width = CustomizerSliderVariable(
    "mortise_width",
    35.1,
    label="Accurate width for the mortise (not important if only using dowel holes)",
)
mortise_length = CustomizerSliderVariable(
    "mortise_length",
    42.1,
    label="Accurate length for the mortise (not important if only using dowel holes)",
)
mortise_position = CustomizerDropdownVariable(
    "mortise_position", 0, [0, 1], label="0: Centered, 1: Edge with relief"
)
mortise_relief = CustomizerSliderVariable(
    "mortise_relief",
    0,
    label="Relief for the mortise width if mortise position is 'Edge with relief'",
)
mortise_brim_width = CustomizerSliderVariable(
    "mortise_brim_width",
    0,
    label="Extra brim for router stability when cutting mortise near edge",
)
mortise_brim_thickness = CustomizerSliderVariable(
    "mortise_brim_thickness",
    4,
    label="Enough thickness to support router without flexing or breaking",
)
mortise_rounding = CustomizerSliderVariable(
    "mortise_rounding",
    2.1,
    label="Zero for square corners, half the mortise width for full rounding",
)
mortise_enable_center_sights = CustomizerDropdownVariable(
    "mortise_enable_center_sights",
    1,
    [0, 1],
    label="Small knicks for centering in both directions",
)


mortise_flange_count = CustomizerDropdownVariable(
    "mortise_flange_count",
    0,
    [0, 1, 2],
    label="For hinges with flanges and a deeper center mortise",
)
mortise_flange_length = CustomizerSliderVariable(
    "mortise_flange_length",
    14.5,
    label="Serves as boundary for interior deeper mortise (mortise_length - interior_mortise_length) / 2",
)
mortise_flange_thickness = CustomizerSliderVariable(
    "mortise_flange_thickness", 5.8, label="Matches flange thickness for a flush fit"
)
mortise_flange_screw_diameter = CustomizerDropdownVariable(
    "mortise_flange_screw_diameter",
    "M5",
    ["M2", "M3", "M4", "M5", "M6", "M8", "M10", "M12"],
)
mortise_flange_screw_count = CustomizerSliderVariable(
    "mortise_flange_screw_count",
    2,
    label="Number of screws to secure the flange",
)
mortise_flange_screw_spacing = CustomizerSliderVariable(
    "mortise_flange_screw_spacing",
    11,
    label="Center-to-center spacing between screws",
)
mortise_flange_screw_offset = CustomizerSliderVariable(
    "mortise_flange_screw_offset",
    9,
    label="Offset from the edge of the flange to the first screw",
)


adjust_sides = CustomizerDropdownVariable(
    "adjust_sides",
    2,
    [0, 1, 2],
    label="0: No clamping, 1: Clamp one side (towards mortise edge relief), 2: Clamp both sides (allows for centering mortise)",
)
screw_length = CustomizerSliderVariable(
    "screw_length",
    15,
    label="At least (inner_width - piece_width) / 2 + wall_thickness",
)


node_count = segment_count + 1
cumulative_wall_length = wall_length * node_count
base_plate_width = inner_width + 2 * wall_thickness
base_plate_length = (
    dowel_spacing * segment_count
    + cumulative_wall_length / node_count
    + 2 * plate_margin
)
wall_cavity_length = dowel_spacing - dowel_diameter - 2 * plate_margin
mortise_width_with_relief = mortise_width + mortise_relief


mortise_flange = cuboid(
    [mortise_flange_length, mortise_width, mortise_flange_thickness],
    rounding=mortise_rounding,
    edges=[BACK + RIGHT, FRONT + RIGHT],
    anchor=TOP,
)(
    screw_hole(
        spec=mortise_flange_screw_diameter,
        l=mortise_flange_thickness,
        head="flat",
        counterbore=1,
    )
    .ycopies(spacing=mortise_flange_screw_spacing, n=mortise_flange_screw_count)
    .orient(BOTTOM)
    .position(RIGHT)
    .xmove(-mortise_flange_screw_offset)
).diff()

sight = cyl(
    h=plate_thickness / 2,
    d=1.5 * mortise_enable_center_sights,
    rounding=0.5 * mortise_enable_center_sights,
)

dowel_holes = (
    cyl(h=20, d=dowel_diameter, anchor=TOP, center=True)()
    .xcopies(spacing=dowel_spacing, n=node_count)
    .tag("remove")
)


wall_with_holes = cuboid(
    [wall_length, wall_thickness, wall_height + 1],
    anchor=TOP + FRONT,
    rounding=wall_thickness / 2,
    edges=[BOTTOM, FRONT + RIGHT, BACK + RIGHT, FRONT + LEFT, BACK + LEFT],
)(
    screw_hole(
        spec=adjusting_screw_spec,
        l=wall_thickness,
        thread=True,
        anchor=CENTER,
        orient=FRONT,
    )
).xcopies(
    dowel_spacing, n=node_count
)


wall = cuboid(
    [wall_length, wall_thickness, wall_height + 1],
    anchor=TOP + FRONT,
    rounding=wall_thickness / 2,
    edges=[BOTTOM, FRONT + RIGHT, BACK + RIGHT, FRONT + LEFT, BACK + LEFT],
).xcopies(spacing=dowel_spacing, n=node_count)


thumb_screw = screw(
    spec=adjusting_screw_spec,
    head="socket ribbed",
    length=screw_length,
    anchor=TOP,
)


mortise_plate = cuboid(
    [mortise_length, mortise_width_with_relief, plate_thickness + 0.1],
    rounding=mortise_rounding,
    edges=[FRONT + LEFT, FRONT + RIGHT, BACK + LEFT, BACK + RIGHT],
)(
    sight.position(LEFT + BOTTOM)
    + sight.position(RIGHT + BOTTOM)
    + sight.position(FRONT + BOTTOM)
    + sight.position(BACK + BOTTOM)
)


brim = cuboid(
    [
        base_plate_length,
        mortise_brim_width + wall_thickness / 2,
        mortise_brim_thickness,
    ],
    anchor=TOP + FRONT,
    rounding=wall_thickness / 2,
    edges=[BACK + LEFT, BACK + RIGHT],
).ymove(-wall_thickness / 2)


template = (
    cuboid(
        [base_plate_length, base_plate_width, plate_thickness],
        rounding=wall_thickness / 2,
        edges=[FRONT + LEFT, FRONT + RIGHT, BACK + LEFT, BACK + RIGHT],
    )(
        dowel_holes
        + wall_with_holes.position(FRONT + BOTTOM)
        .up(1)
        .xcopies(spacing=0, n=adjust_sides)
        + wall.up(1).position(FRONT + BOTTOM).xcopies(spacing=0, n=1 - adjust_sides)
        + wall_with_holes.up(1)
        .zrot(180)
        .position(BACK + BOTTOM)
        .xcopies(spacing=0, n=adjust_sides - 1)
        + wall.up(1)
        .zrot(180)
        .position(BACK + BOTTOM)
        .xcopies(spacing=0, n=2 - adjust_sides)
        + mortise_plate.ymove(
            mortise_position
            * ((inner_width - mortise_width_with_relief) / 2 + mortise_relief)
        )
        .xcopies(spacing=dowel_spacing, n=segment_count)
        .tag("remove")
        + brim.position(TOP + BACK)
    ).diff()
    + thumb_screw.grid_copies(
        spacing=30,
        n=[node_count, adjust_sides],
    )
    .ymove(-base_plate_width / 2 - 35)
    .zmove(plate_thickness / 2)
    + mortise_flange.grid_copies(spacing=60, n=[mortise_flange_count, 1])
    .ymove(base_plate_width / 2 + 35)
    .zmove(plate_thickness / 2)
).xrot(180)


template.save_as_scad()
