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
include </home/charon/.cache/pypoetry/virtualenvs/scadpy-8xxGUhqN-py3.13/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/screws.scad>;

$fn = 50;
//For example, one segment is one mortise and two dowel holes
segment_count = 2; //[0:10]
//1/2 = 12.7mm, 5/8 = 15.875mm, 3/4 = 19.05mm, 1 = 25.4mm
dowel_diameter = 15.875;
//Center-to-center spacing between dowels
dowel_spacing = 72.39; //[]
screw_specification = "M10"; //[M8, M10, M12]
//Greater than the piece width to clamp to
inner_width = 38.1; //[]
//Clamping wall width, adjust to screw size
wall_length = 20; //[]
//Clamping wall height, adjust to screw size
wall_height = 16; //[]
//Greater thickness for more wall strength
wall_thickness = 4; //[]
//Ensure enough thickness for shallow mortise with flush trim router bit, or to prevent flexing when clamping
plate_thickness = 4; //[]
//Extra length on each side of the plate
plate_margin = 3; //[]
//Accurate width for the mortise (not important if only using dowel holes)
mortise_width = 35.1; //[]
//Accurate length for the mortise (not important if only using dowel holes)
mortise_length = 42.1; //[]
//0: Centered, 1: Edge with relief
mortise_position = 0; //[0, 1]
//Relief for the mortise width if mortise position is 'Edge with relief'
mortise_relief = 0; //[]
//Extra brim for router stability when cutting mortise near edge
mortise_brim_width = 0; //[]
//Enough thickness to support router without flexing or breaking
mortise_brim_thickness = 4; //[]
//Zero for square corners, half the mortise width for full rounding
mortise_rounding = 2.1; //[]
//Small knicks for centering in both directions
mortise_enable_center_sights = 1; //[0, 1]
//For hinges with flanges and a deeper center mortise
mortise_flange_count = 0; //[0, 1, 2]
//Serves as boundary for interior deeper mortise (mortise_length - interior_mortise_length) / 2
mortise_flange_length = 14.5; //[]
//Matches flange thickness for a flush fit
mortise_flange_thickness = 5.8; //[]
mortise_flange_screw_diameter = "M5"; //[M2, M3, M4, M5, M6, M8, M10, M12]
//Number of screws to secure the flange
mortise_flange_screw_count = 2; //[]
//Center-to-center spacing between screws
mortise_flange_screw_spacing = 11; //[]
//Offset from the edge of the flange to the first screw
mortise_flange_screw_offset = 9; //[]
//0: No clamping, 1: Clamp one side (towards mortise edge relief), 2: Clamp both sides (allows for centering mortise)
adjust_sides = 2; //[0, 1, 2]
//At least (inner_width - piece_width) / 2 + wall_thickness
screw_length = 15; //[]

