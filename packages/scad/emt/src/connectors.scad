include <BOSL2/std.scad>
include <BOSL2/screws.scad>
use <emt_tube.scad>

/* [Main Dimensions] */
// Main Hub Trade Size (Determines Hub Size)
Main_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Wall Thickness (mm)
Wall = 4;
// Tolerance Gap (mm) - Total diametric clearance
Gap = 0.5;
// Connector Sleeve Length (mm)
Length = 50;

/* [Up Side (Z+)] */
Up_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod]
Up_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Up_Screw_Spec = "M8";

/* [Down Side (Z-)] */
Down_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod]
Down_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Down_Screw_Spec = "M8";

/* [Left Side (X-)] */
Left_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod]
Left_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Left_Screw_Spec = "M8";

/* [Right Side (X+)] */
Right_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod]
Right_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Right_Screw_Spec = "M8";

/* [Front Side (Y-)] */
Front_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod]
Front_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Front_Screw_Spec = "M8";

/* [Back Side (Y+)] */
Back_Type = "none"; // [none, socket, plug, screw_hole, threaded_rod]
Back_EMT_Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
Back_Screw_Spec = "M8";


module emt_connector(
    size=Main_Size, 
    wall=Wall, 
    gap=Gap, 
    length=Length,
    
    // Side Configurations passed as simple arguments for API usage
    up_type=Up_Type,       up_emt=Up_EMT_Size,       up_screw=Up_Screw_Spec,
    down_type=Down_Type,   down_emt=Down_EMT_Size,   down_screw=Down_Screw_Spec,
    left_type=Left_Type,   left_emt=Left_EMT_Size,   left_screw=Left_Screw_Spec,
    right_type=Right_Type, right_emt=Right_EMT_Size, right_screw=Right_Screw_Spec,
    front_type=Front_Type, front_emt=Front_EMT_Size, front_screw=Front_Screw_Spec,
    back_type=Back_Type,   back_emt=Back_EMT_Size,   back_screw=Back_Screw_Spec,
    
    anchor=CENTER, 
    spin=0, 
    orient=UP
) {
    // Resolve Main Hub Dimensions
    dims = emt_dims(size);
    hub_od = dims[0];
    hub_size = hub_od + 2 * wall;

    // Structure defining all 6 sides
    sides = [
        [UP,    up_type,    up_emt,    up_screw],
        [DOWN,  down_type,  down_emt,  down_screw],
        [LEFT,  left_type,  left_emt,  left_screw],
        [RIGHT, right_type, right_emt, right_screw],
        [FRONT, front_type, front_emt, front_screw],
        [BACK,  back_type,  back_emt,  back_screw]
    ];

    attachable(anchor, spin, orient, size=[hub_size, hub_size, hub_size]) {
        diff("neg") {
            // Central Hub Cube
            cuboid(hub_size, chamfer=2, edges="ALL", anchor=CENTER);
            
            for (s = sides) {
                vec    = s[0];
                type   = s[1];
                emt_sz = s[2];
                scr_sp = s[3];
                
                if (type != "none") {
                    rot(from=UP, to=vec) {
                        if (type == "socket") {
                            // Resolve Side specific dimensions
                            s_dims = emt_dims(emt_sz);
                            s_od = s_dims[0];
                            // Socket ID is OD + Gap
                            s_socket_id = s_od + gap;
                            // Socket Wall OD needs to be larger
                            s_hub_od = s_od + 2*wall;
                            
                            up(hub_size/2 - 0.05) {
                                cyl(d=s_hub_od, h=length, anchor=BOTTOM);
                                
                                tag("neg") 
                                cyl(d=s_socket_id, h=length + 2, anchor=BOTTOM); 
                            }
                        }
                        else if (type == "plug") {
                            s_dims = emt_dims(emt_sz);
                            s_id = s_dims[1]; // Pipe ID
                            
                            // Male Plug fits into Pipe ID - Gap
                            plug_od = s_id - gap;
                            cyl(d=plug_od, h=length, anchor=BOTTOM);
                        }
                        else if (type == "screw_hole") {
                             // Threaded hole (Female)
                             // Positioned slightly inside face
                             up(hub_size/2 + 0.1)
                             tag("neg")
                             screw_hole(scr_sp, l=hub_size*0.8, thread=true, anchor=BOTTOM, orient=DOWN);
                        }
                        else if (type == "threaded_rod") {
                             // Male Threaded Rod extending OUT
                             screw(scr_sp, l=length, anchor=BOTTOM, orient=UP);
                        }
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
            cyl(d=knob_d, h=15, chamfer=2, anchor=TOP);
        }
        children();
    }
}

// Render the connector if main file (for Customizer)
emt_connector();
