include <dodecahedroid_config.scad>
include <pentagon_plate.scad>

// The TPU parts should probably be exterior (or near the surface) to minimize fold distance *unless* stretching by default is okay/wanted to create default-right force?

test_radius = 5;
PentagonPlate(test_radius, 2, 2, panel_thickness, border_edge, false);

rotate([0, 0, 36])
translate([test_radius*1.618, 0, 0])
PentagonPlate(test_radius, 2, 2, panel_thickness, border_edge, false);