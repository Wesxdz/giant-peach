// For evaluating cradle vertex connector power variant

include <dodecahome_config.scad>
include <wheel_panel.scad>

include <BOSL2/std.scad>
include <BOSL2/gears.scad>

module Cradle()
{
// Export
//translate([0, 0, 209])
//scale(10)
rotate([0, -tetra_a, 180])
rotate([0, 0, -30-120-120])
//rotate([0, 0, -30])

union()
{
color([0.3, 0.3, 0.4, 1]) translate([0, 0, -260/10])
scale(0.1) import("vertex_connector_power_variant_mm.stl");

rotate([0, 0, 30])
difference()
{
rotate([0, 0, -30])
difference()
{
$fn=128;
    rotate([-magic_angle, 0, 0])
    {
        for (i = [0 : len(pos)-1]) {
            if (face_groups[i] == 3)
            {
            translate(pos[i]*panel_edge_length) rotate(rots[i]) rotate([0, 0, panel_rots[i]])
            {
                show_cradle_vent = false;
                show_mounts = true;
                if (i == 4)
                {
                    //WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, show_cradle_vent, color([0, 1, 1, 1]), show_mounts , show_rest=false, 2);
                }
                
                if (i == 11) 
                {
                    //WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, show_cradle_vent, color([0, 1, 1, 1]), show_mounts , show_rest=false, 3);
                }
                
                if (i == 9) 
                {
                    WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, show_cradle_vent, color([0, 1, 1, 1]), show_mounts , show_rest=false, 1);
                }
                }
                
            }
        }
    }
    
    // TODO: Calculate the exact Y intersection
    translate([0, 0, -29.1])
    //translate([0, 0, tan(90-magic_angle)*5])
    // translate([0, 0, -26.3564)
    union()
    {
    cylinder(5, 8, 8);
    hull()
    {
        for (i=[0:3])
        {
            rotate([0, 0, 60+i*120]) translate([0, 4, 0]) cylinder(10, 1.0, 1.0);
            //rotate([0, 0, 60+i*120]) translate([0, 4, 5]) sphere(1.0);
        }
    }
    }
}
$fn=100;
    scale([1, 1, 1])
    translate([0, 0, -29.1])
    hull()
    {
        for (i=[0:3])
        {
            rotate([0, 0, 30+i*120]) translate([0, 4, 0]) cylinder(10, 1.0, 1.0);
            //rotate([0, 0, 60+i*120]) translate([0, 4, 5]) sphere(1.0);
        }
    }
}
}
}

rotate([0, -tetra_a, 0])
{
gear_cutout_radius = 9.0;

translate([0, 0, 20.9443]) difference()
{
Cradle();
//color([0, 1, 0, 0.4]) rotate([0, 180, 0]) cylinder(30, gear_cutout_radius, gear_cutout_radius, $fn=120);
}

// TODO: Static stable mode should align with the panel
// by making this circle extrusion middle and edges cutout on the first panel_thickness depth
// The extrusion beyond the chassis is to prevent the turning
// cylinder from being pushed in essentially...

translate([0, 0, -panel_thickness]) difference()
{
color([0.2, 0.6, 0.2, 1]) cylinder(panel_thickness, gear_cutout_radius+1, gear_cutout_radius+1, $fn=64);
WheelMountSlots(1);
}

difference()
{
color([0.2, 0.6, 0.2, 1]) cylinder(panel_thickness, gear_cutout_radius, gear_cutout_radius, $fn=64);
WheelMountSlots(1);
}

//translate([0, 0, -panel_thickness]) color([0.2, 0.6, 0.2, 1]) linear_extrude(panel_thickness*2) projection() {
//intersection()
//{
//Cradle();
//color([0, 1, 0, 0.4]) rotate([0, 180, 0]) cylinder(30, gear_cutout_radius, gear_cutout_radius, $fn=120);
//}
//}

wg_teeth = 40;
wheel_gear_circle_diameter = gear_cutout_radius*2.0-1;
pitch = PI*wheel_gear_circle_diameter/wg_teeth;
color([0.5, 0.5, 0.5, 1.0]) translate([0, 0, panel_thickness*2]) difference() {
linear_extrude(panel_thickness) spur_gear2d(circ_pitch=pitch, teeth=wg_teeth, shaft_diam=0);
WheelMountSlots(4);
}
 
tg_teeth = 6;
turning_gear_circle_diameter = 3;
rotate([0, 0, -36-72]) translate([(wheel_gear_circle_diameter+turning_gear_circle_diameter)/2, 0, panel_thickness*2]) 
{
color([0.2, 0.0, 0.8, 1.0]) linear_extrude(panel_thickness)
 spur_gear2d(circ_pitch=pitch, teeth=6, shaft_diam=0.5);
 
 translate([0, 0, panel_thickness]) color([0.4, 0.4, 0.4, 0.5]) cylinder(6, 2, 2, $fn=36);
}
}

//color([0.5, 0.5, 0.5, 0.5]) import("bottom_connectors.stl");