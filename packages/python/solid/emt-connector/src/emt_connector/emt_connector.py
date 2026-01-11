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
    corner_mask,
    cuboid,
    cyl,
    CENTER,
    rounding_hole_mask,
    teardrop_corner_mask,
    tube,
)
from solid2.extensions.bosl2.std import BOT

set_global_fn(50)


diameter = CustomizerSpinnerVariable(
    "diameter",
    18.30,
    label="EMT: 1/2 = 18.3mm",
)

wall_thickness = CustomizerSliderVariable(
    "wall_thickness",
    4,
)

offset = CustomizerSliderVariable(
    "offset", 20, label="Extra dimension added to pipe length to measure inside edge"
)

tape_width = CustomizerSliderVariable("tape_size", 25, label="The width of tape")

sleeve_length = CustomizerSliderVariable(
    "sleeve_length", 45, label="The cover over the pipe"
)

sleeve_with_offset_length = sleeve_length + tape_width + offset
outer_diameter = diameter + 2 * wall_thickness
pipe_hole = cyl(h=sleeve_length, d=diameter, anchor=TOP).tag("remove")

sleeve_casing = cuboid([outer_diameter, outer_diameter, sleeve_with_offset_length])

corner = cuboid([outer_diameter, outer_diameter, outer_diameter])
sleeve = sleeve_casing(
    pipe_hole.position(TOP)(rounding_hole_mask(r=diameter / 2, rounding=2))(
        cyl(h=outer_diameter, d=2, orient=FRONT)
        .zmove(-sleeve_length)
        .zcopies([0, -tape_width])
        .position([LEFT, RIGHT])
        + cyl(h=outer_diameter, d=1.2, orient=LEFT)
        .zmove(-sleeve_length)
        .zcopies([0, -tape_width])
        .position([BACK])
    ).tag("remove")
).diff()

assembly = corner(sleeve.attach([TOP, BACK], BOTTOM))
assembly.save_as_scad("out/emt_connector.scad")
