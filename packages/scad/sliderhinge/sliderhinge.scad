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

union() {
	diff() {
		knuckle_hinge(anchor = CENTER, arm_angle = 90, arm_height = 0, clear_top = true, fill = false, gap = 0.24, inner = false, knuckle_clearance = 0.24, knuckle_diam = 6.662740147901951, length = 65, offset = 3.3313700739509753, pin_diam = 2.8513700739509753, segs = 13) {
			down(z = 3.3313700739509753) {
				tag(tag = "keep") {
					attach(from = TOP, to = LEFT) {
						orient(anchor = LEFT) {
							cyl(d = 2.8513700739509753, h = 65);
						}
					}
				}
			}
			position(from = (FRONT + BOTTOM)) {
				cuboid(anchor = (BACK + BOTTOM), size = [65, 25, 3.0913700739509755]) {
					position(from = (TOP + CENTER)) {
						union() {
							move(v = [-24.5, -4.5]) {
								screw_hole(anchor = TOP, counterbore = 1.4, head = "flat", spec = "#8-15,1.25");
							}
							move(v = [0.0, 4.5]) {
								screw_hole(anchor = TOP, counterbore = 1.4, head = "flat", spec = "#8-15,1.25");
							}
							move(v = [24.5, -4.5]) {
								screw_hole(anchor = TOP, counterbore = 1.4, head = "flat", spec = "#8-15,1.25");
							}
						}
					}
				}
			}
		}
	}
	rotate(a = [11, 0, 0]) {
		rotate(a = [0, 0, 180]) {
			diff() {
				knuckle_hinge(anchor = CENTER, arm_angle = 90, arm_height = 0, clear_top = true, fill = false, gap = 0.24, inner = true, knuckle_clearance = 0.24, knuckle_diam = 6.662740147901951, length = 65, offset = 3.3313700739509753, pin_diam = 3.3313700739509753, segs = 13) {
					position(from = (CENTER + BOTTOM)) {
						prismoid(anchor = (TOP + RIGHT), h = 12.7, orient = BACK, size1 = [11.6, 65], spin = 90, xang = 79, yang = 90) {
							tag(tag = "remove") {
								position(from = TOP) {
									orient(anchor = FRONT) {
										cyl(anchor = CENTER, d = 3.3313700739509753, h = 65);
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
