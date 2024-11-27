
include <dodecahome_config.scad>
include <wheel_mount.scad>
include <connector_pentagon_plate.scad>

module CradleRest()
{   
    // Attachment to wheel mount
    color([1.0, 0.0, 1.0, 0.75]) translate([0, bracket_start+insert_width, panel_thickness]) rotate([90, 0, 0]) linear_extrude((insert_width+bracket_start)*2) polygon([[0, 0], [0, bracket_height], [bracket_height/tan(tetra_a), 0]]);
}

module WheelMountPrefab(rotation, radius, cell_size, wall_thickness, thickness, border_edge, vent=true, render_color)
{
mounted_wheel_depth = 0.5 + .002;
translate([0, 0, 0])
{
    color([0, 1, 0])
    translate([-wmb_pio, 0, -panel_to_wheel_center+0.5+panel_thickness*1.65]) rotate([-90, 0, -90]) 
    //MountedOmniBall();
    MountedWheel(mounted_wheel_depth);
}
}

module WheelPanelPrefab(rotation, radius, cell_size, wall_thickness, thickness, border_edge, vent=true, render_color, show_mount=false, show_rest=false)
{
difference()
{
// TODO: Evaluate what this size should be, where it should be
// if there should be additional support mechanisms (esp if not metal)
// prior to 2nd print run
mounted_wheel_depth = 0.5 + .002;
translate([0, 0, 0])
{
    if (show_mount) {
        color([0, 1, 0])
        translate([-wmb_pio, 0, -panel_to_wheel_center+0.5+panel_thickness*1.65]) rotate([-90, 0, -90]) 
        //MountedOmniBall();
        MountedWheel(mounted_wheel_depth);
    }
    difference()
    {
        // For back wheels, rotate Z 36
        // translate([10, 0, 0]) rotate([180, 0, 36])
        rotate([0, 0, rotation]) 
        difference()
        {
        // ConnectorPentagonPlate(radius, cell_size, wall_thickness, thickness, border_edge, vent, render_color, [2, 2, 5, 2, 2], [4, 4, 19, 4, 4]);
        ConnectorPentagonPlate(radius, cell_size, wall_thickness, thickness, border_edge, vent, render_color, [3, 3, 3, 3, 3], [4, 4, 19, 4, 4]);
        $fn=36;
        // Hole for power cable
        // TODO: Design a custom vertex connector for the second prototype run
        // rotate([0, 0, -rotation]) translate([-panel_radius, 0, -0.1]) cylinder(panel_thickness+0.2, 3, 3);
        }
        
        // Wheel mount insert
        // wheel mount top width is 12
        for (i= [0 : 0])
        {
            translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
            {
            cube([mounted_wheel_depth, 5, 1]);
            $fn=36;
            translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
            }
            
            mirror([0, 1, 0])
            translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
            {
            cube([mounted_wheel_depth, 5, 1]);
            $fn=36;
            translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
            }
        }
    }
    
    if (show_rest)
    {
    
    difference()
    {
    translate([-wmb_pio+0.5, 0, 0]) CradleRest();
    
    translate([-wmb_pio+1, -2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(20, 7, 7);
    
        translate([-wmb_pio+1, 2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(20, 7, 7);
    }
    
    translate([-wmb_pio+0.5+0.5, -2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) screw("M6x25");
    
    translate([-wmb_pio+0.5+2-2.5, -2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) nut("M6");
    
    translate([-wmb_pio+0.5+0.5, 2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) screw("M6x25");
    
    translate([-wmb_pio+0.5+2-2.5, 2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) nut("M6");
    }
    }
}
// depth of wheel mount

// sphere at start mount
//$fn=36;
//triangular_prism_offset = bracket_height/tan(tetra_a);
//o = sin(90-tetra_a) * 1;
//translate([-wmb_pio+0.5+triangular_prism_offset+1, 0, 0]) sphere(1);

//translate([-wmb_pio+0.5, 0, 0]) CradleRest();
}

module RestPrefab(rotation, radius, cell_size, wall_thickness, thickness, border_edge, vent=true, render_color)
{
    difference()
    {
    translate([-wmb_pio+0.5, 0, 0]) CradleRest();
    
    translate([-wmb_pio+1, -2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(20, 7, 7);
    
        translate([-wmb_pio+1, 2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(20, 7, 7);
    }
    
    translate([-wmb_pio+0.5+0.5, -2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) screw("M6x25");
    
    translate([-wmb_pio+0.5+2-2.5, -2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) nut("M6");
    
    translate([-wmb_pio+0.5+0.5, 2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) screw("M6x25");
    
    translate([-wmb_pio+0.5+2-2.5, 2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) nut("M6");
}

// sphere at center
//$fn = 36;
//color([1.0, 0.0, 0.0, 0.5])
//translate([0, 0, 0]) sphere(1);

//rotate([0, -tetra_a, 0])
//{
// //translate([-wmb_pio+0.5, 0, 0]) CradleRest();
// WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, false, color([0, 1, 1, 1]), true, true);
//}
