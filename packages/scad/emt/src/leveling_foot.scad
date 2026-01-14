include <BOSL2/std.scad>
include <BOSL2/screws.scad>

/* [Screw Dimensions] */
// Screw Thread Specification
Thread_Spec = "M8"; // [M6, M8, M10, M12, M16, 1/4-20, 5/16-18, 3/8-16, 1/2-13]
// Length of the threaded portion
Thread_Length = 50;

/* [Knob Dimensions] */
// Diameter of the knob
Knob_Diameter = 40; 
// Height/Thickness of the knob base
Knob_Height = 15;
// Number of lobes/grips on the knob
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
    attachable(anchor, spin, orient, d=knob_d, l=l+knob_h) {
        union() {
            // The Screw
            screw(spec, l=l, head="none", anchor=TOP, orient=DOWN);
            
            // The Knob
            position(BOTTOM)
            zrot_copies(n=lobes) {
                // Create a lobed shape for grip
                // Using nested cylinders to create a petal/lobed shape
                hull() {
                    cyl(d=knob_d/2, h=knob_h, rounding=2, edges=[TOP, BOTTOM], anchor=CENTER);
                    right(knob_d/4) 
                        cyl(d=knob_d/3, h=knob_h, rounding=2, edges=[TOP, BOTTOM], anchor=CENTER);
                }
            }
            
            // Solid center for the knob to ensure functionality
            position(BOTTOM)
            cyl(d=knob_d*0.6, h=knob_h, rounding=2, edges=[TOP, BOTTOM], anchor=TOP);
        }
        children();
    }
}

leveling_foot();
