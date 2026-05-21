// Aeri Peach 20.9052
include <dodecahedroid_config.scad>

use <pentagon_plate.scad>
use <connector_pentagon_plate.scad>

//rotate([0, -magic_angle*1.5, 0])

rotate([0, 0, 90])
rotate([0, tetra_a, 0])
rotate([0, 0, -30])
union()
{
difference()
{
rotate([-magic_angle, 0, 60])
{
for (i = [0 : 11]) {
    if (true)
    //if(face_groups[i] == 3)
    {
    translate(pos[i]*panel_edge_length) rotate(rots[i]) rotate([0, 0, panel_rots[i]])
    cylinder(panel_thickness, 10, 10);
//    PolycarbonateSupportPanel();
    }
    }
}
}

//rotate([0, 0, 60])
//import ("vertex_composite_uniform.stl");
}