include <dodecahome_config.scad>
include <penta_connector.scad>

include <dodecahedron_inner_volume.scad>

mothership_connectors = [
[0, 0, 0, 0, 0],
[0, 0, 0, 0, 0],
[0, 0, 0, 0, 0],
[1, 0, 0, 0, 1], // Front right panel thumbscrews
[1, 1, 1, 1, 1],
[1, 1, 1, 1, 1],
[1, 1, 1, 1, 1],
[1, 1, 1, 1, 1],
[0, 0, 0, 1, 1], // Back panel thumbscrews
[1, 1, 1, 1, 1],
[0, 0, 1, 1, 0], // Front left panel thumbscrew
[1, 1, 1, 1, 1],
];

mortality_escape_pod_connectors = [
[1, 1, 1, 1, 1],
[1, 1, 1, 1, 1],
[1, 1, 1, 1, 1],
[0, 1, 1, 1, 0],
[0, 0, 0, 0, 0],
[0, 0, 0, 0, 0],
[0, 0, 0, 0, 0],
[0, 0, 0, 0, 0],
[1, 1, 1, 0, 0],
[0, 0, 0, 0, 0],
[1, 1, 0, 0, 1],
[0, 0, 0, 0, 0],
];

notch_security =
[
[0, 0, 0, 0, 0],
[0, 0, 0, 0, 0],
[0, 0, 0, 0, 0],
[0, 1, 0, 0, 1],
[0, 0, 0, 0, 0],
[0, 0, 1, 1, 0],
[1, 0, 1, 0, 0],
[1, 1, 0, 0, 0],
[0, 0, 0, 0, 0],
[1, 1, 0, 0, 0],
[0, 1, 0, 1, 0],
[0, 0, 0, 0, 0],
];

full_connectors = [1, 1, 1, 1, 1];

module PentaVolume()        
{
standard_panel_rots = [36, -36*4.5, 0, 18, 36, -18, 18, -18, 18, 36+18, 18, 0];

union()
rotate([-magic_angle, 0, 0])
{
for (i = [0 : len(pos)-1]) 
{
translate(pos[i]*inner_panel_edge_length) rotate(rots[i]) rotate([0, 0, standard_panel_rots [i]]) 
    {
//    if (face_groups [i] == 2 || face_groups [i] == 3)
    //import("penta_mothership_dock.stl");
    //PanelSubConnectors(full_connectors, notch_security[i]);
    PanelSubConnectors(mothership_connectors[i], notch_security[i]);
    }
}
}
}

module PlatformPentaDocks(clearance=0.0)        
{
standard_panel_rots = [36, -36*4.5, 0, 18, 36, -18, 18, -18, 18, 36+18, 18, 0];
intersection()
{
union()
rotate([-magic_angle, 0, 0])
{
for (i = [0 : len(pos)-1]) 
{
translate(pos[i]*inner_panel_edge_length) rotate(rots[i]) rotate([0, 0, standard_panel_rots [i]]) 
    {
    PanelSubConnectorsDocks(full_connectors, clearance);
    }
}
}
translate([0, 0, -8]) cube([50, 50, 12], center=true);
}
}

module PlatformPentaDockHoles()        
{
standard_panel_rots = [36, -36*4.5, 0, 18, 36, -18, 18, -18, 18, 36+18, 18, 0];
intersection()
{
union()
rotate([-magic_angle, 0, 0])
{
for (i = [0 : len(pos)-1]) 
{
translate(pos[i]*inner_panel_edge_length) rotate(rots[i]) rotate([0, 0, standard_panel_rots [i]]) 
    {
    PanelSubConnectorsDockHoles(full_connectors);
    }
}
}
translate([0, 0, -8]) cube([50, 50, 12], center=true);
}
}


module PlatformPentaVolume(clearance_scale = 1.0)       
{
standard_panel_rots = [36, -36*4.5, 0, 18, 36, -18, 18, -18, 18, 36+18, 18, 0];
intersection()
{
union()
rotate([-magic_angle, 0, 0])
{
for (i = [0 : len(pos)-1]) 
{
translate(pos[i]*inner_panel_edge_length) rotate(rots[i]) rotate([0, 0, standard_panel_rots [i]]) 
    {
    // scale here to prevent nonsolid planar stl explort artifacts
    // mother_platform.scad has this module as a dependency
    // if you modify the vertex cutoff of the module below
    // you will invalidate the design of the mother platform
    scale(1.00001) PanelSubConnectors(full_connectors, notch_security[i], 0.0, clearance_scale);
    difference()
    {
    //PanelSubConnectors(full_connectors, notch_security[i], 0.5, false, false, clearance_scale);
    //PanelSubConnectorsDockHoles();
    }
    }
}
}
translate([0, 0, -8]) cube([50, 50, 12], center=true);
}
}

//PentaVolume();
export_platform_connectors = false;
if (export_platform_connectors)
{
intersection()
{
PlatformPentaVolume();
// Just the six platform connectors
translate([0, 0, -8]) cube([50, 50, 12], center=true);
}
}

preview_docks = false;
if (preview_docks)
{
difference()
{
PlatformPentaDocks();
PlatformPentaDockHoles();
}
}

//PentaVolume();

//PlatformPentaVolume();

//color([0.5, 0.5, 0.5, 0.5])
//scale(interior_scale) DodecahedronSlice();