xrot(a = 180) {
	union() {
		diff() {
			cuboid(edges = [(FRONT + LEFT), (FRONT + RIGHT), (BACK + LEFT), (BACK + RIGHT)], rounding = (wall_thickness / 2), size = [(((dowel_spacing * segment_count) + ((wall_length * (segment_count + 1)) / (segment_count + 1))) + (2 * plate_margin)), (inner_width + (2 * wall_thickness)), plate_thickness]) {
				union() {
					tag(tag = "remove") {
						xcopies(n = (segment_count + 1), spacing = dowel_spacing) {
							cyl(anchor = TOP, center = true, d = dowel_diameter, h = 20);
						}
					}
					xcopies(n = adjust_sides, spacing = 0) {
						up(z = 1) {
							position(from = (FRONT + BOTTOM)) {
								xcopies(n = (segment_count + 1), spacing = dowel_spacing) {
									cuboid(anchor = (TOP + FRONT), edges = [BOTTOM, (FRONT + RIGHT), (BACK + RIGHT), (FRONT + LEFT), (BACK + LEFT)], rounding = (wall_thickness / 2), size = [wall_length, wall_thickness, (wall_height + 1)]) {
										screw_hole(anchor = CENTER, l = wall_thickness, orient = FRONT, spec = screw_specification, thread = true);
									}
								}
							}
						}
					}
					xcopies(n = (1 - adjust_sides), spacing = 0) {
						position(from = (FRONT + BOTTOM)) {
							up(z = 1) {
								xcopies(n = (segment_count + 1), spacing = dowel_spacing) {
									cuboid(anchor = (TOP + FRONT), edges = [BOTTOM, (FRONT + RIGHT), (BACK + RIGHT), (FRONT + LEFT), (BACK + LEFT)], rounding = (wall_thickness / 2), size = [wall_length, wall_thickness, (wall_height + 1)]);
								}
							}
						}
					}
					xcopies(n = (adjust_sides - 1), spacing = 0) {
						position(from = (BACK + BOTTOM)) {
							zrot(a = 180) {
								up(z = 1) {
									xcopies(n = (segment_count + 1), spacing = dowel_spacing) {
										cuboid(anchor = (TOP + FRONT), edges = [BOTTOM, (FRONT + RIGHT), (BACK + RIGHT), (FRONT + LEFT), (BACK + LEFT)], rounding = (wall_thickness / 2), size = [wall_length, wall_thickness, (wall_height + 1)]) {
											screw_hole(anchor = CENTER, l = wall_thickness, orient = FRONT, spec = screw_specification, thread = true);
										}
									}
								}
							}
						}
					}
					xcopies(n = (2 - adjust_sides), spacing = 0) {
						position(from = (BACK + BOTTOM)) {
							zrot(a = 180) {
								up(z = 1) {
									xcopies(n = (segment_count + 1), spacing = dowel_spacing) {
										cuboid(anchor = (TOP + FRONT), edges = [BOTTOM, (FRONT + RIGHT), (BACK + RIGHT), (FRONT + LEFT), (BACK + LEFT)], rounding = (wall_thickness / 2), size = [wall_length, wall_thickness, (wall_height + 1)]);
									}
								}
							}
						}
					}
					tag(tag = "remove") {
						xcopies(n = segment_count, spacing = dowel_spacing) {
							ymove(y = (mortise_position * (((inner_width - (mortise_width + mortise_relief)) / 2) + mortise_relief))) {
								cuboid(edges = [(FRONT + LEFT), (FRONT + RIGHT), (BACK + LEFT), (BACK + RIGHT)], rounding = mortise_rounding, size = [mortise_length, (mortise_width + mortise_relief), (plate_thickness + 0.1)]) {
									union() {
										position(from = (LEFT + BOTTOM)) {
											cyl(d = (1.5 * mortise_enable_center_sights), h = (plate_thickness / 2), rounding = (0.5 * mortise_enable_center_sights));
										}
										position(from = (RIGHT + BOTTOM)) {
											cyl(d = (1.5 * mortise_enable_center_sights), h = (plate_thickness / 2), rounding = (0.5 * mortise_enable_center_sights));
										}
										position(from = (FRONT + BOTTOM)) {
											cyl(d = (1.5 * mortise_enable_center_sights), h = (plate_thickness / 2), rounding = (0.5 * mortise_enable_center_sights));
										}
										position(from = (BACK + BOTTOM)) {
											cyl(d = (1.5 * mortise_enable_center_sights), h = (plate_thickness / 2), rounding = (0.5 * mortise_enable_center_sights));
										}
									}
								}
							}
						}
					}
					position(from = (TOP + BACK)) {
						ymove(y = ((-wall_thickness) / 2)) {
							cuboid(anchor = (TOP + FRONT), edges = [(BACK + LEFT), (BACK + RIGHT)], rounding = (wall_thickness / 2), size = [(((dowel_spacing * segment_count) + ((wall_length * (segment_count + 1)) / (segment_count + 1))) + (2 * plate_margin)), (mortise_brim_width + (wall_thickness / 2)), mortise_brim_thickness]);
						}
					}
				}
			}
		}
		zmove(z = (plate_thickness / 2)) {
			ymove(y = (((-(inner_width + (2 * wall_thickness))) / 2) - 35)) {
				grid_copies(n = [(segment_count + 1), adjust_sides], spacing = 30) {
					screw(anchor = TOP, head = "socket ribbed", length = screw_length, spec = screw_specification);
				}
			}
		}
		zmove(z = (plate_thickness / 2)) {
			ymove(y = (((inner_width + (2 * wall_thickness)) / 2) + 35)) {
				grid_copies(n = [mortise_flange_count, 1], spacing = 60) {
					diff() {
						cuboid(anchor = TOP, edges = [(BACK + RIGHT), (FRONT + RIGHT)], rounding = mortise_rounding, size = [mortise_flange_length, mortise_width, mortise_flange_thickness]) {
							xmove(x = (-mortise_flange_screw_offset)) {
								position(from = RIGHT) {
									orient(anchor = BOTTOM) {
										ycopies(n = mortise_flange_screw_count, spacing = mortise_flange_screw_spacing) {
											screw_hole(counterbore = 1, head = "flat", l = mortise_flange_thickness, spec = mortise_flange_screw_diameter);
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
}
