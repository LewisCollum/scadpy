include <BOSL2/std.scad>
include <BOSL2/screws.scad>
use <emt_tube.scad>

/* [Hub] */
// $fn
resolution = 50;
// Main Hub Trade Size (Determines Hub Size)
Main_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Wall Thickness (mm)
Wall = 4;
// Tolerance Gap (mm) - Total diametric clearance
Gap = 0.5;
hub_rounding = 5;
cup_length_override = 0; // [0:0.1:500]

/* [Up Side (Z+)] */
Up_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
Up_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Up_Screw_Spec = "M8";
Up_Length = 50;

/* [Down Side (Z-)] */
Down_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
Down_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Down_Screw_Spec = "M8";
Down_Length = 50;

/* [Left Side (X-)] */
Left_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
Left_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Left_Screw_Spec = "M8";
Left_Length = 50;

/* [Right Side (X+)] */
Right_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
Right_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Right_Screw_Spec = "M8";
Right_Length = 50;

/* [Front Side (Y-)] */
Front_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
Front_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Front_Screw_Spec = "M8";
Front_Length = 50;

/* [Back Side (Y+)] */
Back_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
Back_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Back_Screw_Spec = "M8";
Back_Length = 50;

/* [Hidden] */
$fn = resolution;

module emt_coupler_side(trade_size="1", hole_length=30, base=5, wall=4, fit_tolerance=0.127, anchor=BOTTOM, spin=0, orient=UP) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = inner_d + 2*wall;
    h = hole_length + base;
    
    attachable(anchor, spin, orient, d=outer_d, h=h) {
        union() {
            down(h/2) {
                cyl(d=outer_d, h=base, anchor=BOTTOM);
                up(base) tube(h=hole_length, od=outer_d, id=inner_d, anchor=BOTTOM);
            }
        }
        children();
    }
}

module emt_cup_side(trade_size="1", length=30, base_length=30, base_width=15, base_height=5, wall=4, fit_tolerance=0.127, anchor=BOTTOM, spin=0, orient=UP) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = inner_d + 2*wall;
    diff("hole") {
        cuboid([base_length, base_width, base_height], rounding=wall/2, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT], anchor=anchor, spin=spin, orient=orient) {
            position(TOP) down(wall) tube(od=outer_d, id=inner_d, h=length, anchor=LEFT, spin=spin, orient=LEFT) {
                right(outer_d/2) tag("hole") cube([outer_d, outer_d+0.1, length+0.1], anchor=TOP, center=true);
            }
            children();
        } 
    }
}

module emt_plug_side(trade_size="1", length=30, anchor=BOTTOM, spin=0, orient=UP) {
    dims = emt_dims(trade_size);
    pipe_id = dims[1];
    plug_od = pipe_id;
    cyl(d=plug_od, h=length, anchor=anchor, spin=spin, orient=orient) children();
}

module emt_screw_hole_side(spec="M8", length=30, anchor=TOP, spin=0, orient=DOWN) {
    tag("neg")
    screw_hole(spec, l=length, thread=true, anchor=anchor, spin=spin, orient=orient) children(); 
}

module emt_threaded_rod_side(spec="M8", length=30, anchor=BOTTOM, spin=0, orient=UP) {
    // Screw stud
    screw(spec, l=length, head="none", anchor=anchor, spin=spin, orient=orient) children();
}


module emt_connector(
    size=Main_Size, 
    wall=Wall, 
    gap=Gap, 
    
    // Side Configurations passed as simple arguments for API usage
    up_type=Up_Type,       up_emt=Up_EMT_Size,       up_screw=Up_Screw_Spec,       up_len=Up_Length,
    down_type=Down_Type,   down_emt=Down_EMT_Size,   down_screw=Down_Screw_Spec,   down_len=Down_Length,
    left_type=Left_Type,   left_emt=Left_EMT_Size,   left_screw=Left_Screw_Spec,   left_len=Left_Length,
    right_type=Right_Type, right_emt=Right_EMT_Size, right_screw=Right_Screw_Spec, right_len=Right_Length,
    front_type=Front_Type, front_emt=Front_EMT_Size, front_screw=Front_Screw_Spec, front_len=Front_Length,
    back_type=Back_Type,   back_emt=Back_EMT_Size,   back_screw=Back_Screw_Spec,   back_len=Back_Length,
    
    anchor=CENTER, 
    spin=0, 
    orient=UP,
    rounding=hub_rounding
) {
    // Resolve Main Hub Dimensions
    dims = emt_dims(size);
    hub_od = dims[0];
    hub_size = hub_od + 2 * wall;
    
    // Amount to sink attachments into the block for blending
    inset = rounding;

    // Structure defining all 6 sides
    sides = [
        [UP,    up_type,    up_emt,    up_screw,    up_len],
        [DOWN,  down_type,  down_emt,  down_screw,  down_len],
        [LEFT,  left_type,  left_emt,  left_screw,  left_len],
        [RIGHT, right_type, right_emt, right_screw, right_len],
        [FRONT, front_type, front_emt, front_screw, front_len],
        [BACK,  back_type,  back_emt,  back_screw,  back_len]
    ];

    diff("neg")
    cuboid(hub_size, rounding=rounding, anchor=anchor, spin=spin, orient=orient, $fn=resolution) {
        for (s = sides) {
            vec    = s[0];
            type   = s[1];
            emt_sz = s[2];
            scr_sp = s[3];
            s_len  = s[4];
            
            if (type != "none") {
                // For screw holes, we want them to cut the surface cleanly, so we don't inset them (or negative inset).
                // For additive parts, we inset them to blend.
                overlap_amt = (type == "screw_hole") ? -0.01 : inset;
                
                // Add inset to length so the protruding length matches user spec for additive parts
                eff_len = (type == "screw_hole") ? s_len : s_len + inset;

                attach(vec, overlap=overlap_amt) {
                    // Apply resolution factor for smoother cylinders
                    // Sockets/Plugs get high res, Screws get standard res
                    $fn = (type == "socket" || type == "plug") ? resolution * 2 : resolution;

                    if (type == "socket") {
                        emt_coupler_side(trade_size=emt_sz, hole_length=s_len, base=inset, wall=wall);
                    }
                    else if (type == "plug") {
                        emt_plug_side(trade_size=emt_sz, length=eff_len);
                    }
                    else if (type == "screw_hole") {
                        emt_screw_hole_side(spec=scr_sp, length=eff_len, anchor=BOTTOM /*keep set to BOTTOM*/, orient=DOWN);
                    }
                    else if (type == "threaded_rod") {
                        emt_threaded_rod_side(spec=scr_sp, length=eff_len);
                    }
                    else if (type == "cup") {
                        cup_length = cup_length_override ? cup_length_override : hub_size;
                        emt_cup_side(trade_size=emt_sz, length=cup_length, base_width=hub_size-2*rounding, base_length=hub_size, base_height=inset, wall=wall);
                    }
                }
            }
        }
        children();
    }
}

module leveling_foot(thread="M16", l=50, knob_d=60, anchor=TOP, spin=0, orient=UP) {
    attachable(anchor, spin, orient, d=knob_d, l=l) {
        union() {
            screw(thread, l=l, head="none", anchor=TOP, orient=DOWN);
            position(BOTTOM)
            cyl(d=knob_d, h=15, chamfer=2, anchor=TOP) {
                // Grip texture
                // texture("knurled"); // Optional if enabled
            }
        }
        children();
    }
}

// Render the connector if main file (for Customizer)
emt_connector();
//emt_coupler_side();