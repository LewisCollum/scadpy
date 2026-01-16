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
// (Cup Only) Number of cup sections to distribute. 1 = solid cup.
up_cup_count = 1; // [1:1:10]
// (Cup Only) Length of each individual cup section (0 = evenly divide total space).
up_cup_seg_len = 0; // [0:0.1:200]
// Extra wall thickness/padding for this face. Useful for deeper screw holes.
up_padding = 0; // [0:0.1:50]
// Offset position of the feature on the face (Left/Right).
up_off_lr = 0; // [-100:0.1:100]
// Offset position of the feature on the face (Up/Down).
up_off_ud = 0; // [-100:0.1:100]

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
// (Cup Only) Number of cup sections to distribute. 1 = solid cup.
down_cup_count = 1; // [1:1:10]
// (Cup Only) Length of each individual cup section (0 = evenly divide total space).
down_cup_seg_len = 0; // [0:0.1:200]
// Extra wall thickness/padding for this face. Useful for deeper screw holes.
down_padding = 0; // [0:0.1:50]
// Offset position of the feature on the face (Left/Right).
down_off_lr = 0; // [-100:0.1:100]
// Offset position of the feature on the face (Up/Down).
down_off_ud = 0; // [-100:0.1:100]

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
// (Cup Only) Number of cup sections to distribute. 1 = solid cup.
left_cup_count = 1; // [1:1:10]
// (Cup Only) Length of each individual cup section (0 = evenly divide total space).
left_cup_seg_len = 0; // [0:0.1:200]
// Extra wall thickness/padding for this face. Useful for deeper screw holes.
left_padding = 0; // [0:0.1:50]
// Offset position of the feature on the face (Left/Right).
left_off_lr = 0; // [-100:0.1:100]
// Offset position of the feature on the face (Up/Down).
left_off_ud = 0; // [-100:0.1:100]

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
// (Cup Only) Number of cup sections to distribute. 1 = solid cup.
right_cup_count = 1; // [1:1:10]
// (Cup Only) Length of each individual cup section (0 = evenly divide total space).
right_cup_seg_len = 0; // [0:0.1:200]
// Extra wall thickness/padding for this face. Useful for deeper screw holes.
right_padding = 0; // [0:0.1:50]
// Offset position of the feature on the face (Left/Right).
right_off_lr = 0; // [-100:0.1:100]
// Offset position of the feature on the face (Up/Down).
right_off_ud = 0; // [-100:0.1:100]

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
// (Cup Only) Number of cup sections to distribute. 1 = solid cup.
front_cup_count = 1; // [1:1:10]
// (Cup Only) Length of each individual cup section (0 = evenly divide total space).
front_cup_seg_len = 0; // [0:0.1:200]
// Extra wall thickness/padding for this face. Useful for deeper screw holes.
front_padding = 0; // [0:0.1:50]
// Offset position of the feature on the face (Left/Right).
front_off_lr = 0; // [-100:0.1:100]
// Offset position of the feature on the face (Up/Down).
front_off_ud = 0; // [-100:0.1:100]

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
// (Cup Only) Number of cup sections to distribute. 1 = solid cup.
back_cup_count = 1; // [1:1:10]
// (Cup Only) Length of each individual cup section (0 = evenly divide total space).
back_cup_seg_len = 0; // [0:0.1:200]
// Extra wall thickness/padding for this face. Useful for deeper screw holes.
back_padding = 0; // [0:0.1:50]
// Offset position of the feature on the face (Left/Right).
back_off_lr = 0; // [-100:0.1:100]
// Offset position of the feature on the face (Up/Down).
back_off_ud = 0; // [-100:0.1:100]

/* [Hidden] */
$fn = resolution;

