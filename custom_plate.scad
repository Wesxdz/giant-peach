include <connector_pentagon_plate.scad>

// Cuts an SVG into a connector panel
module CustomPentagonPlate(radius, cell_size, wall_thickness, thickness, border_edge, vent=false, svg_name, scale_factor = 0.08)
{
difference()
{
  ConnectorPentagonPlate(radius, cell_size, wall_thickness, thickness, border_edge, vent);
   linear_extrude(10) scale(scale_factor) offset(delta=0.01) rotate([0, 0, -18]) import(svg_name, $fn = 10, center=true);
   }
}


//CustomPentagonPlate(panel_radius, cell_size, wall_thickness, panel_thickness, border_edge, false, "svg/sorceress_vent.svg");