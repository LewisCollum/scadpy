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
// Roundness of the main hub block (0=square, 100=sphere).
hub_roundness = 20; // [0:1:100]
// Diametric clearance for coupler fit. Zero for exact size. 0.127 for tight fit. 0.15-0.25 for slip fit.
fit_tolerance = 0.127; // [0:0.001:1.0]

/* [Top Connection (Z+)] */
// Type of connection for the top face.
up_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
up_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
up_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
up_length = 50; // [0:0.1:200]
// Roundness of the socket/cup exterior (0=square, 100=cylinder)
up_roundness = 100; // [0:1:100]
// Depth of the socket hole extending into the hub (0 = stops at socket base).
up_recess = 0; // [0:0.1:100]

/* [Bottom Connection (Z-)] */
// Type of connection for the bottom face.
down_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
down_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
down_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
down_length = 50; // [0:0.1:200]
// Roundness of the socket/cup exterior (0=square, 100=cylinder)
down_roundness = 100; // [0:1:100]
// Depth of the socket hole extending into the hub (0 = stops at socket base).
down_recess = 0; // [0:0.1:100]

/* [Left Connection (X-)] */
// Type of connection for the left face.
left_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
left_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
left_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
left_length = 50; // [0:0.1:200]
// Roundness of the socket/cup exterior (0=square, 100=cylinder)
left_roundness = 100; // [0:1:100]
// Depth of the socket hole extending into the hub (0 = stops at socket base).
left_recess = 0; // [0:0.1:100]

/* [Right Connection (X+)] */
// Type of connection for the right face.
right_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
right_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
right_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
right_length = 50; // [0:0.1:200]
// Roundness of the socket/cup exterior (0=square, 100=cylinder)
right_roundness = 100; // [0:1:100]
// Depth of the socket hole extending into the hub (0 = stops at socket base).
right_recess = 0; // [0:0.1:100]

/* [Front Connection (Y-)] */
// Type of connection for the front face.
front_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
front_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
front_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
front_length = 50; // [0:0.1:200]
// Roundness of the socket/cup exterior (0=square, 100=cylinder)
front_roundness = 100; // [0:1:100]
// Depth of the socket hole extending into the hub (0 = stops at socket base).
front_recess = 0; // [0:0.1:100]

/* [Back Connection (Y+)] */
// Type of connection for the back face.
back_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup]
// Trade size for EMT conduit connections (ignored for screw/rod types).
back_emt_size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]
// Screw specification for holes or rods (e.g., M8, 1/4-20).
back_screw_spec = "M8"; // [M6, M8, M10, M12, M14, M16, M18, M20, 1/4-20, 5/16-18, 3/8-16]
// Length of the connection feature (socket depth, rod length, etc.).
back_length = 50; // [0:0.1:200]
// Roundness of the socket/cup exterior (0=square, 100=cylinder)
back_roundness = 100; // [0:1:100]
// Depth of the socket hole extending into the hub (0 = stops at socket base).
back_recess = 0; // [0:0.1:100]

/* [Hidden] */
$fn = resolution;

module emt_coupler_side(trade_size="1", hole_length=30, base=5, wall=4, fit_tolerance=0.127, roundness=100, recess=0, anchor=BOTTOM, spin=0, orient=UP) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = emt_dims(trade_size)[0] + 2*wall;
    h = hole_length + base;
    // Cap rounding slightly below half-width to prevent BOSL2 assertion failure
    max_r = (outer_d / 2) - 0.01;
    eff_rounding = min(max_r, (outer_d / 2) * (roundness / 100));
    
    attachable(anchor, spin, orient, size=[outer_d, outer_d, h]) {
        down(h/2) {
            union() {
                diff("hole") {
                    cuboid([outer_d, outer_d, h], rounding=eff_rounding, edges="Z", anchor=BOTTOM);
                    // Standard hole
                    up(base) tag("hole") cyl(d=inner_d, h=hole_length+0.1, anchor=BOTTOM);
                    // If recessed, we also need to clear the base of the socket itself
                    if (recess > 0) {
                        // Extend slightly below zero to overlap with the hub cutter
                        down(0.01) tag("hole") cyl(d=inner_d, h=base+0.1, anchor=BOTTOM);
                    }
                }
            }
        }
        children();
    }
}

