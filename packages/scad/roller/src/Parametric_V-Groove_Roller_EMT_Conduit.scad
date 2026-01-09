include <BOSL2/std.scad>
include <BOSL2/screws.scad>

/* [Rendering and Add-Ons] */
// assembled, print "all" layout, or specific part
part = "all"; // [assembled, all, groove_half, spacer_nut, spacer_tube, alignment_ring, outer_washer, bearing, bolt]
// [Printable] false switches spacer to unthreaded tube
include_bolts = true;
// [Printable] bearings that work at least for POC
include_bearings = true;
// [Printable] Helps keep two sides of the roller aligned. May be too large for very small rollers.
include_alignment_ring = true;
// [Printable] Spaces roller away from mounting brackets
include_outer_washers = true;
// $fn
resolution = 75; // [20:1:100]

/* [Bearing Fit Configuration (inner radius control)] */
// Actual spec bearing outer diameter (do not adjust for tolerance here)
bearing_outer_diameter = 22; // [3:0.1:100]
// Standard size for bolt/axle hole
bearing_inner_diameter_spec = "M8"; // [M2, M3, M4, M5, M6, M8, M10, M12, 1/4, 5/16, 3/8]
// Extra space for fitting the bearing
bearing_fit_tolerance = 0.2; // [0:0.01:1]
// How deep the bearing sits within the roller
bearing_width = 7; // [1:0.1:15]
// Thickness of the bearing's outer ring
stopper_thickness = 0.75; // [0.1:0.01:5]
// Number of ribs the bearing crushes when inserting (more ribs = tighter fit)
rib_count = 3; // [0:1:15]
// Zero to use default, otherwise specifies rib thickness
rib_thickness_override = 0; // [0:0.01:15]


/* [Roller Geometry (outer radius control)] */
// Width of the V-groove opening
groove_width = 29.5402; // [1:0.0001:100]
// Angle of the V-groove (degrees)
groove_angle = 45; // [0:1:80]
// Thickness of the roller wall surrounding the groove
radius_padding = 5; // [0.1:0.01:50]
// Extra material padding on either side of the groove
width_padding = 2; // [0.1:0.01:50]
// Alignment ring needs to be tighter to help keep roller sides aligned
alignment_ring_fit_tolerance = 0.2; // [0:0.01:1]

/* [Outer Washers (if enabled)] */
outer_washer_thickness = 1.6; // [1:0.1:10]
// Outer diameter of the outer washers (0 for auto-size based on bolt head)
outer_washer_outer_diameter = 0; // [0:0.1:15]
// Number of outer washers per side
outer_washer_count = 2; // [1:1:10]
// Inner diameter extra space for the washers and spacer (if any)
washer_fit_tolerance = 0.2; // [0:0.01:1]

/* [Bolts (if enabled)] */
// Type of bolt head
bolt_head = "hex"; // [hex, socket]
// Type of bolt drive (undef for default)
bolt_drive = "none"; // [hex, torx, none]
// Extra length for the bolt shank. Thickness of mounting plates, generally.
bolt_shank_extra = 0; // [0:0.01:50]
// Spacing between the bolt end and the roller surface
bolt_end_spacing = 1; // [0.5:0.1:5]
// Thickness of the outer washers

/* [Spacer (if enabled)] */
// Thickness of the internal spacer
spacer_thickness = 4; // [1.5:0.1:6]
// Inner diameter extra space for the spacer
spacer_fit_tolerance = 0.2; // [0:0.01:1]
// Compression allowance for the spacer. For steel bearings (`include_bearings = false`), this should be zero.
spacer_squeeze_tolerance = 0.4; // [0:0.01:1]

/* [Hidden] */
$fn = resolution;

// Derived variables
rib_thickness = rib_thickness_override == 0 ? 2*bearing_fit_tolerance : rib_thickness_override;
stopper_depth = bearing_width;

function clamp(x, lowerLimit, upperLimit) = min(upperLimit, max(lowerLimit, x));

