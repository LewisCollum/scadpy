include <BOSL2/std.scad>
include <BOSL2/screws.scad>

/* [Screw Dimensions] */
// Select the thread standard compatible with your furniture insert or nut
Thread_Spec = "M8"; // [M6, M8, M10, M12, M16, M20, 1/4-20, 5/16-18, 3/8-16, 1/2-13]
// Available vertical adjustment range
Thread_Length = 50;

/* [Knob Dimensions] */
// Overall width of the grip; larger diameters are easier to turn under load
Knob_Diameter = 40; 
// Vertical thickness of the handle; ensures durability and comfortable finger area
Knob_Height = 15;
// Grip texture style; 3-4 lobes offer high torque, 6+ offer greater comfort
Knob_Lobes = 6; 

/* [Hidden] */
$fn = 64;

module leveling_foot(
    spec=Thread_Spec, 
    l=Thread_Length, 
    knob_d=Knob_Diameter, 
    knob_h=Knob_Height, 
    lobes=Knob_Lobes,
    anchor=TOP, 
    spin=0, 
    orient=UP
) {
    total_h = l + knob_h;
    
    attachable(anchor, spin, orient, d=knob_d, l=total_h) {
        union() {
            screw(spec, l=total_h, head="none", anchor=CENTER, orient=UP);        
            up(total_h/2 - l - knob_h/2) {
                 zrot_copies(n=lobes) {
                    hull() {
                        cyl(d=knob_d/2, h=knob_h, rounding=2, anchor=CENTER);
                        right(knob_d/4) 
                            cyl(d=knob_d/3, h=knob_h, rounding=2, anchor=CENTER);
                    }
                }
                cyl(d=knob_d*0.6, h=knob_h, rounding=2, anchor=CENTER);
            }
        }
        children();
    }
}

leveling_foot();
