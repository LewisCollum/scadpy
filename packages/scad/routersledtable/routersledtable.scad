// ======================================================
// ROUTER SLED BASE FRAME - DETAILED BUILD PLAN
// Library: BOSL2 (https://github.com/BelfrySCAD/BOSL2)
// Units: Millimeters (mm)
// ======================================================

include <BOSL2/std.scad>
include <BOSL2/screws.scad>

// --- BILL OF MATERIALS (BOM) ---
// 1. STEEL:  3x  10ft (3048mm) lengths of 1.5" (38mm) Steel Square Tube.
// 2. RAILS:  2x  10ft (3048mm) lengths of 1-1/2" EMT Conduit.
// 3. JOINTS: 16x 3" (76mm) Flat "L" Corner Braces (Zinc Plated).
// 4. BOLTS:  32x 5/16"-18 x 2.5" (63mm) Hex Bolts.
// 5. NUTS:   32x 5/16"-18 Nyloc Nuts + Washers.
// 6. CABLE:  1x  Turnbuckle/Cable Kit.

// --- PARAMETERS (All in mm) ---
frame_len = 3048; // 10 feet
frame_wid = 1524; // 5 feet
tube_sz   = 38.1; // 1.5 inches
wall_thk  = 3.2;  // ~1/8 inch

// EMT Rail (1-1/2" Trade Size)
rail_od   = 44.2; // 1.74 inches

// Hardware Dims
brace_arm = 76.2; // 3 inch leg length
brace_wid = 19.0; // 3/4 inch width
brace_thk = 3.0;  // 1/8 inch thickness

bolt_spec = "5/16-18"; 
bolt_len  = 63.5; // 2.5 inches

// Colors
c_steel  = [0.3, 0.3, 0.35];
c_emt    = [0.9, 0.9, 0.95];
c_gold   = [0.8, 0.7, 0.2]; // Zinc Plate
c_cable  = [1, 0.5, 0];

// --- MODULES ---

module steel_tube_15(L) {
    color(c_steel) 
    diff()
    cuboid([L, tube_sz, tube_sz], rounding=2, edges="X") {
        tag("remove") 
            cuboid([L+1, tube_sz-(wall_thk*2), tube_sz-(wall_thk*2)]);
    }
}

module emt_rail_10ft() {
    color(c_emt)
    // FIXED: Use xcyl to align with the 10ft frame length
    xcyl(h=frame_len, d=rail_od, $fn=64); 
}

// Flat L-Plate (Mending Plate)
module flat_corner_brace() {
    color(c_gold)
    diff()
    union() {
        // Leg 1 (Along X)
        cuboid([brace_arm, brace_wid, brace_thk], anchor=LEFT, rounding=1, edges="Z") {
            // Bolt Hole 1
            tag("remove") right(brace_arm/2) zcyl(h=10, d=9);
        }
        // Leg 2 (Along Y)
        cuboid([brace_wid, brace_arm, brace_thk], anchor=FRONT, rounding=1, edges="Z") {
             // Bolt Hole 2
            tag("remove") back(brace_arm/2) zcyl(h=10, d=9);
        }
    }
}

// A complete bolt assembly (Screw + Washer + Nut)
module bolt_assembly_vertical() {
    // The Screw (Vertical Down)
    color("silver")
    screw(bolt_spec, l=bolt_len, head="hex", orient=ORIENT_Z, anchor=TOP);
    
    // The Nut & Washer (Attached at bottom)
    color("silver")
    down(bolt_len) 
    nut(bolt_spec, flavor="nyloc", anchor=BOTTOM)
        attach(BOTTOM, TOP) washer(bolt_spec);
}

module eye_bolt_assembly() {
    color("silver")
    union() {
        xrot(90) 
        diff() 
        cyl(h=8, d=25) {
            tag("remove") cyl(h=9, d=15);
        }
        yrot(90) cyl(h=76, d=8); 
        right(25) yrot(90) nut(bolt_spec, anchor=CENTER);
    }
}

module turnbuckle_sim(len=200) {
    color("silver")
    union() {
        cuboid([len-50, 20, 8], rounding=4, edges="Z");
        left((len/2)-12) xrot(90) torus(d_maj=15, d_min=4);
        right((len/2)-12) xrot(90) torus(d_maj=15, d_min=4);
    }
}

module emt_strap() {
    color("silver")
    diff()
    cuboid([25, rail_od+12, rail_od/2], anchor=BOTTOM) {
        tag("remove") up(2) cuboid([26, rail_od, rail_od]);
    }
    color("silver")
    back(rail_od/2) cuboid([25, 12, 2], anchor=FRONT+BOTTOM);
}

// --- MAIN ASSEMBLY ---

// 1. Long Rails (Using standard positions)
// Left Rail
translate([0, frame_wid/2 - tube_sz/2, 0]) 
    steel_tube_15(frame_len);

