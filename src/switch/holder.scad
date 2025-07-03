// Riskable's parametric key switch tester.  Works with Cherry MX and 

$fn = 32;
use <cherryVoid.scad> // Generates the key switch cutout (negative/void space for difference())
use <roundedCube.scad> // Because it's nice to have rounded corners on these sorts of things

// AUTHOR: Riskable <riskable@youknowwhat.com>
// VERSION: 1.1 (Changelog is at the bottom)
// LICENSE: Creative Commons - Attribution - Non-Commercial (if you want to use it in a commercial setting/product just ask!)

// NOTES
/*
    * Enter the length/width of your key switch tester and it'll auto-populate the cutouts (and center them).
    * If you make the LENGTH/WIDTH too small (<21mm) you'll just end up with a solid object.
*/

// CHANGE THESE VALUES TO YOUR LIKING:
LENGTH = 21; // >21
WIDTH = 21; // >21
HEIGHT = 10; // Every key switch tester I've ever seen has been about 1cm thick.
TOLERANCE = 0.1; // How much wiggle room the key switch will get (tight is good)
PLATE_THICKNESS = 1.5; // Official spec for Cherry MX is 1.5 ± 0.1 mm
// If you want to make a little hole in the corner for a keychain:
KEYCHAIN_HOLE = false; // Whether or not to add a hole for a keychain ring/cord
KEYCHAIN_HOLE_DIA = 3; // How wide the hole for a keychain ring/cord will be
KEYCHAIN_HOLE_HEIGHT = HEIGHT/4; // Where the hole gets placed from a height perspective

// Key switch constants (only Cherry MX at the moment but we could support more in the future)
CHERRY_SWITCH_WIDTH = 15.6;

module SwitchHolder()
{


// Generate it!
switch_tester(LENGTH, WIDTH, height=HEIGHT, corner_radius=2, switch_type="cherry_mx");
}

//SwitchHolder();

// Generates a rectangular switch tester of the given length/width with enough switch slots for the given number of *keys* (assuming there's enough space for them)
module switch_tester(length, width, height=10, gap=5, corner_radius=2, switch_type="cherry_mx") {
    difference() {
        roundedCube([length, width, height], r=corner_radius, center=true);
        if (switch_type == "cherry_mx") {
            // Figure out how many keys we can fit per row
            rows = length / (gap + CHERRY_SWITCH_WIDTH);
            echo(rows=rows);
            columns = width / (gap + CHERRY_SWITCH_WIDTH);
            echo(columns=columns);
            x_space = ((gap + CHERRY_SWITCH_WIDTH + TOLERANCE) * floor(rows)) + gap;
            x_center_correction = length/2 - x_space/2;
            y_space = ((gap + CHERRY_SWITCH_WIDTH + TOLERANCE) * floor(columns)) + gap;
            y_center_correction = width/2 - y_space/2;
            // Start at the upper left corner (with the gap taken into account)
            translate([-length/2+CHERRY_SWITCH_WIDTH/2+gap+x_center_correction,width/2-CHERRY_SWITCH_WIDTH/2-gap-y_center_correction,0]) {
                // Place the switch holes/cutouts/voids
                for(y=[0:1:columns-1]) {
                    for(x=[0:1:rows-1]) {
                        translate([x*(gap+CHERRY_SWITCH_WIDTH+TOLERANCE),-(y*(gap+CHERRY_SWITCH_WIDTH+TOLERANCE)),-0.01])
                            cherry_switch_void(height=height, x_extra=gap/1.5, y_extra=gap/1.5, corner_radius=corner_radius/2);
                            // NOTE: cherry_switch_void() comes from cherryVoid.scad
                    }
                }
            }
        }
        if (KEYCHAIN_HOLE) {
            translate([-LENGTH/2, WIDTH/2, KEYCHAIN_HOLE_HEIGHT])
                rotate([90,0,45])
                    cylinder(d=KEYCHAIN_HOLE_DIA, h=CHERRY_SWITCH_WIDTH, center=true);
        }
    }
}

/*
CHANGELOG:
    1.1:
        * The interior of the switch tester now uses roundedCube() so there's no sharp edges (this was actually a change to cherryVoid.scad).
        * You can now add holes for attaching a keychain ring/cord.
    1.0: Initial release
*/