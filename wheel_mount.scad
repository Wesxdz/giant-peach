include <nutsnbolts/cyl_head_bolt.scad>;
include <dodecahome_config.scad>
// Mounting bracket for wheels

module beveled_cylinder(h, r) {
    $fn = 24; // Optional: set the number of fragments for a smoother shape
    minkowski() {
        translate([0, 0, 0.5]) cylinder(h - 1.0, r - 0.5, r - 0.5); // Adjusted cylinder dimensions
        sphere(0.5); // Bevel radius
    }
}

module OmniBall(radius)
{
   sphere(radius);
}

// https://www.pololu.com/product/3278
// 100x24mm (with 608 bearing)
module ScooterWheel(radius)
{
    difference()
    {
    union()
    {
    difference()
    {
        color([0, 0, 0, .5])
        beveled_cylinder(2.4, radius);
        $fn = 32;
        cylinder(2.4, 1.1, 1.1);
    }
    $fn = 32;
    translate([0, 0, 2.4-0.7]) cylinder(0.7, 1.1, 1.1);
    cylinder(0.7, 1.1, 1.1);
    translate([0, 0, -.51]) cylinder(1.5, .5, .5); // Builtin spacer
    }
    $fn = 32;
    cylinder(2.4, .4, .4);
    }
}

//module Trapezoid(lower_width, upper_width, height)
//{
//    union()
//    {
//    polygon([[0, 0], [upper_width, 0], [lower_width, height], [0, height]]);
//    mirror([1, 0, 0]) polygon([[0, 0], [upper_width, 0], [lower_width, height], [0, height]]);
//    }
//}

// Rounded hull trapezoid
module Trapezoid(lower_width, upper_width, height, cylinder_radius=0.5) {
    $fn=100;
    union() {
        // Define the corners of the trapezoid
        corner1 = [0, 0];
        corner2 = [upper_width, 0];
        corner3 = [lower_width, height];
        corner4 = [0, height];

        // Create the hull
        hull() {
            translate([corner1[0], corner1[1], 0]) circle(r=cylinder_radius);
            translate([corner2[0], corner2[1], 0]) circle(r=cylinder_radius);
            translate([corner3[0], corner3[1], 0]) circle(r=cylinder_radius);
            translate([corner4[0], corner4[1], 0]) circle(r=cylinder_radius);
        }
    }
}

module TSlotCornerBracket()
{
difference()
{
cube([2, 2.8, 2.8]);
translate([0, 0, .4]) cube([2, 2.4, 2.4]);
$fn = 32;
// Bottom cutout
translate([1, 2.8/2, 0]) hull()
{
translate([0, -0.7, 0]) cylinder(1, .3, .3);
translate([0, 0.2, 0]) cylinder(1, .3, .3);
}
// Top cutout
translate([1, 2.8, 1.4]) rotate([90, 0, 0]) hull()
{
translate([0, -0.2, 0]) cylinder(1, .3, .3);
translate([0, 0.7, 0]) cylinder(1, .3, .3);
}
}
}

module MountBrackets()
{
    // Wheel side angle brackets
    //translate([-1, -2.8, .1]) TSlotCornerBracket();
    // translate([1, -2.8, .1]) TSlotCornerBracket();
    // mirror([1, 0, 0]) translate([1, -2.8, .1]) TSlotCornerBracket();
    // Back angle bracket
    mirror([1, 0, 0])  mirror([0, 0, 1]) translate([1, -2.8-.5-panel_thickness, 0]) TSlotCornerBracket();
    mirror([0, 0, 1]) translate([1, -2.8-.5-panel_thickness, 0]) TSlotCornerBracket();
    //mirror([0, 0, 1]) translate([-1, -2.8, 0]) TSlotCornerBracket();
}

panel_to_wheel_center = 8;
module SupportPlane(depth)
{

