// ======================================================
// ROUTER SLED BASE FRAME - EMT CONDUIT VERSION
// Library: BOSL2 (https://github.com/BelfrySCAD/BOSL2)
// Units: Millimeters (mm)
// ======================================================

include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <../emt/src/emt_tube.scad>
use <../emt/src/connectors.scad>

// --- PARAMETERS ---
frame_len = 3048; // 10 feet
frame_wid = 1524; // 5 feet
emt_sz    = "1-1/2"; 
rail_gap  = 60;   // Height to stack rails above base

// Connector Geometry Assumptions (Must match connectors.scad)
// Hub size is approx OD + 8mm. 
// For 1-1/2 EMT (OD 44.2mm) -> Hub ~52.2mm.
// We calculate tube lengths dynamically.

// --- CALCULATIONS ---
// Get OD for spacing
_dims = [ ["1-1/2", 44.2] ]; // Simplified lookup for calculation
// Ideally we call a function, but for now we estimate hub center-to-face offset
// Hub is approx 53mm cube. Center to face is ~26.5mm.
hub_offset = 27; 

// We split the 10ft length into two 5ft sections for the middle support
sect_len_x = (frame_len / 2) - (hub_offset * 2);
sect_len_y = frame_wid - (hub_offset * 2);

// --- MODULES ---

module rail_mount(h=rail_gap) {
    // Simple bracket to hold top rail
    color("teal")
    diff() 
    cuboid([50, 50, h+45], anchor=BOTTOM) {
        // Cutout for Top Rail
        up(h+22.1)
        xcyl(d=44.2+0.5, h=51); // Horizontal Rail Cut
        
        // Bolt holes to connector?
        tag("remove")
        down(h/2)
        cyl(d=9, h=h+50);
    }
}

module main_assembly() {
    
    // --- NODES (Connectors + Feet + Mounts) ---
    // We have a 2x3 Grid of nodes.
    // X Positions: -L/2, 0, +L/2
    // Y Positions: -W/2, +W/2
    
    x_pos = [-frame_len/2, 0, frame_len/2];
    y_pos = [-frame_wid/2, frame_wid/2];
    
    for (i = [0:2]) {
        for (j = [0:1]) {
            xp = x_pos[i];
            yp = y_pos[j];
            
            translate([xp, yp, 0]) {
                // Determine Connector Connectivity
                has_left  = (i > 0);
                has_right = (i < 2);
                has_back  = (j == 0); // Front row connects to Back (+Y)
                has_front = (j == 1); // Back row connects to Front (-Y)

                // 1. The Connector
                emt_connector(
                    size=emt_sz, 
                    
                    // Top / Bottom
                    top_type="none", 
                    bottom_type="screw_hole", bottom_screw="M16",
                    
                    // Sides
                    left_type  = has_left  ? "socket" : "none", left_emt  = emt_sz,
                    right_type = has_right ? "socket" : "none", right_emt = emt_sz,
                    front_type = has_front ? "socket" : "none", front_emt = emt_sz,
                    back_type  = has_back  ? "socket" : "none", back_emt  = emt_sz
                );
                
                // 2. The Foot
                down(26) // Approx bottom of connector
                leveling_foot(thread="M16", l=60, knob_d=60);
                
                // 3. The Rail Mount (Sitting on top)
                up(26) 
                rail_mount(h=rail_gap);
            }
        }
    }
    
    // --- TUBES ---
    
    // 1. Long Axis Tubes (X-Direction)
    // 4 segments total.
    // Y = -W/2:  Left(-L/2 to 0), Right(0 to L/2)
    // Y = +W/2:  Left(-L/2 to 0), Right(0 to L/2)
    
    for (j = [0:1]) {
        yp = y_pos[j];
        // Left Segment
        translate([-frame_len/4, yp, 0])
        rot([0, 90, 0])
        emt_tube(size=emt_sz, l=sect_len_x);
        
        // Right Segment
        translate([frame_len/4, yp, 0])
        rot([0, 90, 0])
        emt_tube(size=emt_sz, l=sect_len_x);
    }
    
    // 2. Cross Axis Tubes (Y-Direction)
    // 3 segments (Left, Middle, Right)
    for (i = [0:2]) {
        xp = x_pos[i];
        translate([xp, 0, 0])
        rot([90, 0, 0])
        emt_tube(size=emt_sz, l=sect_len_y);
    }
    
    // 3. Top Rails (Continuous 10ft)
    // They sit above the mounts
    top_z = 26 + rail_gap + 22.1; // Connector half + gap + mount offset
    
    up(top_z) {
        translate([0, -frame_wid/2, 0])
        rot([0, 90, 0])
        color("silver")
        emt_tube(size=emt_sz, l=frame_len); // Visualizing full length
        
        translate([0, frame_wid/2, 0])
        rot([0, 90, 0])
        color("silver")
        emt_tube(size=emt_sz, l=frame_len);
    }
}

main_assembly();
