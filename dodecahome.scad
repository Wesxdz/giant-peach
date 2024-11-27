// Welcome Dodecahome 20.9052
include <dodecahome_config.scad>

include <pentagon_plate.scad>
include <connector_pentagon_plate.scad>
include <fan_pentagon_plate.scad>
include <wheel_plate.scad>
include <custom_plate.scad>

//include <mp_vc_flat.scad>

include <core_platform.scad>
// include <atx_compliance.scad>
//include <vertex_composite.scad>
//include <penta_composite.scad>

//if (true)
//{
//rotate([0, 90+magic_angle, 90])
//translate([-0.5-atx_board_depth , -atx_board_height/2, -16])
//{
//ATXMotherboardMount();
//rotate([0, -90, 0]) ATXSpecification();
//}

//
// TODO: How to mount the PSU to the base?
// rotate([0, 0, 360/6])
//translate([-7, -7, -16.9118+0.5])
//color([.0, 0.5, 1.0, .5])
//PSUVolume();
//}

rotate([-magic_angle, 0, 0])
{
for (i = [0 : len(pos)-1]) {
    //if(face_groups[i] == 3) // face_groups[i] == 2
    if (meta_groups[i] == 1) // Mortality escape pod
    //if (meta_groups[i] == 1 || face_groups[i] == 1) // Mothership
    {
    translate(pos[i]*panel_edge_length) rotate(rots[i]) rotate([0, 0, panel_rots[i]])
    if (!render_fast_iter)
    {        
        if (i == 1)
        {
        // CustomPentagonPlate
            PentagonPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, vents[i], "sorceress_vent.svg");
        }
        else if (i == 4 || i == 11 || i == 9)
        {
            WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, vents[i], unique_panel_colors[i%len(unique_panel_colors)], true, true);
        } else if (i == 5)
        {
            FanPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, vents[i], unique_panel_colors[i%len(unique_panel_colors)], 36);
        } else if (i == 7)
        {
            FanPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, vents[i], unique_panel_colors[i%len(unique_panel_colors)]);
        }
        else
        {
            color(unique_panel_colors[i%len(unique_panel_colors)])
            ConnectorPentagonPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, vents[i], unique_panel_colors[i%len(unique_panel_colors)]);
        }
    }
    else
    {
        if (i == 4 || i == 11 || i == 9)
        {
            // WheelMountPrefab
            WheelPanelPrefab(36, panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, false);
        } else
        {
        
            PentagonPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, vents[i], [0.0, 1.0, 1.0, 0.1]);
        }
    }
    }
    }
}
//
//import("baby_platform.stl");
//import("mother_platform_full.stl");
//import("mother_platform_front.stl");

//import("mothership_connectors.stl");
//import ("escape_pod_connectors.stl");