module emt_cup_side(trade_size="1", length=30, base_length=30, base_width=15, base_height=5, wall=4, fit_tolerance=0.127, roundness=100, anchor=BOTTOM, spin=0, orient=UP) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = emt_dims(trade_size)[0] + 2*wall;
    // Cap rounding slightly below half-width to prevent BOSL2 assertion failure
    max_r = (outer_d / 2) - 0.01;
    eff_rounding = min(max_r, (outer_d / 2) * (roundness / 100));

    diff("hole") {
        cuboid([outer_d, outer_d, length], rounding=eff_rounding, edges="Z", anchor=LEFT, orient=LEFT) {
            tag("hole") cyl(d=inner_d, h=length+0.1);
            right(outer_d/2) tag("hole") cube([outer_d, outer_d+0.1, length+20], anchor=CENTER, center=true);
        }
        children();
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
    fit_tolerance=fit_tolerance,
    
    up_type=up_type,       up_emt=up_emt_size,       up_screw=up_screw_spec,       up_len=up_length,    up_roundness=up_roundness,
    down_type=down_type,   down_emt=down_emt_size,   down_screw=down_screw_spec,   down_len=down_length,    down_roundness=down_roundness,
    left_type=left_type,   left_emt=left_emt_size,   left_screw=left_screw_spec,   left_len=left_length,    left_roundness=left_roundness,
    right_type=right_type, right_emt=right_emt_size, right_screw=right_screw_spec, right_len=right_length,    right_roundness=right_roundness,
    front_type=front_type, front_emt=front_emt_size, front_screw=front_screw_spec, front_len=front_length,    front_roundness=front_roundness,
    back_type=back_type,   back_emt=back_emt_size,   back_screw=back_screw_spec,   back_len=back_length,    back_roundness=back_roundness,
    
    anchor=CENTER, 
    spin=0, 
    orient=UP,
    roundness=hub_roundness
) {
    // Resolve Main Hub Dimensions
    dims = emt_dims(size);
    hub_od = dims[0];
    hub_size = hub_od + 2 * wall;
    
    echo("Hub Dimensions:", trade_size=size, emt_od=hub_od, wall_thickness=wall, total_hub_width=hub_size);

    // Calculate effective rounding based on percentage
    max_r = (hub_size / 2) - 0.01;
    eff_rounding = min(max_r, (hub_size / 2) * (roundness / 100));

    // Amount to sink attachments into the block for blending
    inset = eff_rounding;

    // Structure defining all 6 sides
    sides = [
        [UP,    up_type,    up_emt,    up_screw,    up_len,    up_roundness,    up_recess],
        [DOWN,  down_type,  down_emt,  down_screw,  down_len,  down_roundness,  down_recess],
        [LEFT,  left_type,  left_emt,  left_screw,  left_len,  left_roundness,  left_recess],
        [RIGHT, right_type, right_emt, right_screw, right_len, right_roundness, right_recess],
        [FRONT, front_type, front_emt, front_screw, front_len, front_roundness, front_recess],
        [BACK,  back_type,  back_emt,  back_screw,  back_len,  back_roundness,  back_recess]
    ];

    diff("neg")
    cuboid(hub_size, rounding=eff_rounding, anchor=anchor, spin=spin, orient=orient, $fn=2*resolution) {
        for (s = sides) {
            vec    = s[0];
            type   = s[1];
            emt_sz = s[2];
            scr_sp = s[3];
            s_len  = s[4];
            s_rnd  = s[5];
            s_rec  = s[6];
            
            if (type != "none") {
                // For screw holes, we want them to cut the surface cleanly, so we don't inset them (or negative inset).
                // For additive parts, we inset them to blend.
                overlap_amt = (type == "screw_hole") ? -0.01 : (type == "cup") ? (wall-0.1) : inset;
                
                // Add inset to length so the protruding length matches user spec for additive parts
                eff_len = (type == "screw_hole") ? s_len : s_len + inset;

                attach(vec, overlap=overlap_amt) {
                    // Apply resolution factor for smoother cylinders
                    // Sockets/Plugs/Cups get high res, Screws get standard res
                    $fn = (type == "socket" || type == "plug" || type == "cup") ? resolution * 2 : resolution;

                    if (type == "socket") {
                        emt_coupler_side(trade_size=emt_sz, hole_length=s_len, base=inset, wall=wall, fit_tolerance=fit_tolerance, roundness=s_rnd, recess=s_rec);
                        if (s_rec > 0) {
                            // Explicit cutter for the hub recess
                            // We need to cut from the hub surface (inset) down to the recess depth
                            // Re-calculate inner_d locally
                            inner_d = emt_dims(emt_sz)[0] + fit_tolerance;
                            // Start at inset (surface) and go down by inset + recession amount
                            tag("neg") up(inset+0.01) cyl(d=inner_d, h=inset+s_rec+0.02, anchor=TOP);
                        }
                    }
                    else if (type == "plug") {
                        emt_plug_side(trade_size=emt_sz, length=eff_len);
                    }
                    else if (type == "screw_hole") {
                        emt_screw_hole_side(spec=scr_sp, length=eff_len, anchor=BOTTOM, orient=DOWN);
                    }
                    else if (type == "threaded_rod") {
                        emt_threaded_rod_side(spec=scr_sp, length=eff_len);
                    }
                    else if (type == "cup") {
                        emt_cup_side(trade_size=emt_sz, length=s_len, base_width=(hub_size-2*eff_rounding)/2, base_length=hub_size, base_height=inset, wall=wall, fit_tolerance=fit_tolerance, roundness=s_rnd);
                    }
                }
            }
        }
        children();
    }
}

emt_connector();