    perp_insert_form = 
    [
        [insert_width+bracket_start, 0],
        [insert_width+bracket_start, -panel_thickness],
        [bracket_width+bracket_start, -bracket_height-panel_thickness],
        [bracket_start, -bracket_height-panel_thickness],
        [bracket_start, 0],
        [insert_width+bracket_start, 0],
    ];
    difference()
    {
        union()
        {
        
        difference()
        {
        union()
        {
        linear_extrude(depth) Trapezoid(1, 6, panel_to_wheel_center);
        mirror([1, 0, 0]) linear_extrude(depth) Trapezoid(1, 6, panel_to_wheel_center);
        }
        translate([-12, -0.6, 0.0]) cube([24, 1-0.4, 0.6]); // Flat intersection
        }
        // linear_extrude(.1) translate([-3, -2.8, 0]) square([2, 2.8]);
        
        // Offset by trapezoidal hull radius to get the nice round
//        translate([0, -0.0, 0])
        {
        difference()
        {
            linear_extrude(depth) polygon(perp_insert_form);
            //linear_extrude(depth) translate([1, -2.8-0.5-panel_thickness, 0]) square([2, 2.8+panel_thickness]);
            $fn = 32;
            translate([1+1, -bracket_height/2-panel_thickness, 1]) scale(0.1) screw("M6x16");
        }
        
        mirror([1, 0, 0]) difference()
        {
            linear_extrude(depth) polygon(perp_insert_form);
            //linear_extrude(depth) translate([1, -2.8-0.5-panel_thickness, 0]) square([2, 2.8+panel_thickness]);
            $fn = 32;
            translate([1+1, -bracket_height/2-panel_thickness, 1]) scale(.1) screw("M6x16");
        }
        
        }
        }
        
        union()
        {
            linear_extrude(depth) scale(.5) translate([-4.5, 7, 0]) rotate([0, 0, -110]) Trapezoid(2, 3, 2);
            mirror([1, 0, 0]) linear_extrude(depth) scale(.5) translate([-4.5, 7, 0]) rotate([0, 0, -110]) Trapezoid(2, 3, 2);
            $fn = 32;
            // 8mm
            translate([0, panel_to_wheel_center-1, 0]) cylinder(4, .4, .4);
        }
    }
}

module MountedWheel(depth=0.5)
{
    spacer_depth = 0.51;
    translate([0, 0, spacer_depth+depth])
    {
    translate([0, 0, depth+2.4-depth]) scale(0.1) screw("M8x45");
    translate([0, 0, -.7-depth]) scale(0.1) nut("M8");  
    // Small wheel
    // translate([0, 0, .51+.1]) ScooterWheel(3.6);
    // Large wheel
    // 608 bearing builtin spacer
    translate([0, 0, -spacer_depth+depth]) ScooterWheel(5.0);
    translate([0, -panel_to_wheel_center+1, -depth-spacer_depth]) SupportPlane(depth);
    }
}

module MountedOmniBall(depth=0.5)
{
    spacer_depth = 0.51;
    translate([0, 0, depth+2.4-depth]) scale(0.1) screw("M8x45");
    translate([0, 0, -.7-depth]) scale(0.1) nut("M8");  
    // Small wheel
    // translate([0, 0, .51+.1]) ScooterWheel(3.6);
    // Large wheel
    // 608 bearing builtin spacer
    translate([0, 0, -spacer_depth+depth]) OmniBall(6.5);
    translate([7, -panel_to_wheel_center+1, -depth-spacer_depth]) rotate([0, 90, 0]) translate([0, 0, -depth/2]) SupportPlane(depth);
    
    translate([-7, -panel_to_wheel_center+1, -depth-spacer_depth]) rotate([0, 90, 0]) translate([0, 0, -depth/2]) SupportPlane(depth);
}

//mounted_wheel_depth = 0.5 + .002;
//MountedWheel(mounted_wheel_depth);
// MountedOmniBall

//SupportPlane(0.5);