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
up_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup, tab]
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
// Orientation rotation of the feature (0=Default, 90=Rotated).
up_rot = 0; // [0:90:270]

/* [Bottom Connection (Z-)] */
// Type of connection for the bottom face.
down_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup, tab]
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
// Orientation rotation of the feature (0=Default, 90=Rotated).
down_rot = 0; // [0:90:270]

/* [Left Connection (X-)] */
// Type of connection for the left face.
left_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup, tab]
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
// Orientation rotation of the feature (0=Default, 90=Rotated).
left_rot = 0; // [0:90:270]

/* [Right Connection (X+)] */
// Type of connection for the right face.
right_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup, tab]
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
// Orientation rotation of the feature (0=Default, 90=Rotated).
right_rot = 0; // [0:90:270]

/* [Front Connection (Y-)] */
// Type of connection for the front face.
front_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup, tab]
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
// Orientation rotation of the feature (0=Default, 90=Rotated).
front_rot = 0; // [0:90:270]

/* [Back Connection (Y+)] */
// Type of connection for the back face.
back_type = "none"; // [none, socket, plug, screw_hole, threaded_rod, cup, tab]
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
// Orientation rotation of the feature (0=Default, 90=Rotated).
back_rot = 0; // [0:90:270]

/* [Hidden] */
$fn = resolution;

function calc_rounding(size, pct) = 
    let(max_r = (size / 2) - 0.01)
    min(max_r, (size / 2) * (pct / 100));

module attachment_hull(base_x, base_y, length, expansion, rounding, edges="Z", anchor=BOTTOM, spin=0, orient=UP) {
    // Calculate total dimensions including expansion to hub edges
    tot_x = base_x + expansion[0] + expansion[1];
    tot_y = base_y + expansion[2] + expansion[3];
    
    // Calculate offset to keep the "functional center" (the tube axis) aligned
    c_off_x = (expansion[1] - expansion[0]) / 2;
    c_off_y = (expansion[3] - expansion[2]) / 2;
    
    // Use smallest dimension to constrain rounding to avoid geometry errors
    // Should NOT use length (Z) for rounding constraint unless we are rounding tops
    eff_rounding = calc_rounding(min(tot_x, tot_y), rounding);

    translate([c_off_x, c_off_y, 0])
    cuboid([tot_x, tot_y, length], rounding=eff_rounding, edges=edges, anchor=anchor, spin=spin, orient=orient);
    
    children();
}

module attachment_hull_tab(base_x, base_y, length, expansion, rounding, anchor=BOTTOM, spin=0, orient=UP) {
    // specialized hull for tabs which needs different rounding edges
    tot_x = base_x + expansion[0] + expansion[1];
    tot_y = base_y + expansion[2] + expansion[3];
    c_off_x = (expansion[1] - expansion[0]) / 2;
    c_off_y = (expansion[3] - expansion[2]) / 2;
    
    eff_rounding = calc_rounding(min(tot_x, tot_y, length), rounding);

    translate([c_off_x, c_off_y, 0])
    cuboid([tot_x, tot_y, length], rounding=eff_rounding, edges=[TOP+FRONT, TOP+BACK], anchor=anchor, spin=spin, orient=orient)
        children();
}

module attachment_bore(type, size, screw_spec, length, fit_tolerance, anchor=BOTTOM, orient=UP, spin=0) {
    if (type == "socket" || type == "plug" || type == "cup") {
        d = emt_dims(size)[0] + fit_tolerance;
        cyl(d=d, h=length, anchor=anchor, orient=orient, spin=spin);
    } 
    else if (type == "screw_hole") {
        screw_hole(screw_spec, l=length, thread=true, anchor=anchor, orient=orient, spin=spin);
    }
}

