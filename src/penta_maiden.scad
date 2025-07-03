include <pentagon_plate.scad>
include <roman_node.scad>

module PanelSubConnectors(array=[1, 1, 1, 1, 1], notch_secure=[0, 0, 0, 0, 0], vertex_cutoff=0.0, clearance_scale=1.0)
{
for (i = [0:5])
{
if (array[i])
{
rotate([0, 0, 72*i]) translate([inner_panel_radius, 0, 0]) rotate([0, -tetra_a, 0]) rotate([0, 0, 180+30]) scale(clearance_scale) RomanNotch([0, 0, 1]);
}
}
}

//PanelSubConnectors();