/**
 * Based on "Bearing Generator" version 1.2 by Jason Koolman on MakerWorld
 * https://makerworld.com/en/models/1083205-bearing-generator-parametric-ball-bearings#profileId-1075481
 */
module bearing(
    id, 
    od, 
    width, 
    flange=false, 
    flange_diameter, 
    flange_width, 
    rounding=0, 
    chamfer=0,
    clearance=0.2, 
    ball_spacing=0.02,
    anchor=CTR, 
    spin=0, 
    orient=UP
) {
    // Default flange values
    fd = default(flange_diameter, od * 1.2);
    fw = default(flange_width, width * 0.2);

    mid_d = (id + od) / 2;
    wall = (od - id) / 2 / 3;
    
    ball_d = wall * 2;
    ball_count = floor(PI * mid_d * (1 - ball_spacing) / ball_d);
    ball_elevate = (width - ball_d) / 2;
    
    attachable(anchor, spin, orient, d=od, l=width) {
        union() {
            difference() {
                union() {
                    // Inner Ring
                    tube(id=id, wall=wall, h=width, irounding=rounding>0?rounding:undef, ichamfer=chamfer>0?chamfer:undef);
                    // Outer Ring
                    tube(od=od, wall=wall, h=width, orounding1=(!flange && rounding>0)?rounding:undef, ochamfer1=(!flange && chamfer>0)?chamfer:undef, orounding2=rounding>0?rounding:undef, ochamfer2=chamfer>0?chamfer:undef);
                }
                // Raceway
                torus(r_maj=mid_d/2, r_min=wall+clearance);
            }

            // Balls
            for (i = [0 : ball_count - 1]) {
                zrot(i * 360 / ball_count) 
                right(mid_d / 2) 
                sphere(d=ball_d);
            }

            // Flange
            if (flange) {
                down(width/2 - fw/2)
                tube(id=od, od=max(od, fd), h=fw, orounding1=(rounding>0 && chamfer<=0)?rounding:undef, ochamfer1=chamfer>0?chamfer:undef);
            }

            // Ball Support
            down(width / 2)
            difference() {
                support_h = ball_elevate + 0.12;
                tube(od = mid_d + wall / 2, id = mid_d - wall / 2, l = support_h, anchor = BOTTOM);
                zrot(180 / ball_count) right(mid_d / 2)
                    cube([wall, ball_d / 2, support_h + 0.01], anchor = BOTTOM);
            }
        }
        children();
    }
}

/**
 * author: Lewis Collum
 * Creates a V-groove roller assembly with optional hardware and printable view.
 */
