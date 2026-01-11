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

// Label dimensions
label_width = 50;
label_height = 30;
label_thickness = 2;

// Text content
label_text = "CAUTION";
text_line_2 = "High Voltage";
text_line_3 = "Do Not Touch";

// Text sizing
text_size = 8;
text_size_2 = 6;
text_size_3 = 5;

// Text appearance
text_font = "Arial Black";
text_style = 1;

// Calculate dynamic line spacing
line_spacing = ((text_size + text_size_2 + text_size_3) / 3) * 1.3;

// Create the label
union() {
    // Engraved version (scaled by (1-text_style))
    scale(v = [(1 - text_style), (1 - text_style), (1 - text_style)]) {
        difference() {
            cuboid(anchor = CENTER, size = [label_width, label_height, label_thickness]);
            translate(v = [0, 0, -label_thickness/2]) {
                union() {
                    translate(v = [0, line_spacing, 0]) {
                        linear_extrude(height = label_thickness + 1) {
                            text(font = text_font, halign = "center", size = text_size, text = label_text, valign = "center");
                        }
                    }
                    translate(v = [0, 0, 0]) {
                        linear_extrude(height = label_thickness + 1) {
                            text(font = text_font, halign = "center", size = text_size_2, text = text_line_2, valign = "center");
                        }
                    }
                    translate(v = [0, -line_spacing, 0]) {
                        linear_extrude(height = label_thickness + 1) {
                            text(font = text_font, halign = "center", size = text_size_3, text = text_line_3, valign = "center");
                        }
                    }
                }
            }
        }
    }
    // Raised version (scaled by text_style)
    scale(v = [text_style, text_style, text_style]) {
        union() {
            cuboid(anchor = CENTER, size = [label_width, label_height, label_thickness]);
            translate(v = [0, 0, label_thickness/2]) {
                union() {
                    translate(v = [0, line_spacing, 0]) {
                        linear_extrude(height = label_thickness) {
                            text(font = text_font, halign = "center", size = text_size, text = label_text, valign = "center");
                        }
                    }
                    translate(v = [0, 0, 0]) {
                        linear_extrude(height = label_thickness) {
                            text(font = text_font, halign = "center", size = text_size_2, text = text_line_2, valign = "center");
                        }
                    }
                    translate(v = [0, -line_spacing, 0]) {
                        linear_extrude(height = label_thickness) {
                            text(font = text_font, halign = "center", size = text_size_3, text = text_line_3, valign = "center");
                        }
                    }
                }
            }
        }
    }
}