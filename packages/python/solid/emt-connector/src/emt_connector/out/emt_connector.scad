include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/version.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/constants.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/transforms.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/distributors.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/mutators.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/color.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/attachments.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/shapes3d.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/shapes2d.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/drawing.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/masks3d.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/masks2d.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/math.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/paths.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/lists.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/comparisons.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/linalg.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/trigonometry.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/vectors.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/affine.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/coords.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/geometry.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/regions.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/strings.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/skin.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/vnf.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/utility.scad>;
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/partitions.scad>;

$fn = 50;
//EMT: 1/2 = 18.3mm
diameter = 18.3;
wall_thickness = 4; //[]
//Extra dimension added to pipe length to measure inside edge
offset = 20; //[]
//The width of tape
tape_size = 25; //[]
//The cover over the pipe
sleeve_length = 45; //[]

cuboid(size = [(diameter + (2 * wall_thickness)), (diameter + (2 * wall_thickness)), (diameter + (2 * wall_thickness))]) {
	attach(from = [TOP, BACK], to = BOTTOM) {
		diff() {
			cuboid(size = [(diameter + (2 * wall_thickness)), (diameter + (2 * wall_thickness)), ((sleeve_length + tape_size) + offset)]) {
				tag(tag = "remove") {
					position(from = TOP) {
						tag(tag = "remove") {
							cyl(anchor = TOP, d = diameter, h = sleeve_length);
						}
						rounding_hole_mask(r = (diameter / 2), rounding = 2);
						union() {
							position(from = [LEFT, RIGHT]) {
								zcopies(spacing = [0, (-tape_size)]) {
									zmove(z = (-sleeve_length)) {
										cyl(d = 2, h = (diameter + (2 * wall_thickness)), orient = FRONT);
									}
								}
							}
							position(from = [BACK]) {
								zcopies(spacing = [0, (-tape_size)]) {
									zmove(z = (-sleeve_length)) {
										cyl(d = 1.2, h = (diameter + (2 * wall_thickness)), orient = LEFT);
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
