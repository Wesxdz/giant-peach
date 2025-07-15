include <BOSL2/std.scad>
include <BOSL2/ball_bearings.scad>
include <BOSL2/screws.scad>
// Use milimeters

$fn=32;


wheel_radius = 60;
inner_radius = 40;
wheel_cutout = 15;
bearing_cutout = 37/2;
chopped = calculate_chopped_distance(wheel_radius, wheel_cutout);
axis_connection_thickness = 8;

// https://www.amazon.com/uxcell-6705-2RS-Groove-Bearings-Double
module BallBearing()
{
    difference()
    {
        cylinder(4, 37/2, 37/2);
        cylinder(4, 30/2, 30/2);
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
        rotate([0, -90, 0]) cylinder(h=wheel_radius, r1=bearing_cutout , r2=bearing_cutout );
    }
}

module Bearings()
{       
        // Near-barrel wheel
        translate([-wheel_radius + calculate_chopped_distance(wheel_radius, 37/2), 0, 0]) rotate([0, 90, 0]) BallBearing();
        // Near axis-connector
        translate([-axis_connection_thickness -8, 0, 0]) rotate([0, 90, 0]) BallBearing();
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
            rotate([0, -90, 0]) cylinder(h=wheel_radius-2, r1=wheel_cutout, r2=wheel_cutout);
            translate([barrel_wheel_offset, 0, 0]) cuboid([(barrel_wheel_radius+wheel_to_center_padding)*2, 40, barrel_wheel_height], rounding=0.5);
        }
        Bearings();
        // Bearing spacer
        translate([-axis_connection_thickness -4, 0, 0]) rotate([0, 90, 0]) BallBearing();
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
    barrel_wheel_radius = 10;
    barrel_wheel_offset = -wheel_radius + barrel_wheel_radius - chopped;
    barrel_wheel_height = 20;

module SemiWrap()
{
    difference()
    {
        HemisphereSection();
        union()
        {
        HemisphereConnector(barrel_wheel_offset, barrel_wheel_radius, barrel_wheel_height);
        Bearings();
        }
    }
}

module Semiball()
{

    color("grey")
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

module Omniball()
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
    translate([0, inner_radius, 0]) rotate([90, 0, 0]) cylinder(150, 4, 4);
    AxisConnectionScrews();
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


HemisphereConnector(barrel_wheel_offset, barrel_wheel_radius, barrel_wheel_height);
//Omniball();
//Omniwrap();