// '608 Minimalist' by Wesley Spacebar

include <BOSL2/std.scad>
include <BOSL2/ball_bearings.scad>
include <BOSL2/screws.scad>
// Use milimeters

$fn=32;


wheel_radius = 60;
inner_radius = 40;
split_pos = wheel_radius/5*3;
wheel_cutout = 15;
bearing_cutout = 7;//37/2;
chopped = calculate_chopped_distance(wheel_radius, wheel_cutout);
axis_connection_thickness = 8;

    barrel_wheel_radius = 8;//10;
    barrel_wheel_offset = -wheel_radius + barrel_wheel_radius - chopped;
    barrel_wheel_height = 20;

// James Bruton's design used larger bearings like these
// https://www.amazon.com/uxcell-6705-2RS-Groove-Bearings-Double
// However the original Tetrahedral Mobile Robot (Tadakuma 2006) 
// from what I can tell used standard 608 bearings and expanded the inner cylinder
// See Fig. 9 vs Fig. 11/12 bearing positions
//module BallBearing()
//{
//    difference()
//    {
//        cylinder(4, 37/2, 37/2);
//        cylinder(4, 30/2, 30/2);
//    }
//}

module BallBearing()
{
    difference()
    {
        cylinder(7, 22/2, 22/2);
        cylinder(7, 8/2, 8/2);
    }
}

module Semisphere()
{
    difference()
    {
        sphere(wheel_radius);
        translate([-axis_connection_thickness, -wheel_radius, -wheel_radius])
        cube([wheel_radius*2, wheel_radius*2, wheel_radius*2]);
    }
}

module HemisphereSection()
{
    difference()
    {
        Semisphere();
        wheel_padding = 1.0;
        union()
        {
        rotate([0, -90, 0]) cylinder(h=axis_connection_thickness+1, r1=wheel_cutout+wheel_padding, r2=wheel_cutout+wheel_padding);
        translate([-axis_connection_thickness-1, 0, 0]) rotate([0, -90, 0]) cylinder(h=7, r1=bearing_cutout, r2=bearing_cutout);
        // Place the bearings in from either side
        steel_ring_height = 1.0;
        translate([-axis_connection_thickness-1-7, 0, 0]) rotate([0, -90, 0]) cylinder(h=wheel_radius, r1=bearing_cutout-steel_ring_height, r2=bearing_cutout-steel_ring_height);
        translate([-split_pos+7, 0, 0]) rotate([0, -90, 0]) cylinder(h=7, r1=bearing_cutout, r2=bearing_cutout);
        
        hull()
        {
        // this needs to remain open for insertion of wheel barrel support piece...
        translate([-split_pos, 0, 0]) rotate([0, -90, 0]) cylinder(h=wheel_radius-split_pos, r1=wheel_cutout+wheel_padding, r2=wheel_cutout+wheel_padding); // - split_pos - 7

       
      
        //translate([-split_pos-(wheel_radius-split_pos-7), 0, 0]) rotate([0, -90, 0]) cylinder(h=wheel_radius-split_pos-7, r1=wheel_cutout-4, r2=wheel_cutout-4); 
        }
        }
    }
}

module Bearings()
{       
        // Near-barrel wheel
        // The problem is that it will overlap the barrel dowel pin
        //translate([-wheel_radius + calculate_chopped_distance(wheel_radius, 37/2), 0, 0]) 
        translate([-split_pos, 0, 0]) rotate([0, 90, 0]) BallBearing();
        // Near axis-connector
        translate([-axis_connection_thickness -7-2, 0, 0]) rotate([0, 90, 0]) BallBearing();
}

function calculate_chopped_distance(sphere_radius, cylinder_radius) =
    (cylinder_radius >= sphere_radius) ? 0 : (sphere_radius - sqrt(pow(sphere_radius, 2) - pow(cylinder_radius, 2)));

