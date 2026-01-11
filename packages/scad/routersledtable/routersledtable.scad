// ======================================================
// ROUTER SLED BASE FRAME (10' x 5') - NO WELD VERSION
// Designed for Bolted Construction & EMT Rails
// Units: Inches
// ======================================================

// --- PARAMETERS ---
frame_length = 120;  // 10 feet
frame_width = 60;    // 5 feet

// CHANGED: 1.5" Steel is cheaper and sufficient
tube_size = 1.5;     
wall_thk = 0.083;    // 14 Gauge (~0.083")

bay_spacing = 24;    // Spacing for slab support ribs

// CHANGED: 1-1/2" EMT Conduit Specs
rail_diam = 1.74;    // Actual OD of 1.5" EMT
rail_offset = 1.5;   // Height of rail standoffs

// Colors
color_frame = [0.3, 0.3, 0.35]; // Dark Grey (Steel)
color_brace = [0.8, 0.3, 0.3];  // Red (Bracing)
color_rail  = [0.9, 0.9, 0.9];  // Silver (EMT Zinc Coating)
color_plate = [0.6, 0.6, 0.2];  // Gold/Yellow Zinc (Gusset Plates)
color_slab  = [0.55, 0.27, 0.07, 0.3]; // Wood Slab (Ghosted)

// --- MODULES ---

module square_tube(L, size, thk) {
    difference() {
        cube([L, size, size], center=true);
        cube([L+1, size-(thk*2), size-(thk*2)], center=true);
    }
}

module round_rail(L, D) {
    rotate([0, 90, 0])
    cylinder(h=L, d=D, center=true);
}

// NEW: Gusset Plates for Bolted Assembly
module corner_gusset() {
    color(color_plate)
    translate([0, 0, (tube_size/2) + 0.1])
    linear_extrude(0.125)
    polygon(points=[[0,0], [6,0], [0,6]]); // 6x6 triangle plate
}

module t_gusset() {
    color(color_plate)
    translate([0, 0, (tube_size/2) + 0.1])
    cube([4, 8, 0.125], center=true); // 4x8 rectangular plate
}

// The structural base
module frame_assembly() {
    usable_length = frame_length - (tube_size*2);
    
    // 1. Perimeter
    color(color_frame) {
        // Long Rails
        translate([0, (frame_width-tube_size)/2, 0])
            square_tube(frame_length, tube_size, wall_thk);
        translate([0, -(frame_width-tube_size)/2, 0])
            square_tube(frame_length, tube_size, wall_thk);
            
        // End Caps
        translate([(frame_length-tube_size)/2, 0, 0])
            rotate([0,0,90])
            square_tube(frame_width - (tube_size*2), tube_size, wall_thk);
        translate([-(frame_length-tube_size)/2, 0, 0])
            rotate([0,0,90])
            square_tube(frame_width - (tube_size*2), tube_size, wall_thk);
    }
    
    // 1b. Corner Gussets (Visualizing Bolted Joints)
    // 4 Corners
    for (x = [-1, 1]) for (y = [-1, 1]) {
        translate([x*((frame_length-tube_size)/2), y*((frame_width-tube_size)/2), 0])
            rotate([0, 0, (x*y > 0 ? 0 : 90) + (x < 0 ? 180 : 0)])
            corner_gusset();
    }
    
    // 2. Cross Ribs
    num_ribs = floor(usable_length / bay_spacing);
    color(color_frame)
    for (i = [1 : num_ribs]) {
        offset_x = -(usable_length/2) + (i * (usable_length / (num_ribs + 1)));
        translate([offset_x, 0, 0])
            rotate([0,0,90])
            square_tube(frame_width - (tube_size*2), tube_size, wall_thk);
            
        // Add T-Gussets at rib junctions
        translate([offset_x, (frame_width-tube_size)/2, 0]) t_gusset();
        translate([offset_x, -(frame_width-tube_size)/2, 0]) t_gusset();
    }

    // 3. X-Bracing
    // Note: For bolted assembly, use flat bar straps or bolted tube ends
    num_bays = floor(usable_length / bay_spacing) + 1;
    step = usable_length / num_bays;
    inner_width = frame_width - (tube_size*2);
    diag_len = sqrt(pow(step, 2) + pow(inner_width, 2));
    diag_angle = atan(inner_width / step);

    color(color_brace)
    for (i = [0 : num_bays-1]) {
        center_x = -(usable_length/2) + (step/2) + (i * step);
        translate([center_x, 0, 0]) {
            rotate([0, 0, diag_angle])
                square_tube(diag_len - tube_size, tube_size*0.75, wall_thk);
            rotate([0, 0, -diag_angle])
                square_tube(diag_len - tube_size, tube_size*0.75, wall_thk);
        }
    }
}

// The linear guide rails mounted on top
module guide_rails() {
    color(color_rail) {
        z_pos = (tube_size/2) + (rail_diam/2) + 0.5;
        
        // Rail 1
        translate([0, (frame_width-tube_size)/2, z_pos])
            round_rail(frame_length, rail_diam);
            
        // Rail 2
        translate([0, -(frame_width-tube_size)/2, z_pos])
            round_rail(frame_length, rail_diam);
    }
}

module leveling_feet() {
    color("Black")
    for (x = [-1, 1]) for (y = [-1, 1]) {
        translate([x*(frame_length/2 - 2), y*(frame_width/2 - 2), -tube_size])
            cylinder(h=tube_size, d=1); 
        translate([x*(frame_length/2 - 2), y*(frame_width/2 - 2), -tube_size-0.5])
            cylinder(h=0.5, d=3);
    }
}

// --- ASSEMBLY ---

translate([0,0, tube_size]) {
    frame_assembly();
    guide_rails();
}
leveling_feet();

// Wood slab
color(color_slab)
    translate([0, 0, tube_size + (tube_size/2) + 1])
    cube([96, 36, 2], center=true);

// --- LABELS ---
color("Black") {
    translate([-frame_length/2, frame_width/2 + 8, 0])
        text("1-1/2\" EMT Rails (1.74\" OD)", size=3);
    translate([0, -frame_width/2 - 10, 0])
        text("Bolted Steel Frame (No Weld)", size=3, halign="center");
}

$fn=30;