module emt_coupler_side(trade_size="1", hole_length=30, base=5, wall=4, fit_tolerance=0.127, roundness=100, recess=0, anchor=BOTTOM, spin=0, orient=UP, expand=[0,0,0,0]) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = emt_dims(trade_size)[0] + 2*wall;
    h = hole_length + base;
    // Cap rounding slightly below half-width to prevent BOSL2 assertion failure
    max_r = (outer_d / 2) - 0.01;
    eff_rounding = min(max_r, (outer_d / 2) * (roundness / 100));
    
    // expand = [x_neg, x_pos, y_neg, y_pos] relative to the cross section of the socket
    base_x = outer_d;
    base_y = outer_d;
    tot_x = base_x + expand[0] + expand[1];
    tot_y = base_y + expand[2] + expand[3];
    c_off_x = (expand[1] - expand[0]) / 2;
    c_off_y = (expand[3] - expand[2]) / 2;

    attachable(anchor, spin, orient, size=[tot_x, tot_y, h]) {
        down(h/2) {
            union() {
                diff("hole") {
                    translate([c_off_x, c_off_y, 0])
                    cuboid([tot_x, tot_y, h], rounding=eff_rounding, edges="Z", anchor=BOTTOM);
                    // Standard hole (remains at local 0,0)
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

module emt_cup_side(trade_size="1", length=30, base_length=30, base_width=15, base_height=5, wall=4, fit_tolerance=0.127, roundness=100, anchor=BOTTOM, spin=0, orient=UP, cup_count=1, cup_seg_len=0) {
    inner_d = emt_dims(trade_size)[0] + fit_tolerance;
    outer_d = emt_dims(trade_size)[0] + 2*wall;
    // Cap rounding slightly below half-width to prevent BOSL2 assertion failure
    max_r = (outer_d / 2) - 0.01;
    eff_rounding = min(max_r, (outer_d / 2) * (roundness / 100));
    
    // If SegLen is not provided (0), default to filling the space evenly (0 gap).
    // Otherwise, use the user provided segment length.
    eff_seg_len  = (cup_seg_len > 0) ? cup_seg_len : (length / cup_count); 
    
    // Pitch calculation to distribute cups within the total 'length' span
    pitch = (cup_count > 1) ? ((length - eff_seg_len) / (cup_count - 1)) : 0;
    
    // Start Position (Center of first cup relative to Center of Array)
    start_pos = (cup_count > 1) ? -(length - eff_seg_len)/2 : 0;
    
    for (i = [0 : cup_count - 1]) {
        pos_z = start_pos + (i * pitch);
        
        translate([pos_z, 0, 0])
        diff("hole") {
            cuboid([outer_d, outer_d, eff_seg_len], rounding=eff_rounding, edges="Z", anchor=LEFT, orient=LEFT) {
                tag("hole") cyl(d=inner_d, h=eff_seg_len+0.1, anchor=CENTER);
                right(outer_d/2) tag("hole") cube([outer_d, outer_d+0.1, eff_seg_len+20], anchor=CENTER);
            }
        }
    }
    
    // Attach children at the center of the array group
    children();
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
    
    up_type=up_type,       up_emt=up_emt_size,       up_screw=up_screw_spec,       up_len=up_length,    up_roundness=up_roundness,       up_recess=up_recess,       up_cup_count=up_cup_count,       up_cup_seg_len=up_cup_seg_len,       up_pad=up_padding,       up_olr=up_off_lr,       up_oud=up_off_ud,
    down_type=down_type,   down_emt=down_emt_size,   down_screw=down_screw_spec,   down_len=down_length,    down_roundness=down_roundness,   down_recess=down_recess,   down_cup_count=down_cup_count,   down_cup_seg_len=down_cup_seg_len,   down_pad=down_padding,   down_olr=down_off_lr,   down_oud=down_off_ud,
    left_type=left_type,   left_emt=left_emt_size,   left_screw=left_screw_spec,   left_len=left_length,    left_roundness=left_roundness,   left_recess=left_recess,   left_cup_count=left_cup_count,   left_cup_seg_len=left_cup_seg_len,   left_pad=left_padding,   left_olr=left_off_lr,   left_oud=left_off_ud,
    right_type=right_type, right_emt=right_emt_size, right_screw=right_screw_spec, right_len=right_length,    right_roundness=right_roundness, right_recess=right_recess, right_cup_count=right_cup_count, right_cup_seg_len=right_cup_seg_len,   right_pad=right_padding,   right_olr=right_off_lr,   right_oud=right_off_ud,
    front_type=front_type, front_emt=front_emt_size, front_screw=front_screw_spec, front_len=front_length,    front_roundness=front_roundness, front_recess=front_recess, front_cup_count=front_cup_count, front_cup_seg_len=front_cup_seg_len,   front_pad=front_padding,   front_olr=front_off_lr,   front_oud=front_off_ud,
    back_type=back_type,   back_emt=back_emt_size,   back_screw=back_screw_spec,   back_len=back_length,    back_roundness=back_roundness,   back_recess=back_recess,   back_cup_count=back_cup_count,   back_cup_seg_len=back_cup_seg_len,   back_pad=back_padding,   back_olr=back_off_lr,   back_oud=back_off_ud,
    
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
        [UP,    up_type,    up_emt,    up_screw,    up_len,    up_roundness,    up_recess, up_cup_count, up_cup_seg_len, up_pad, up_olr, up_oud],
        [DOWN,  down_type,  down_emt,  down_screw,  down_len,  down_roundness,  down_recess, down_cup_count, down_cup_seg_len, down_pad, down_olr, down_oud],
        [LEFT,  left_type,  left_emt,  left_screw,  left_len,  left_roundness,  left_recess, left_cup_count, left_cup_seg_len, left_pad, left_olr, left_oud],
        [RIGHT, right_type, right_emt, right_screw, right_len, right_roundness, right_recess, right_cup_count, right_cup_seg_len, right_pad, right_olr, right_oud],
        [FRONT, front_type, front_emt, front_screw, front_len, front_roundness, front_recess, front_cup_count, front_cup_seg_len, front_pad, front_olr, front_oud],
        [BACK,  back_type,  back_emt,  back_screw,  back_len,  back_roundness,  back_recess, back_cup_count, back_cup_seg_len, back_pad, back_olr, back_oud]
    ];
    
    // Check user specified padding to calculate the actual main block geometry
    // Total Size = Original Hub Size + Padding
    // Center Offset = (PositiveSidePadding - NegativeSidePadding) / 2
    
    pad_x = left_pad + right_pad;
    pad_y = front_pad + back_pad;
    pad_z = up_pad + down_pad;
    
    hub_dims = [hub_size + pad_x, hub_size + pad_y, hub_size + pad_z];
    
    // Calculate center shift so that (0,0,0) represents the "functional center" (tube intersection)
    // The functional center (0,0,0) is at distance 'hub_size/2' from the original unpadded faces.
    // If we add Left Padding, the Left Face moves to -(hub_size/2 + left_pad).
    // If we add Right Padding, the Right Face moves to +(hub_size/2 + right_pad).
    // The geometric center of the new block is (RightBound + LeftBound) / 2
    // = ( (hub/2 + R) + (-hub/2 - L) ) / 2 = (R - L) / 2.
    center_offset = [ (right_pad - left_pad)/2, (back_pad - front_pad)/2, (up_pad - down_pad)/2 ];

    diff("neg")
    translate(center_offset)
    cuboid(hub_dims, rounding=eff_rounding, anchor=anchor, spin=spin, orient=orient, $fn=2*resolution) {
        for (s = sides) {
            vec    = s[0];
            type   = s[1];
            emt_sz = s[2];
            scr_sp = s[3];
            s_len  = s[4];
            s_rnd  = s[5];
            s_rec  = s[6];
            s_count = s[7];
            s_seg_len = s[8];
            s_p    = s[9];
            s_lr   = s[10];
            s_ud   = s[11];
            
            // Calculate expansion needed for Side Sockets to match Hub Padding (e.g. for printing support)
            // Socket Width = outer_d. Radius = outer_d/2.
            // Hub Extend = hub_size/2 + padding.
            // Expansion = max(0, HubExtend - SocketRadius).
            
            s_outer_d = emt_dims(emt_sz)[0] + 2*wall;
            s_r = s_outer_d / 2;
            
            w_z_pos = max(0, (hub_size/2 + up_pad) - s_r);
            w_z_neg = max(0, (hub_size/2 + down_pad) - s_r);
            w_x_pos = max(0, (hub_size/2 + right_pad) - s_r);
            w_x_neg = max(0, (hub_size/2 + left_pad) - s_r);
            w_y_pos = max(0, (hub_size/2 + back_pad) - s_r);
            w_y_neg = max(0, (hub_size/2 + front_pad) - s_r);
            
            // Map World alignment to Local Socket Cross-Section alignment [xn, xp, yn, yp]
            // Logic based on standard BOSL2 attach() orientations
            // For LEFT/RIGHT, Local Y aligns with World Z (Up/Down), X aligns with World Y (Front/Back)
            
            // Correction for standard Expand Vec mapping without offsets:
            base_expand = 
                (vec == LEFT)  ? [w_y_pos, w_y_neg, w_z_neg, w_z_pos] : 
                (vec == RIGHT) ? [w_y_neg, w_y_pos, w_z_neg, w_z_pos] : 
                (vec == FRONT) ? [w_x_neg, w_x_pos, w_z_neg, w_z_pos] : 
                (vec == BACK)  ? [w_x_neg, w_x_pos, w_z_pos, w_z_neg] : 
                [0,0,0,0];
            
            // Apply offsets to calculation
            // Expansion[0] (Neg X) += s_lr. Expansion[1] (Pos X) -= s_lr.
            
            expand_vec = [
                max(0, base_expand[0] + s_lr),
                max(0, base_expand[1] - s_lr),
                max(0, base_expand[2] + s_ud),
                max(0, base_expand[3] - s_ud)
            ];
            
            if (type != "none") {
                // Correct for the geometric center vs functional center shift
                // The cuboid is shifted by center_offset. 
                // attach() snaps to the geometric center of the face.
                // We want to snap to the functional center (projected onto the face).
                // So we assume the shift in the directions perpendicular to the face normal.
                
                fix_vec = 
                    (vec.z != 0) ? [-center_offset.x, -center_offset.y, 0] :
                    (vec.x != 0) ? [0, -center_offset.y, -center_offset.z] :
                    [-center_offset.x, 0, -center_offset.z]; // Y-axis normal

                // For screw holes, we want them to cut the surface cleanly, so we don't inset them (or negative inset).
                // For additive parts, we inset them to blend.
                overlap_amt = (type == "screw_hole") ? -0.01 : (type == "cup") ? (wall-0.1) : inset;
                
                // Add inset to length so the protruding length matches user spec for additive parts
                eff_len = (type == "screw_hole") ? s_len : s_len + inset;

                translate(fix_vec)
                attach(vec, overlap=overlap_amt) {
                    // Apply Manual Offset in the Local Tangent Plane
                    translate([s_lr, s_ud, 0]) {
                        // Apply resolution factor for smoother cylinders
                        // Sockets/Plugs/Cups get high res, Screws get standard res
                        $fn = (type == "socket" || type == "plug" || type == "cup") ? resolution * 2 : resolution;
    
                        if (type == "socket") {
                            // Pass the offset-compensated expansion vector
                            emt_coupler_side(trade_size=emt_sz, hole_length=s_len, base=inset, wall=wall, fit_tolerance=fit_tolerance, roundness=s_rnd, recess=s_rec, expand=expand_vec);
                            if (s_rec > 0) {
                                // Explicit cutter for the hub recess
                                // We need to cut from the hub surface (inset) down to the recess depth
                                // Re-calculate inner_d locally
                                inner_d = emt_dims(emt_sz)[0] + fit_tolerance;
                                // Start at inset (surface) and go down by recession amount
                                tag("neg") up(inset+0.01) cyl(d=inner_d, h=s_rec+0.02, anchor=TOP);
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
                            cup_len = (s_len == 0) ? hub_size : s_len;
                            // No shifting, just centered using standard cup side logic (which handles centering)
                            emt_cup_side(trade_size=emt_sz, length=cup_len, base_width=(hub_size-2*eff_rounding)/2, base_length=hub_size, base_height=inset, wall=wall, fit_tolerance=fit_tolerance, roundness=s_rnd, cup_count=s_count, cup_seg_len=s_seg_len);
                        }
                    }
                }
            }
        }
        children();
    }
}

emt_connector();