module HemisphereConnector(barrel_wheel_offset, barrel_wheel_radius, barrel_wheel_height, wheel_to_center_padding=0.75)
{   
    difference()
    {
    union()
    {
        rotate([0, -90, 0]) cylinder(axis_connection_thickness , inner_radius , inner_radius);
        difference()
        {
            union()
            {
            // So that it can be 3D printed
            slope_dist = 4;
            
            hull()
            {
            
            hull()
            {
            translate([-split_pos-slope_dist, 0, 0]) rotate([0, -90, 0]) cylinder(h=(wheel_radius-split_pos)-slope_dist, r1=barrel_wheel_height/2, r2=barrel_wheel_height/2);
            translate([-split_pos-slope_dist, 0, 0]) rotate([0, -90, 0]) cylinder(h=(wheel_radius-split_pos)-slope_dist-4, r1=wheel_cutout, r2=wheel_cutout);
            }
            
            translate([-split_pos, 0, 0]) rotate([0, -90, 0]) cylinder(h=slope_dist, r1=4, r2=4);
            }
            rotate([0, -90, 0]) cylinder(h=split_pos, r1=4, r2=4);
            }
            translate([barrel_wheel_offset, 0, 0]) cuboid([(barrel_wheel_radius+wheel_to_center_padding)*2, 40, barrel_wheel_height], rounding=0.5);
        }
        color([0.3, 0.3, 0.3, 1])
        Bearings();
        // Bearing spacer
        translate([-axis_connection_thickness -2, 0, 0])    
        rotate([0, 90, 0]) cylinder(2, 22/2, 22/2);
    }
    translate([barrel_wheel_offset, 0, -wheel_cutout]) cylinder(30, 1.5, 1.5);
    }
}

module BarrelWheel(radius=3, height=3)
{
    difference()
    {
    hull()
    {
        translate([0,0,-height/2]) cylinder(0.1, radius-radius/8);
        translate([0,0,-height/2+height/16]) cylinder(0.1, radius-radius/16);
        translate([0,0,-height/2+height/4]) cylinder(0.1, radius);
        translate([0,0,height/2-height/4]) cylinder(0.1, radius);
        translate([0,0,height/2-height/16]) cylinder(0.1, radius-radius/16);
        translate([0,0,height/2]) cylinder(0.1, radius-radius/8);
    }
    translate([0, 0, -wheel_cutout]) cylinder(30, 1.5, 1.5);
    }
}

module SemiWrap()
{
    difference()
    {
        HemisphereSection();
        union()
        {
        //rotate([0, -90, 0]) cylinder(axis_connection_thickness , inner_radius , inner_radius);
        }
    }
}

module Semiball()
{

    union()
    {
    union()
    {
    HemisphereConnector(barrel_wheel_offset, barrel_wheel_radius, barrel_wheel_height);
    translate([barrel_wheel_offset, 0, 0]) 
    {
        BarrelWheel(barrel_wheel_radius, barrel_wheel_height);
        // https://www.aliexpress.us/item/2255800287548941.html
        // Use 'dowel pin'
        //translate([0, 0, -wheel_cutout]) cylinder(30, 1.5, 1.5);
        
    }
    }
    }
}

module Omniball(show_screws=false)
{
    union()
    {
    difference()
    {
    union()
    {
        Semiball();
        mirror([1, 0, 0]) Semiball();
    }
    union()
    {
        translate([0, 100, 0]) rotate([90, 0, 0]) cylinder(200, 4, 4);
        translate([0, inner_radius, 0]) rotate([90, 0, 0]) nut_trap_inline(6.5, "M8");
        translate([0, -inner_radius, 0]) rotate([-90, 0, 0]) nut_trap_inline(6.5, "M8");
        AxisConnectionScrews();
    }
    }
    // 150mm m8 threaded rod
    pad = 10;
    translate([0, wheel_radius+pad , 0]) rotate([90, 0, 0]) cylinder((
    wheel_radius+pad)*2, 4, 4);
    if (show_screws)
    {
        AxisConnectionScrews();
    }
    }
}

module Omniwrap()
{
    SemiWrap();
    mirror([1, 0, 0]) SemiWrap();
}

module AxisConnectionScrews()
{
    axis_connector_screws = 8;
    for (i=[0:(axis_connector_screws-1)])
    {
        if (i != 2 && i != 6)
        {
        rotate([90, i*360/axis_connector_screws, -90]) translate([0, inner_radius-10, 0]) screw("M3", head="socket", thread="none", drive="hex", length=20);
        }
    }
}


//HemisphereConnector(barrel_wheel_offset, barrel_wheel_radius, barrel_wheel_height);
module CrossSection()
{
difference()
{
union()
{
Omniball();
color([0, 0.5, 0.5, 0.2])
Omniwrap();
}
translate([-100, 0, -100]) cube([200, 200, 200]);
}
}

CrossSection();