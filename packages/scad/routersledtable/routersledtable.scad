// ======================================================
// ROUTER SLED BASE FRAME (10' x 5') - WIDTH COLLAPSIBLE
// Designed for Quick Setup/Teardown
// Units: Inches
// ======================================================

// --- PARAMETERS ---
frame_length = 120;  // 10 feet (Continuous)
frame_width = 60;    // 5 feet (Collapsible)

// 1.5" Steel Tubing (14 Gauge)
tube_size = 1.5;     
wall_thk = 0.083;    

bay_spacing = 30;    // Spacing for removable spreaders

// 1-1/2" EMT Conduit Specs (1.74" OD)
rail_diam = 1.74;    
rail_offset = 1.5;   

// Colors
color_frame = [0.3, 0.3, 0.35]; 
color_spreader = [0.4, 0.4, 0.45]; // Slightly lighter for contrast
color_cable = [0.9, 0.6, 0.2];  
color_rail  = [0.9, 0.9, 0.9];  
color_slab  = [0.55, 0.27, 0.07, 0.3]; 

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

// Visualization of the mounting tab welded/bolted to the main rail
module mounting_tab() {
    color("Gold")
    difference() {
        cube([2, 2, 0.125], center=true);
        cylinder(h=1, d=0.3, center=true); // Bolt hole
    }
}

// Cable with Turnbuckle
module cable_assembly(len, angle) {
    rotate([0, 0, angle]) {
        // The Cable
        color(color_cable)
        rotate([0, 90, 0])
        cylinder(h=len, d=0.15, center=true); 
        
        // The Turnbuckle (Visual)
        color("Silver")
        rotate([0, 90, 0])
        cylinder(h=8, d=0.75, center=true);
    }
}

module frame_assembly() {
    usable_length = frame_length - (tube_size*2);
    
    // 1. CONTINUOUS LONG RAILS
    color(color_frame) {
        // Top Rail
        translate([0, (frame_width-tube_size)/2, 0])
            square_tube(frame_length, tube_size, wall_thk);

        // Bottom Rail
        translate([0, -(frame_width-tube_size)/2, 0])
            square_tube(frame_length, tube_size, wall_thk);
    }
    
    // 2. REMOVABLE SPREADER BARS (Cross Members)
    // These bolt between the long rails
    num_ribs = floor(usable_length / bay_spacing);
    
    for (i = [0 : num_ribs+1]) {
        // Distribute ribs including ends
        offset_x = -(usable_length/2) + (i * (usable_length / (num_ribs + 1)));
        
        // The Spreader Bar
        color(color_spreader)
        translate([offset_x, 0, 0])
            rotate([0,0,90])
            square_tube(frame_width - (tube_size*2) - 0.2, tube_size, wall_thk); // Slightly shorter for clearance
            
        // Visualization of Mounting Tabs on the main rails
        translate([offset_x, (frame_width-tube_size)/2 - tube_size/2 - 0.1, 0])
            rotate([90,0,0]) mounting_tab();
        translate([offset_x, -(frame_width-tube_size)/2 + tube_size/2 + 0.1, 0])
            rotate([90,0,0]) mounting_tab();
    }

    // 3. CABLE BRACING (Quick Release)
    // Spans the entire length for maximum anti-twist
    
    inner_L = usable_length;
    inner_W = frame_width - (tube_size*2);
    diag_L = sqrt(pow(inner_L, 2) + pow(inner_W, 2));
    diag_A = atan(inner_W / inner_L);

    translate([0, 0, 0]) {
        cable_assembly(diag_L, diag_A);
        cable_assembly(diag_L, -diag_A);
    }
}

// The linear guide rails (Continuous)
module guide_rails() {
    color(color_rail) {
        z_pos = (tube_size/2) + (rail_diam/2) + 0.5;
        
        translate([0, (frame_width-tube_size)/2, z_pos])
            round_rail(frame_length, rail_diam);

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
        text("Continuous 10' Rails", size=3);
    translate([0, -frame_width/2 - 10, 0])
        text("Removable Spreaders & Cables", size=3, halign="center");
    
    // Label for mounting tabs
    translate([-frame_length/2 + 12, -(frame_width/2) + 6, 5])
        text("Bolted Tabs", size=2);
}

$fn=30;