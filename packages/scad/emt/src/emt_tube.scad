include <BOSL2/std.scad>

/* [Dimensions] */
// Trade size of the EMT conduit
Size = "1"; // [1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4]

// Length of the tube in mm
Length = 100;

/* [Render] */
// Resolution
$fn = 50;

/* [Hidden] */
// EMT Conduit Dimensions (in inches)
// Source: Standard EMT specifications (UL 797 / ANSI C80.3)
// Format: [Trade Size String, OD, ID]
_emt_sizes = [
    ["1/2",   0.706, 0.622],
    ["3/4",   0.922, 0.824],
    ["1",     1.163, 1.049],
    ["1-1/4", 1.510, 1.380],
    ["1-1/2", 1.740, 1.610],
    ["2",     2.197, 2.067],
    ["2-1/2", 2.875, 2.731],
    ["3",     3.500, 3.356],
    ["3-1/2", 4.000, 3.834],
    ["4",     4.500, 4.334]
];

module emt_tube(size="1", l=100, anchor=CENTER, spin=0, orient=UP) {
    // Find dimensions
    found = search([size], _emt_sizes, num_returns_first=1);
    
    assert(found != [], str("Unknown EMT size: ", size, ". Available sizes: 1/2, 3/4, 1, 1-1/4, 1-1/2, 2, 2-1/2, 3, 3-1/2, 4"));
    
    dims = _emt_sizes[found[0]];
    od_in = dims[1];
    id_in = dims[2];
    
    INCH = 25.4;
    od = od_in * INCH;
    id = id_in * INCH;
    
    attachable(anchor, spin, orient, d=od, l=l) {
        color("silver")
        tube(h=l, od=od, id=id);
        children();
    }
}

emt_tube(size=Size, l=Length);