// Right Rail
translate([0, -(frame_wid/2 - tube_sz/2), 0]) 
    steel_tube_15(frame_len);


// 2. Cross Members & Hardware
cross_len = frame_wid - (2 * tube_sz);
x_pos_list = [-(frame_len/2)+tube_sz/2, 0, (frame_len/2)-tube_sz/2];

for (x_pos = x_pos_list) {
    translate([x_pos, 0, 0]) {
        // The Tube (Rotated to run Y)
        zrot(90) steel_tube_15(cross_len);
        
        // --- JOINTS (Left Side) ---
        // We place Flat Braces on TOP and BOTTOM of the joint
        translate([0, (frame_wid/2) - tube_sz, 0]) {
            
            // TOP PLATE
            up(tube_sz/2) 
            translate([-brace_wid/2, 0, brace_thk/2])
            zrot(180) // Rotate to form Corner
            flat_corner_brace();
            
            // BOTTOM PLATE
            down(tube_sz/2) 
            translate([-brace_wid/2, 0, -brace_thk/2])
            zrot(180)
            flat_corner_brace();

            // BOLT 1 (Through Cross Member)
            translate([-brace_arm/2 - brace_wid/2, 0, tube_sz/2 + brace_thk]) 
            bolt_assembly_vertical();

            // BOLT 2 (Through Long Rail)
            translate([-brace_wid/2, brace_arm/2, tube_sz/2 + brace_thk]) 
            bolt_assembly_vertical();
        }

        // --- JOINTS (Right Side) ---
        translate([0, -(frame_wid/2) + tube_sz, 0]) {
            
            // TOP PLATE (Mirrored Y)
            up(tube_sz/2)
            translate([-brace_wid/2, 0, brace_thk/2])
            zrot(90) // Corner orientation
            flat_corner_brace();
            
            // BOTTOM PLATE
            down(tube_sz/2)
            translate([-brace_wid/2, 0, -brace_thk/2])
            zrot(90)
            flat_corner_brace();

            // BOLT 1 (Through Cross Member)
            translate([-brace_arm/2 - brace_wid/2, 0, tube_sz/2 + brace_thk]) 
            bolt_assembly_vertical();

             // BOLT 2 (Through Long Rail)
            translate([-brace_wid/2, -brace_arm/2, tube_sz/2 + brace_thk]) 
            bolt_assembly_vertical();
        }
    }
}


// 3. Cable Bracing
inner_L = frame_len - (tube_sz*4);
inner_W = frame_wid - (tube_sz*2);

// Calculate diagonal points
p1 = [-(inner_L/2), (inner_W/2)-12, 0];
p2 = [(inner_L/2), -(inner_W/2)+12, 0];
p3 = [-(inner_L/2), -(inner_W/2)+12, 0];
p4 = [(inner_L/2), (inner_W/2)-12, 0];

// Diagonals
color(c_cable) {
    hull() { translate(p1) sphere(d=4); translate(p2) sphere(d=4); }
    translate((p1+p2)/2) 
        zrot(atan((p1.y-p2.y)/(p1.x-p2.x))) 
        turnbuckle_sim(250);
        
    hull() { translate(p3) sphere(d=4); translate(p4) sphere(d=4); }
    translate((p3+p4)/2) 
        zrot(atan((p3.y-p4.y)/(p3.x-p4.x))) 
        turnbuckle_sim(250);
}

// Eye Bolts 
translate([-(inner_L/2), (inner_W/2), 0])  zrot(180) yrot(90) eye_bolt_assembly();
translate([(inner_L/2), -(inner_W/2), 0])            yrot(90) eye_bolt_assembly();
translate([-(inner_L/2), -(inner_W/2), 0]) zrot(180) yrot(90) eye_bolt_assembly();
translate([(inner_L/2), (inner_W/2), 0])             yrot(90) eye_bolt_assembly();


// 4. EMT Guide Rails
rail_z = (tube_sz/2) + (rail_od/2) + brace_thk; // Sits ON TOP of the plates

// Left EMT
translate([0, (frame_wid/2) - (tube_sz/2), rail_z]) {
    emt_rail_10ft();
    for(x=[-1000, 0, 1000]) translate([x, 0, -rail_od/2]) zrot(90) emt_strap();
}

// Right EMT
translate([0, -(frame_wid/2) + (tube_sz/2), rail_z]) {
    emt_rail_10ft();
    for(x=[-1000, 0, 1000]) translate([x, 0, -rail_od/2]) zrot(-90) emt_strap();
}

// --- LABELS ---
color("black") {
    translate([-frame_len/2, frame_wid/2 + 250, 0])
    text("BOSL2 Hardware (mm)", size=75);
    
    translate([0, -frame_wid/2 - 250, 0])
    text("Flat Corner Plates & Vertical Bolts", size=75, halign="center");
}