module v_groove_roller(
    bearing_od=22,
    rib_thickness=0.2, 
    rib_count=3,    

    groove_width=29.54,
    groove_angle=45,
    radius_padding=1,
    width_padding=1,

    stopper_depth=8, 
    stopper_thickness=1,

    bolt_spec="M8",
    bolt_head="hex", 
    bolt_drive=undef,
    bolt_shank_extra=0, 
    bolt_end_spacing=1,
    spacer_thickness=4,

    outer_washer_thickness=1.6, 
    outer_washer_outer_diameter=undef,
    outer_washer_count=2,
    
    bearing_fit_tolerance=0.2,
    washer_fit_tolerance=0.2,
    alignment_ring_fit_tolerance=0.2,
    spacer_fit_tolerance=0.2,
    spacer_squeeze_tolerance=0.2,
    
    anchor=CENTER, spin=0, orient=UP,
    include_bolts=true,
    include_bearings=true,
    include_alignment_ring=true,
    include_outer_washers=true,
    part="all"
) {
    is_part_only = part != "all" && part != "assembled";
    bolt = screw_info(bolt_spec, head=bolt_head, drive=bolt_drive);
    bolt_d = struct_val(bolt, "diameter");
    bolt_head_size = struct_val(bolt, "head_size");
    bolt_head_height = struct_val(bolt, "head_height");
    nut = nut_info(bolt_spec);
    nut_width = struct_val(nut, "width");

    width = groove_width + 2*width_padding;
    
    side_width = groove_width / 2 + width_padding;
    side_inner_radius = bearing_od/2 + bearing_fit_tolerance/2;
    side_lesser_outer_radius = bearing_od/2 + radius_padding;
    side_greater_outer_radius = side_lesser_outer_radius + (groove_width/2)*tan(groove_angle);
    module side_body() {
        tube(
            h=groove_width/2, 
            ir=side_inner_radius, 
            or1=side_lesser_outer_radius, 
            or2=side_greater_outer_radius, 
            anchor=BOTTOM
        )
            attach(TOP)
                tube(
                    h=width_padding, 
                    ir=side_inner_radius, 
                    or=side_greater_outer_radius,
                    anchor=BOTTOM
                );
    }

    stopper_length = side_width-stopper_depth;
    stopper_ir = bearing_od/2 - 2*stopper_thickness;
    stopper_od = side_inner_radius;
    module stopper() {
        if (stopper_depth > 0) {
            tube(h=stopper_length, or=stopper_od, ir=stopper_ir, anchor=BOTTOM);
        }
    }

    rib_height = stopper_depth;
    module ribs() {
        zrot_copies(n=rib_count, r=side_inner_radius, $fn=13)
            cyl(r=rib_thickness, h=rib_height, anchor=BOTTOM);        
    }

    alignment_groove_r_maj = (side_lesser_outer_radius - stopper_ir)/2 + stopper_ir;
    alignment_groove_r_min = clamp((side_lesser_outer_radius - stopper_ir)/2-2, 0.5, 2);
    module alignment_ring(radius_padding=0, anchor=CENTER) {
        if (include_alignment_ring || is_part_only) {
            torus(r_maj=alignment_groove_r_maj, r_min=alignment_groove_r_min + radius_padding, anchor=anchor);
        }
    }

    module bearing_fit() {
        if (include_bearings || is_part_only) {
            bearing(
                id=bolt_d, 
                od=bearing_od,
                width=stopper_depth,
                anchor=BOTTOM
            );
        }
    }

    module groove_half() {
        up(stopper_length) ribs();
        difference() {
            union() {
                side_body();
                stopper();
            }
            alignment_ring(radius_padding=alignment_ring_fit_tolerance/2);
        }
    }

    spacer_id = bolt_d + spacer_fit_tolerance;
    spacer_od = include_bolts ? nut_width : spacer_id + 2*spacer_thickness;
    spacer_h = 2*stopper_length - spacer_squeeze_tolerance;
    module spacer_nut(anchor=CENTER) {
        nut(spec=bolt_spec, thickness=spacer_h, anchor=anchor);
    }
    module spacer_tube(anchor=CENTER) {
        tube(id=spacer_id, od=spacer_od, h=spacer_h, anchor=anchor);
    }
    module spacer(anchor=CENTER) {
        if (include_bolts) {
            spacer_nut(anchor=anchor);
        } else {
            spacer_tube(anchor=anchor);
        }
    }

    effective_outer_washer_count = include_outer_washers ? outer_washer_count : 0;
    effective_outer_washer_od =outer_washer_outer_diameter ? outer_washer_outer_diameter : (bolt_head_size + 2);
    module outer_washer() {
        if (include_outer_washers || is_part_only) {
            tube(h=outer_washer_thickness, od=effective_outer_washer_od, id=bolt_d+washer_fit_tolerance, anchor=BOTTOM);
        }
    }
    
    bolt_len = side_width + bolt_shank_extra + effective_outer_washer_count*outer_washer_thickness - bolt_end_spacing;
    bolt_thread_len = spacer_h/2;
    bolt_shank_length = bolt_len - bolt_thread_len;

    module bolt(orient=UP, anchor=TOP) {
        if (include_bolts || is_part_only) {
            screw(bolt_spec, head=bolt_head, drive=bolt_drive, length=bolt_len, thread_len=bolt_thread_len, anchor=anchor, orient=orient);
        }
    }

    module assembled() {
        zflip_copy() groove_half();
        zflip_copy(bolt_end_spacing) bolt(anchor=BOTTOM);
        zflip_copy(side_width) zmove((outer_washer_thickness+bolt_shank_extra)/2) zcopies(spacing=(outer_washer_thickness+bolt_shank_extra)/(effective_outer_washer_count-1), n=effective_outer_washer_count) outer_washer();
        spacer(anchor=CENTER);
        alignment_ring(anchor=CENTER);
        zflip_copy(stopper_length) bearing_fit();
    }

    module printable() {
        printable_sizes = concat(
            [
                2*side_greater_outer_radius, 
                spacer_od
            ],
            include_bolts          ? [bolt_head_size]      : [0],
            include_outer_washers  ? [effective_outer_washer_od] : [0],
            include_bearings       ? [side_inner_radius*2] : [0],
            include_alignment_ring ? [alignment_groove_r_maj*2 + alignment_groove_r_min*2] : [0]
        );
        ydistribute(spacing=2, sizes=printable_sizes) {
            xcopies(spacing=2*side_greater_outer_radius + 2, n=2) groove_half();
            spacer(anchor=BOTTOM);
            xcopies(spacing=effective_outer_washer_od + 2, n=2) bolt(orient=DOWN);
            xcopies(spacing=effective_outer_washer_od + 2, n=2*outer_washer_count) outer_washer();
            xcopies(spacing=2*side_inner_radius + 2, n=2) bearing_fit();
            alignment_ring(anchor=BOTTOM);
        }
    }

    module layout() {
        if (part == "all") {
            printable();
        } else if (part == "assembled") {
            assembled();
        } else if (part == "groove_half") {
            groove_half();
        } else if (part == "spacer_nut") {
            spacer_nut(anchor=BOTTOM);
        } else if (part == "spacer_tube") {
            spacer_tube(anchor=BOTTOM);
        } else if (part == "alignment_ring") {
            alignment_ring(anchor=BOTTOM);
        } else if (part == "outer_washer") {
            outer_washer();
        } else if (part == "bearing") {
            bearing_fit();
        } else if (part == "bolt") {
            bolt(anchor=TOP, orient=DOWN);
        } else {
            assembled();
        }
    }

    attachable(anchor, spin, orient, r=side_greater_outer_radius, l=width) {
        union() {}
        layout() children();
    }
}


