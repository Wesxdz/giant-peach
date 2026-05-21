// The purpose of this file is to unify visual design of the Cradle panel belt passthrough region in holonomic_mount_panel.scad with the brace mount vertical position of the rods (cradle_brace.scad) with the DIN rail mount vertical positon of the gearmotor (din_mounts.scad)

//include <holonomic_mount_panel.scad>
//CradleHolonomicCutoutPanel();

rotate([0, 0, 60]) import("brace_composite.stl");

// TODO: We should include the belt as originating from the brace rod object and the motor connector on the underside of the DIN rail

//rotate([0, 0, 60])
//scale(.1) import("din_mounts.stl");
//
//include <cradle_brace.scad>
//VertexConnectorBrace(false);
//include <vertex_composite.scad>

//PanelSubConnectorsCradle();