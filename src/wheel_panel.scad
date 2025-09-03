
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

module WheelMountSlots(wheel_config)
{
    mounted_wheel_depth = 0.5 + .002;
    front_wheel_shift = 0;
    // There are four wheel slot configurations

    // 1. Static stable

    // Wheel mount insert
    // wheel mount top width is 12
    for (i= [0 : 0])
    {
        if (wheel_config != 1)
        {
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        $fn=36;
        //translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
        }
        
        mirror([0, 1, 0])
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        $fn=36;
        //translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
        }
        }
    }
    
    for (i= [0 : 0])
    {
        if (wheel_config == 1)
        {
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        $fn=36;
        //translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
        }
        
        mirror([0, 1, 0])
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        $fn=36;
        //translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
        }
        }
        
        mirror([1, 0, 0])
        {
                if (wheel_config == 1)
        {
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        $fn=36;
        //translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
        }
        
        mirror([0, 1, 0])
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        $fn=36;
        //translate([-1.4, 5-1, .4]) scale(0.1) screw("M6x16");
        }
        }
        }
    }

    for (i= [0 : 0])
    {
        if (wheel_config == 2 || wheel_config == 3)
        {
        // To avoid fragments and ensure support
        // Shift the wheel mount slots forward slightly to prevent cutout overlap with static stability mode
        rotate_wheel_z = wheel_config == 2 ? -standard_side_wheel_tilt : standard_side_wheel_tilt;
        rotate([0, 0, rotate_wheel_z])
        {
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        translate([0, -shift_forward_dist, 0])
        {
        cube([mounted_wheel_depth, 5, 1]);
        }
        
        mirror([0, 1, 0])
        translate([0, shift_forward_dist, 0])
        translate([-wmb_pio-(i*(2.8+mounted_wheel_depth)), -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        }
        }
        }
    }

    for (i= [0 : 1])
    {
        if (wheel_config == 4)
        {
        rotate_wheel_z = -90 + i * 180;
        translate([front_wheel_shift, 0, 0]) // Shift down along vector parallel to panel so the front wheel has
        // equal contact z with side standard wheel (which is dependent on scooter wheel profile)
        rotate([0, 0, rotate_wheel_z])
        {
        translate([-wmb_pio/2, -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        }
        
        mirror([0, 1, 0])
        translate([-wmb_pio/2, -12/2, 0]) 
        {
        cube([mounted_wheel_depth, 5, 1]);
        }
        }
        }
    }
}

module WheelPanelPrefab(rotation, radius, cell_size, wall_thickness, thickness, border_edge, vent = true, render_color, show_mount = true, show_rest = false, wheel_config = 0) {

    // Wheel config
    // 0. static stable only
    // 1. front cradle fixed or steerable standard
    // 2. right (facing me) cradle fixed standard
    // 3. left (facing me) cradle fixed standard

    difference() {
        // TODO: Evaluate what this size should be, where it should be
        // if there should be additional support mechanisms (esp if not metal)
        // prior to 2nd print run
        mounted_wheel_depth = 0.5 + 0.002;

        shift_forward_dist = (wheel_config == 2 ? 1 : -1) * 0.5;
        front_wheel_shift = 0.0; // -1.6; // -1.9

        // The forward rotation constraint vector depends on 'how high off the ground the front wheel is'
        // When flat, 0 standard wheels spin out away from each other
        // and 36 spin inward towards each other
        // Expected to be somewhere in the middle of the range from 0-36 degrees
        // (Between static stable mode and 'tetrahedron C uptilt forward')

        // approximated by iteration from visual inspection of orthographic front view mount self-occlusion
        standard_side_wheel_tilt = 24.635;

        stationary_rot = rotation;

        translate([0, 0, 0]) {
            if (show_mount) {
                color([0, 1, 0]) {
                    // In triwheel mode, the front wheel faces directly forward

                        if (wheel_config == 1)
                        {
                            translate([0, 6.1, 0])
                            rotate([-90, 0, 0])
                            SupportPlane(mounted_wheel_depth);
                            
                            mirror([0, 1, 0])
                            translate([0, 6.1, 0])
                            rotate([-90, 0, 0])
                            SupportPlane(mounted_wheel_depth);
                            
                            translate([0, 0, -7]) scale(0.1) import("omniball.stl");
                        } else
                        {
                            if (robot_mode) {
                            rotate_wheel_z = wheel_config == 2 ? -standard_side_wheel_tilt : (wheel_config == 3 ? standard_side_wheel_tilt : (wheel_config == 1 ? -90 : 0));
                            translate([wheel_config == 1 ? front_wheel_shift - 0.5 : 0, 0, 0])
                            rotate([0, 0, rotate_wheel_z])
                            translate([0, -shift_forward_dist, 0])
                            // The exact displacement of the front wheel mount to be even with the side wheels
                            // depends on the profile of the scooter wheels for exact calculation
                            translate([(wheel_config == 1 ? -wmb_pio / 2 : -wmb_pio), 0, -panel_to_wheel_center + 0.5 + panel_thickness * 1.65])
                            rotate([-90, 0, -90])
                            MountedWheel(mounted_wheel_depth);
                        } else {
                            translate([(wheel_config == 1 ? -wmb_pio / 2 : -wmb_pio), 0, -panel_to_wheel_center + 0.5 + panel_thickness * 1.65])
                            rotate([-90, 0, -90])
                            //MountedOmniBall();
                            MountedWheel(mounted_wheel_depth);
                        }
                    }
                }
            }
            difference() {
                // For back wheels, rotate Z standard_side_wheel_tilt
                // translate([10, 0, 0]) rotate([180, 0, 36])
                
                if (false) // TODO: Render only the wheel/mount in pos
                {
                rotate([0, 0, stationary_rot])
                difference() {
                    ConnectorPentagonPlate(radius, cell_size, wall_thickness, thickness, border_edge, true, render_color, [3, 3, 6, 3, 3], [4, wheel_config == 2 ? 14 : 4, wheel_config == 1 ? 22 : 19, wheel_config == 3 ? 14 : 4, 4], [wheel_config == 1 ? 1 : 0, 0, 1, 0, wheel_config == 1 ? 1 : 0], [standard_secure_spacing, standard_secure_spacing, power_secure_spacing, standard_secure_spacing, standard_secure_spacing]);
                }
                if (wheel_config != 1)
                {
                rotate_wheel_z = wheel_config == 2 ? -standard_side_wheel_tilt : (wheel_config == 3 ? standard_side_wheel_tilt : (wheel_config == 1 ? -90 : 0));
                
                translate([wheel_config == 1 ? front_wheel_shift + 0.5 : 0, 0, 0])
                rotate([0, 0, rotate_wheel_z])
                translate([0, -shift_forward_dist, 0])
                WheelMountSlots(wheel_config);
                }
                }
            }

            if (show_rest) {
                difference() {
                    translate([-wmb_pio + 0.5, 0, 0])
                    CradleRest();

                    translate([-wmb_pio + 1, -2.0, -(-bracket_height / 2 - panel_thickness)])
                    scale(0.1)
                    rotate([0, 90, 0])
                    cylinder(20, 7, 7);

                    translate([-wmb_pio + 1, 2.0, -(-bracket_height / 2 - panel_thickness)])
                    scale(0.1)
                    rotate([0, 90, 0])
                    cylinder(20, 7, 7);
                }

                translate([-wmb_pio + 0.5 + 0.5, -2.0, -(-bracket_height / 2 - panel_thickness)])
                scale(0.1)
                rotate([0, 90, 0])
                screw("M6x25");

                translate([-wmb_pio + 0.5 + 2 - 2.5, -2.0, -(-bracket_height / 2 - panel_thickness)])
                scale(0.1)
                rotate([0, 90, 0])
                nut("M6");

                translate([-wmb_pio + 0.5 + 0.5, 2.0, -(-bracket_height / 2 - panel_thickness)])
                scale(0.1)
                rotate([0, 90, 0])
                screw("M6x25");

                translate([-wmb_pio + 0.5 + 2 - 2.5, 2.0, -(-bracket_height / 2 - panel_thickness)])
                scale(0.1)
                rotate([0, 90, 0])
                nut("M6");
            }
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

module RestPrefabHoles(rotation, radius, cell_size, wall_thickness, thickness, border_edge, vent=true, render_color)
{
    translate([-wmb_pio+1, -2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(35, 7, 7);
    
    translate([-wmb_pio+1, 2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(35, 7, 7);
}

module RestPrefab(rotation, radius, cell_size, wall_thickness, thickness, border_edge, vent=true, render_color, show_screws=false)
{
    difference()
    {
    translate([-wmb_pio+0.5, 0, 0]) CradleRest();
    
    translate([-wmb_pio+1, -2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(20, 7, 7);
    
    translate([-wmb_pio+1, 2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) cylinder(20, 7, 7);
    }
    
    if (show_screws)
    {
    translate([-wmb_pio+0.5+0.5, -2.0, -(-
    bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) screw("M6x25");
    
    translate([-wmb_pio+0.5+2-2.5, -2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) nut("M6");
    
    translate([-wmb_pio+0.5+0.5, 2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) screw("M6x25");
    
    translate([-wmb_pio+0.5+2-2.5, 2.0, -(-bracket_height/2-panel_thickness)]) scale(0.1) rotate([0, 90, 0]) nut("M6");
    }
}


//rotate([0, -tetra_a, 0])
//{
//translate([-wmb_pio+0.5, 0, 0]) CradleRest();
//WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, show_cradle_vent, color([0, 1, 1, 1]), true, show_rest=false, 1);
//}
