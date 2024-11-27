include <dodecahome_config.scad>
include <pentagon_plate.scad>
include<connector_pentagon_plate.scad>

module Fan(size = 14.0, mount_offset = 0.15)
{   

    difference() {
        translate([0, 0, 1.35]) cube([size, size, 2.5], center=true);
        mount_hole_radius = (0.5+screw_clearance)/2;
        FanMount(size, mount_offset, 100, mount_hole_radius);
    }
}

module FanMount(size = 14.0, mount_offset = 0.15, height, hole_radius)
{
        $fn=32;
        union()
        {
        
        translate([-size+mount_offset/2, -size+mount_offset/2, 0]) cylinder(height, hole_radius, hole_radius, center=true);
        translate([-size+mount_offset/2, size-mount_offset/2, 0]) cylinder(height, hole_radius, hole_radius, center=true);
        translate([size-mount_offset/2, size-mount_offset/2, 0]) cylinder(height, hole_radius, hole_radius, center=true);
        translate([size-mount_offset/2, -size+mount_offset/2, 0]) cylinder(height, hole_radius, hole_radius, center=true);
        }
}

module FanPlate(radius, cell_size, wall_thickness, thickness, border_edge, vent=true, render_color, fan_rot=0.0, show_fan=false) {
    union()
    {
    difference()
    {
    mount_hole_radius = (0.5+screw_clearance)/2;
    union()
    {
    ConnectorPentagonPlate(radius, cell_size, wall_thickness, thickness, border_edge, vent, render_color);
    translate([0, 0, panel_thickness/2]) rotate([0, 0, fan_rot]) FanMount(7.0, 1.5, panel_thickness, 0.8);
    }
    rotate([0, 0, fan_rot]) FanMount(7.0, 1.5, 100, mount_hole_radius);
    }
    if (show_fan)
    {
    rotate([0, 0, fan_rot]) Fan(14.0);
    }
    // Area around ventilation...
    }
}


//FanPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, true, unique_panel_colors[i%len(unique_panel_colors)], 45);