color("gray")
v_groove_roller(
    bearing_od=bearing_outer_diameter,
    groove_width=groove_width,
    groove_angle=groove_angle,
    radius_padding=radius_padding,
    width_padding=width_padding,
    stopper_depth=stopper_depth, 
    stopper_thickness=stopper_thickness, 
    bolt_spec=bearing_inner_diameter_spec,
    bolt_head=bolt_head, 
    bolt_drive=bolt_drive,
    bolt_shank_extra=bolt_shank_extra, 
    bolt_end_spacing=bolt_end_spacing,
    outer_washer_thickness=outer_washer_thickness, 
    outer_washer_outer_diameter=outer_washer_outer_diameter > 0 ? outer_washer_outer_diameter : undef,
    outer_washer_count=outer_washer_count,
    spacer_thickness=spacer_thickness,
    rib_thickness=rib_thickness, 
    rib_count=rib_count,
    bearing_fit_tolerance=bearing_fit_tolerance,
    washer_fit_tolerance=washer_fit_tolerance,
    spacer_fit_tolerance=spacer_fit_tolerance,
    spacer_squeeze_tolerance=spacer_squeeze_tolerance,    
    alignment_ring_fit_tolerance=alignment_ring_fit_tolerance,
    anchor=CENTER, spin=0, orient=UP,
    include_bolts=include_bolts,
    include_bearings=include_bearings,
    include_alignment_ring=include_alignment_ring,
    include_outer_washers=include_outer_washers,
    part=part
);
