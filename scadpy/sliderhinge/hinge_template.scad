include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/version.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/constants.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/transforms.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/distributors.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/mutators.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/color.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/attachments.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/shapes3d.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/shapes2d.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/drawing.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/masks3d.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/masks2d.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/math.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/paths.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/lists.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/comparisons.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/linalg.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/trigonometry.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/vectors.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/affine.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/coords.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/geometry.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/regions.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/strings.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/skin.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/vnf.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/utility.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/partitions.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/hinges.scad>;
include </home/charon/print/scadpy/.venv/lib/python3.12/site-packages/solid2/extensions/bosl2/BOSL2/screws.scad>;

$fn = 50;

diff() {
	cuboid(anchor = (BACK + BOTTOM), size = [65, 25, 3.0913700739509755]) {
		position(from = (TOP + CENTER)) {
			union() {
				move(v = [-24.5, -4.5]) {
					tag(tag = "remove") {
						cyl(anchor = TOP, center = true, d = 2.9, h = 10);
					}
				}
				move(v = [0.0, 4.5]) {
					tag(tag = "remove") {
						cyl(anchor = TOP, center = true, d = 2.9, h = 10);
					}
				}
				move(v = [24.5, -4.5]) {
					tag(tag = "remove") {
						cyl(anchor = TOP, center = true, d = 2.9, h = 10);
					}
				}
			}
		}
	}
}
