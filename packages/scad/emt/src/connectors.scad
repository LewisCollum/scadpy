include <BOSL2/std.scad>
include <BOSL2/screws.scad>
use <emt_tube.scad>

/* [Main Configuration] */
// Controls the smoothness of curved surfaces. Higher values increase render time.
resolution = 50; // [20:10:100]
// The primary trade size for the hub, determining the base block dimensions.
main_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Thickness of the hub walls and connector sleeves.
wall_thickness = 4; // [2:0.5:10]
// Diametric clearance for fit. Increase for looser printed parts, decrease for tight press-fits.
gap = 0.5; // [0:0.05:1.0]
// Radius of the rounded corners on the main hub block.
hub_rounding = 5; // [0:0.5:10]
// Global override for cup length. Set to 0 to use side-specific lengths (same as hub width).
cup_length_override = 0; // [0:0.1:500]
// Roundness of the socket exteriors in percent. 100% is cylindrical, 0% is square.
socket_roundness = 100; // [0:1:100]

/* [Top Connection (Z+)] */
// Type of connection for the top face.
up_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
up_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
up_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
up_length = 50; // [0:0.1:200]

/* [Bottom Connection (Z-)] */
// Type of connection for the bottom face.
down_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
down_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
down_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
down_length = 50; // [0:0.1:200]

/* [Left Connection (X-)] */
// Type of connection for the left face.
left_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
left_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
left_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
left_length = 50; // [0:0.1:200]

/* [Right Connection (X+)] */
// Type of connection for the right face.
right_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
right_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
right_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
right_length = 50; // [0:0.1:200]

/* [Front Connection (Y-)] */
// Type of connection for the front face.
front_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
front_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
front_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
front_length = 50; // [0:0.1:200]

/* [Back Connection (Y+)] */
// Type of connection for the back face.
back_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
back_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
back_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
back_length = 50; // [0:0.1:200]

/* [Hidden] */
$fn = resolution;

module emt_coupler_side(trade_size="1", hole_length=30, base=5, wall=4, fit_tolerance=0.127, roundness=100, anchor=BOTTOM, spin=0, orient=UP) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = inner_d + 2*wall;
    h = hole_length + base;
    // Cap rounding slightly below half-width to prevent BOSL2 assertion failure
    max_r = (outer_d / 2) - 0.01;
    eff_rounding = min(max_r, (outer_d / 2) * (roundness / 100));
    
    attachable(anchor, spin, orient, size=[outer_d, outer_d, h]) {
        down(h/2) {
            diff("hole") {
                cuboid([outer_d, outer_d, h], rounding=eff_rounding, edges="Z", anchor=BOTTOM);
                up(base) tag("hole") cyl(d=inner_d, h=hole_length+0.1, anchor=BOTTOM);
            }
        }
        children();
    }
}

module emt_cup_side(trade_size="1", length=30, base_length=30, base_width=15, base_height=5, wall=4, fit_tolerance=0.127, roundness=100, anchor=BOTTOM, spin=0, orient=UP) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = inner_d + 2*wall;
    // Cap rounding slightly below half-width to prevent BOSL2 assertion failure
    max_r = (outer_d / 2) - 0.01;
    eff_rounding = min(max_r, (outer_d / 2) * (roundness / 100));

    diff("hole") {
        cuboid([base_length, base_width, base_height], rounding=wall/2, edges=[FRONT+LEFT, FRONT+RIGHT, BACK+LEFT, BACK+RIGHT], anchor=anchor, spin=spin, orient=orient) {
            position(TOP) down(wall) cuboid([outer_d, outer_d, length], rounding=eff_rounding, edges="Z", anchor=LEFT, orient=LEFT) {
                tag("hole") cyl(d=inner_d, h=length+0.1);
                right(outer_d/2) tag("hole") cube([outer_d, outer_d+0.1, length+20], anchor=CENTER, center=true);
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
    size=main_size, 
    wall=wall_thickness, 
    gap=gap,
    roundness=socket_roundness,
    
    // Side Configurations passed as simple arguments for API usage
    up_type=up_type,       up_emt=up_emt_size,       up_screw=up_screw_spec,       up_len=up_length,
    down_type=down_type,   down_emt=down_emt_size,   down_screw=down_screw_spec,   down_len=down_length,
    left_type=left_type,   left_emt=left_emt_size,   left_screw=left_screw_spec,   left_len=left_length,
    right_type=right_type, right_emt=right_emt_size, right_screw=right_screw_spec, right_len=right_length,
    front_type=front_type, front_emt=front_emt_size, front_screw=front_screw_spec, front_len=front_length,
    back_type=back_type,   back_emt=back_emt_size,   back_screw=back_screw_spec,   back_len=back_length,
    
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
                    // Sockets/Plugs/Cups get high res, Screws get standard res
                    $fn = (type == "socket" || type == "plug" || type == "cup") ? resolution * 2 : resolution;

                    if (type == "socket") {
                        emt_coupler_side(trade_size=emt_sz, hole_length=s_len, base=inset, wall=wall, roundness=roundness);
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
                        emt_cup_side(trade_size=emt_sz, length=cup_length, base_width=(hub_size-2*rounding)/2, base_length=hub_size, base_height=inset, wall=wall, roundness=roundness);
                    }
                }
            }
        }
        children();
    }
}

emt_connector();