module emt_connector(
    size=main_size, 
    wall=wall_thickness, 
    fit_tolerance=fit_tolerance,
    
    up_type=up_type,       up_emt=up_emt_size,       up_screw=up_screw_spec,       up_len=up_length,    up_roundness=up_roundness,       up_recess=up_recess,       up_cup_count=up_cup_count,       up_cup_seg_len=up_cup_seg_len,       up_pad=up_padding,       up_olr=up_off_lr,       up_oud=up_off_ud,       up_rot=up_rot,
    down_type=down_type,   down_emt=down_emt_size,   down_screw=down_screw_spec,   down_len=down_length,    down_roundness=down_roundness,   down_recess=down_recess,   down_cup_count=down_cup_count,   down_cup_seg_len=down_cup_seg_len,   down_pad=down_padding,   down_olr=down_off_lr,   down_oud=down_off_ud,   down_rot=down_rot,
    left_type=left_type,   left_emt=left_emt_size,   left_screw=left_screw_spec,   left_len=left_length,    left_roundness=left_roundness,   left_recess=left_recess,   left_cup_count=left_cup_count,   left_cup_seg_len=left_cup_seg_len,   left_pad=left_padding,   left_olr=left_off_lr,   left_oud=left_off_ud,   left_rot=left_rot,
    right_type=right_type, right_emt=right_emt_size, right_screw=right_screw_spec, right_len=right_length,    right_roundness=right_roundness, right_recess=right_recess, right_cup_count=right_cup_count, right_cup_seg_len=right_cup_seg_len,   right_pad=right_padding,   right_olr=right_off_lr,   right_oud=right_off_ud,   right_rot=right_rot,
    front_type=front_type, front_emt=front_emt_size, front_screw=front_screw_spec, front_len=front_length,    front_roundness=front_roundness, front_recess=front_recess, front_cup_count=front_cup_count, front_cup_seg_len=front_cup_seg_len,   front_pad=front_padding,   front_olr=front_off_lr,   front_oud=front_off_ud,   front_rot=front_rot,
    back_type=back_type,   back_emt=back_emt_size,   back_screw=back_screw_spec,   back_len=back_length,    back_roundness=back_roundness,   back_recess=back_recess,   back_cup_count=back_cup_count,   back_cup_seg_len=back_cup_seg_len,   back_pad=back_padding,   back_olr=back_off_lr,   back_oud=back_off_ud,   back_rot=back_rot,
    
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
    eff_rounding = calc_rounding(hub_size, roundness);

    // Amount to sink attachments into the block for blending
    inset = eff_rounding;

    // Structure defining all 6 sides
    sides = [
        [UP,    up_type,    up_emt,    up_screw,    up_len,    up_roundness,    up_recess, up_cup_count, up_cup_seg_len, up_pad, up_olr, up_oud, up_rot],
        [DOWN,  down_type,  down_emt,  down_screw,  down_len,  down_roundness,  down_recess, down_cup_count, down_cup_seg_len, down_pad, down_olr, down_oud, down_rot],
        [LEFT,  left_type,  left_emt,  left_screw,  left_len,  left_roundness,  left_recess, left_cup_count, left_cup_seg_len, left_pad, left_olr, left_oud, left_rot],
        [RIGHT, right_type, right_emt, right_screw, right_len, right_roundness, right_recess, right_cup_count, right_cup_seg_len, right_pad, right_olr, right_oud, right_rot],
        [FRONT, front_type, front_emt, front_screw, front_len, front_roundness, front_recess, front_cup_count, front_cup_seg_len, front_pad, front_olr, front_oud, front_rot],
        [BACK,  back_type,  back_emt,  back_screw,  back_len,  back_roundness,  back_recess, back_cup_count, back_cup_seg_len, back_pad, back_olr, back_oud, back_rot]
    ];
    
    // Check user specified padding to calculate the actual main block geometry
    // Total Size = Original Hub Size + Padding
    // Center Offset = (PositiveSidePadding - NegativeSidePadding) / 2
    
    pad_x = left_pad + right_pad;
    pad_y = front_pad + back_pad;
    pad_z = up_pad + down_pad;
    
    hub_dims = [hub_size + pad_x, hub_size + pad_y, hub_size + pad_z];
    
    // Calculate center shift so that (0,0,0) represents the "functional center" (tube intersection)
    center_offset = [ (right_pad - left_pad)/2, (back_pad - front_pad)/2, (up_pad - down_pad)/2 ];

    translate(center_offset)
    diff("neg")
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
            s_rot  = s[12];
            
            if (type != "none") {
                // Common Geometry Calculations
                s_inner_d = emt_dims(emt_sz)[0] + fit_tolerance;
                s_outer_d = emt_dims(emt_sz)[0] + 2*wall;
                s_r = s_outer_d / 2;

                // Expansion Logic
                w_exp = [
                    max(0, (hub_size/2 + left_pad) - s_r),  // -X (Left)
                    max(0, (hub_size/2 + right_pad) - s_r), // +X (Right)
                    max(0, (hub_size/2 + front_pad) - s_r), // -Y (Front)
                    max(0, (hub_size/2 + back_pad) - s_r),  // +Y (Back)
                    max(0, (hub_size/2 + down_pad) - s_r),  // -Z (Down)
                    max(0, (hub_size/2 + up_pad) - s_r)     // +Z (Up)
                ];

                // Map World alignment to Local Socket Cross-Section alignment [xn, xp, yn, yp]
                // For LEFT/RIGHT, Local Y aligns with World Z (Up/Down), X aligns with World Y (Front/Back)
                base_expand = 
                    (vec == LEFT)  ? [w_exp[3], w_exp[2], w_exp[4], w_exp[5]] : // Y+, Y-, Z-, Z+
                    (vec == RIGHT) ? [w_exp[2], w_exp[3], w_exp[4], w_exp[5]] : // Y-, Y+, Z-, Z+
                    (vec == FRONT) ? [w_exp[0], w_exp[1], w_exp[4], w_exp[5]] : // X-, X+, Z-, Z+
                    (vec == BACK)  ? [w_exp[1], w_exp[0], w_exp[4], w_exp[5]] : // X+, X-, Z-, Z+
                    (vec == UP)    ? [w_exp[0], w_exp[1], w_exp[2], w_exp[3]] : // X-, X+, Y-, Y+
                    (vec == DOWN)  ? [w_exp[0], w_exp[1], w_exp[3], w_exp[2]] : // X-, X+, Y+, Y-
                    [0,0,0,0];
                
                expand_vec = [
                    max(0, base_expand[0] + s_lr),
                    max(0, base_expand[1] - s_lr),
                    max(0, base_expand[2] + s_ud),
                    max(0, base_expand[3] - s_ud)
                ];

                // Correct for the geometric center vs functional center shift
                fix_vec = 
                    (vec.z != 0) ? [-center_offset.x, -center_offset.y, 0] :
                    (vec.x != 0) ? [0, -center_offset.y, -center_offset.z] :
                    [-center_offset.x, 0, -center_offset.z]; // Y-axis normal

                // Overlap/Inset Logic
                overlap_amt = (type == "screw_hole") ? -0.01 : (type == "cup") ? (wall-0.1) : inset;
                eff_len = (type == "screw_hole") ? s_len : s_len + inset;

                translate(fix_vec)
                attach(vec, overlap=overlap_amt, spin=s_rot) {
                    translate([s_lr, s_ud, 0]) {
                        // Apply resolution factor
                        $fn = (type == "socket" || type == "plug" || type == "cup") ? resolution * 2 : resolution;

                        // Default Feature Orientation: UP (aligned with face normal) for now.
                        // Ideally this comes from a parameter like `s_feat_orient`.
                        feat_orient = UP;

                        // Infer Hull Dimensions & Feature Type
                        // Socket: Hull = OuterD, Feature = Socket/Round
                        // Tab: Hull = HubSize/SegLen, Feature = ScrewHole/Orient RIGHT
    
                        if (type == "socket") {
                            // Hull: Standard Socket Block
                            diff("hole")
                            attachment_hull(
                                base_x = s_outer_d, 
                                base_y = s_outer_d, 
                                length = eff_len, 
                                expansion = expand_vec, 
                                rounding = s_rnd,
                                anchor = BOTTOM
                            ) {
                                // Internal Bore
                                tag("hole")
                                up(inset) // Start at surface
                                attachment_bore(
                                    type = type, 
                                    size = emt_sz, 
                                    screw_spec = scr_sp, 
                                    length = s_len + 1, 
                                    fit_tolerance = fit_tolerance,
                                    anchor = BOTTOM,
                                    orient = feat_orient
                                );
                                
                                // Recess Logic - Clear base of socket in the Hull
                                if (s_rec > 0) {
                                    down(0.01) tag("hole") cyl(d=s_inner_d, h=inset+0.1, anchor=BOTTOM);
                                }
                            }
                            
                            // Recess Logic - Cut into Hub (Sibling to Hull)
                            if (s_rec > 0) {
                                tag("neg") up(inset+0.01) cyl(d=s_inner_d, h=s_rec+0.02, anchor=TOP);
                            }
                        }
                        else if (type == "plug") {
                            plug_od = emt_dims(emt_sz)[1];
                            cyl(d=plug_od, h=eff_len, anchor=BOTTOM);
                        }
                        else if (type == "screw_hole") {
                            tag("neg")
                            screw_hole(scr_sp, l=eff_len, thread=true, anchor=BOTTOM, orient=DOWN);
                        }
                        else if (type == "threaded_rod") {
                             screw(scr_sp, l=eff_len, head="none", anchor=BOTTOM);
                        }
                        else if (type == "cup") {
                            cup_len = (s_len == 0) ? hub_size : s_len;
                            c_eff_seg_len  = (s_seg_len > 0) ? s_seg_len : (cup_len / s_count); 
                            c_pitch = (s_count > 1) ? ((cup_len - c_eff_seg_len) / (s_count - 1)) : 0;
                            c_start_pos = (s_count > 1) ? -(cup_len - c_eff_seg_len)/2 : 0;
                            s_eff_rounding = calc_rounding(s_outer_d, s_rnd);
    
                            for (i = [0 : s_count - 1]) {
                                pos_z = c_start_pos + (i * c_pitch);
                                translate([pos_z, 0, 0])
                                diff("hole") {
                                    cuboid([s_outer_d, s_outer_d, c_eff_seg_len], rounding=s_eff_rounding, edges="Z", anchor=LEFT, orient=LEFT) {
                                        tag("hole") cyl(d=s_inner_d, h=c_eff_seg_len+0.1, anchor=CENTER);
                                        right(s_outer_d/2) tag("hole") cube([s_outer_d, s_outer_d+0.1, c_eff_seg_len+20], anchor=CENTER);
                                    }
                                }
                            }
                            children();
                        }
                        else if (type == "tab") {
                             // Hull: Tab Block
                            attachment_hull_tab(
                                base_x = hub_size, 
                                base_y = s_seg_len, 
                                length = s_len, 
                                expansion = expand_vec, 
                                rounding = s_rnd,
                                anchor = BOTTOM // Standardized to BOTTOM
                            ) {
                                // Internal Feature: Screw Hole side-ways
                                position(TOP) down(wall) tag("hole") 
                                attachment_bore(
                                    type = "screw_hole", 
                                    size = emt_sz, 
                                    screw_spec = scr_sp, 
                                    length = s_seg_len + expand_vec[2] + expand_vec[3] + 1, // Total breadth of tab approx? 
                                    fit_tolerance = fit_tolerance,
                                    anchor = LEFT, 
                                    orient = RIGHT
                                );
                            }
                        }
                    }
                }
            }
        }
        children();
    }
}

emt_connector();