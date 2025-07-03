include <connector_pentagon_plate.scad>

module RightHatch()
{
union()
{

intersection()
{
    ConnectorPentagonPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, true, [1, 0.5, 0, 1]);
    translate([-panel_radius, 0, 0]) cube([panel_radius*2, panel_radius, panel_radius]);
}

intersection()
{
    ConnectorPentagonPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, false, [1, 0.5, 0, 1]);
    translate([-panel_radius, 0, 0]) cube([panel_radius*2, border_edge/2, panel_radius]);
    }
}

}

module LeftHatch()
{
    mirror([0, 1 ,0]) RightHatch();
}

//LeftHatch();
//RightHatch();