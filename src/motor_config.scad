include <gearmotor.scad>
include <gearmotor_mount.scad>
include <cradle_brace.scad>

// TODO: We need to calculate what this precise value should be based on the belt
top_plane_z = 70;

translate([0, 22
, top_plane_z])
scale(10)
rotate([0, 180, 0])
{
//NeoMotorAttachment();
translate([0, -1.4, 0])  scale(0.1) rotate([-90, 180, 0]) 
{
//GearmotorCage();
//Gearmotor37D();
}
}

difference()
{
slice_above_p(height = top_plane_z, axis = "Y") {
MotorMountBaseVertexStructure();
}
union()
{
MotorPlatInserts();
MotorPlatScrewHoles();
}
}

