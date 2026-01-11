$fn = 50;
//Number of grid units in X direction
grid_x = 2; //[1:10]
//Number of grid units in Y direction
grid_y = 1; //[1:10]
//Text to display on the label
label_text = "GRIDFINITY LABEL";
//Size of the text
text_size = 20; //[5:50]
//0: Engraved text, 1: Raised text
text_style = 0; //[0, 1]

union() {
	scale(v = [(1 - text_style), (1 - text_style), (1 - text_style)]) {
		difference() {
			union() {
				difference() {
					translate(v = [((-(grid_x * 42)) / 2), ((-(grid_y * 42)) / 2), -3.5]) {
						cube(size = [(grid_x * 42), (grid_y * 42), 7]);
					}
					translate(v = [((-((grid_x * 42) - 8)) / 2), ((-((grid_y * 42) - 8)) / 2), -3.5]) {
						cube(size = [((grid_x * 42) - 8), ((grid_y * 42) - 8), 7]);
					}
				}
				union() {
					translate(v = [0, 0, -2.8]) {
						linear_extrude(height = 1.8) {
							difference() {
								square(center = true, size = [((grid_x * 42) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), ((grid_y * 42) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
								square(center = true, size = [(((grid_x * 42) - 8) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), (((grid_y * 42) - 8) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
							}
						}
					}
					translate(v = [0, 0, -0.9999999999999998]) {
						linear_extrude(height = 1.9, scale = [((((grid_x * 42) - 1.3999999999999997) + 3.7999999999999994) / ((grid_x * 42) - 1.3999999999999997)), ((((grid_y * 42) - 1.3999999999999997) + 3.7999999999999994) / ((grid_y * 42) - 1.3999999999999997))]) {
							difference() {
								square(center = true, size = [((grid_x * 42) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), ((grid_y * 42) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
								square(center = true, size = [(((grid_x * 42) - 8) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), (((grid_y * 42) - 8) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
							}
						}
					}
				}
				translate(v = [((-((grid_x * 42) - 8)) / 2), ((-((grid_y * 42) - 8)) / 2), -3.5]) {
					cube(size = [((grid_x * 42) - 8), ((grid_y * 42) - 8), 1.5]);
				}
			}
			translate(v = [0, 0, -4.0]) {
				linear_extrude(height = 2.5) {
					text(halign = "center", size = text_size, text = label_text, valign = "center");
				}
			}
		}
	}
	scale(v = [text_style, text_style, text_style]) {
		union() {
			difference() {
				translate(v = [((-(grid_x * 42)) / 2), ((-(grid_y * 42)) / 2), -3.5]) {
					cube(size = [(grid_x * 42), (grid_y * 42), 7]);
				}
				translate(v = [((-((grid_x * 42) - 8)) / 2), ((-((grid_y * 42) - 8)) / 2), -3.5]) {
					cube(size = [((grid_x * 42) - 8), ((grid_y * 42) - 8), 7]);
				}
			}
			union() {
				translate(v = [0, 0, -2.8]) {
					linear_extrude(height = 1.8) {
						difference() {
							square(center = true, size = [((grid_x * 42) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), ((grid_y * 42) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
							square(center = true, size = [(((grid_x * 42) - 8) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), (((grid_y * 42) - 8) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
						}
					}
				}
				translate(v = [0, 0, -0.9999999999999998]) {
					linear_extrude(height = 1.9, scale = [((((grid_x * 42) - 1.3999999999999997) + 3.7999999999999994) / ((grid_x * 42) - 1.3999999999999997)), ((((grid_y * 42) - 1.3999999999999997) + 3.7999999999999994) / ((grid_y * 42) - 1.3999999999999997))]) {
						difference() {
							square(center = true, size = [((grid_x * 42) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), ((grid_y * 42) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
							square(center = true, size = [(((grid_x * 42) - 8) * (((grid_x * 42) - 1.3999999999999997) / (grid_x * 42))), (((grid_y * 42) - 8) * (((grid_y * 42) - 1.3999999999999997) / (grid_y * 42)))]);
						}
					}
				}
			}
			translate(v = [((-((grid_x * 42) - 8)) / 2), ((-((grid_y * 42) - 8)) / 2), -3.5]) {
				cube(size = [((grid_x * 42) - 8), ((grid_y * 42) - 8), 1.5]);
			}
			translate(v = [0, 0, -2.0]) {
				linear_extrude(height = 1.5) {
					text(halign = "center", size = text_size, text = label_text, valign = "center");
				}
			}
		}
	}
}
