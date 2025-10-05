include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/version.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/constants.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/transforms.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/distributors.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/mutators.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/color.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/attachments.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/shapes3d.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/shapes2d.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/drawing.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/masks3d.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/masks2d.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/math.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/paths.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/lists.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/comparisons.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/linalg.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/trigonometry.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/vectors.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/affine.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/coords.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/geometry.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/regions.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/strings.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/skin.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/vnf.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/utility.scad>;
include </home/charon/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/partitions.scad>;

$fn = 50;
//Width of the label in mm
label_width = 50; //[10:200]
//Height of the label in mm
label_height = 20; //[5:100]
//Thickness of the label in mm
label_thickness = 2; //[0.5:10]
//Text to display on the label
label_text = "LABEL";
//Size of the text
text_size = 8; //[1:50]
//Font for the text
text_font = "Arial"; //[Arial, Arial Black, Times, Times New Roman, Courier, Courier New, Helvetica, DejaVu Sans, Liberation Sans, Ubuntu, FreeSans]
//0: Engraved text, 1: Raised text
text_style = 0; //[0, 1]

union() {
	scale(v = [(1 - text_style), (1 - text_style), (1 - text_style)]) {
		difference() {
			cuboid(anchor = CENTER, size = [label_width, label_height, label_thickness]);
			translate(v = [0, 0, ((-label_thickness) / 2)]) {
				linear_extrude(height = (label_thickness + 1)) {
					text(font = text_font, halign = "center", size = text_size, text = label_text, valign = "center");
				}
			}
		}
	}
	scale(v = [text_style, text_style, text_style]) {
		union() {
			cuboid(anchor = CENTER, size = [label_width, label_height, label_thickness]);
			translate(v = [0, 0, (label_thickness / 2)]) {
				linear_extrude(height = label_thickness) {
					text(font = text_font, halign = "center", size = text_size, text = label_text, valign = "center");
				}
			}
		}
	}
}
