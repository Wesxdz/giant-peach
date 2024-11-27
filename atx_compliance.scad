atx_board_depth = 0.157;
atx_board_height = 24.384;
atx_board_length = 30.48;

module ATXSpecification()
{
IO_aperature_length = 6.250 * 2.54;
IO_aperature_height = .483 * 2.54;
IO_aperature_depth = 1.750 * 2.54;

// Area A
area_A_length = 30.48-14.732;
area_A_height = 16.51;
area_A_depth = 7.62;

area_A2_length = 19.05-14.732;
area_A2_height = 19.05;
area_A2_depth = 7.62;

// Area B (Card Slot Area)
// PCIe/GPU
area_B_length = 14.732;
area_B_height = 24.384;
area_B_depth = 15.0;
// area_B_depth = 1.524;

// Area C
area_C_length = 30.48-14.732; // 7.5 cm (75 mm)
area_C_height = 24.384-16.51; // 190.5 mm converted to cm
area_C_depth = 3.81;

// ATX board with color and transparency
color([0.8, 0.8, 0.8, 0.5]) // Light gray, 50% transparent
translate([0, 0, -atx_board_depth])
cube([atx_board_length, atx_board_height, atx_board_depth]);

// Area B (main card slot) with color and transparency
color([1, 0, 0, 0.5]) // Red, 50% transparent
translate([0, 0, 0])
cube([area_B_length, area_B_height, area_B_depth]);

// Area A with color and transparency
color([0, 1, 0, 0.5]) // Green, 50% transparent
union()
{
translate([area_B_length, (atx_board_height - area_A_height), 0])
cube([area_A_length, area_A_height, area_A_depth]);
translate([area_B_length, (atx_board_height - area_A2_height), 0])
cube([area_A2_length, area_A2_height, area_A2_depth]);
}

// Area C with color and transparency
color([0, 0, 1, 0.5]) // Blue, 50% transparent
translate([area_B_length, 0, 0])
cube([area_C_length, area_C_height, area_C_depth]);

translate([(5.196 + 0.65) * 2.54, atx_board_height-IO_aperature_height, 0])
cube([IO_aperature_length, IO_aperature_height, IO_aperature_depth]);

}

module ATXPowerPassthrough()
{
    $fn = 128;
    // This one overlaps the board a bit because it's near the edge
    translate([atx_board_length+1+0.5, atx_board_height-5, 4]) rotate([0, 180, 0]) cylinder(10, 1.75, 1.75); // E ATX 12V x2 (CPU power)
    translate([3+16, -2-0.5, 4]) rotate([0, 180, 0]) cylinder(10, 2, 2); // E ATX PWR
    gpu_pwr_rad = 1.25;
    translate([-gpu_pwr_rad-0.5, gpu_pwr_rad+0.5, 4]) rotate([0, 180, 0]) cylinder(10, gpu_pwr_rad, gpu_pwr_rad); // GPU PWR
}

module MMountSurface()
{
    $fn=64;
    rotate([0, 90, 0]) cylinder(0.8, .6, .8);
};

module MMountCave()
{
    $fn=64;
    rotate([0, 90, 0])  BrassInsert();
    rotate([0, 90, 0]) cylinder(30, (0.3+screw_clearance)/2, (0.3+screw_clearance)/2);
};

module ATXMotherboardMountCave()
{
    
    // A (above IO shield)
    
    // from short side
    top = 0.6 * 2.54;
    mid = top + 4.9 * 2.54;
    bottom = top + 11.1 * 2.54;
    
    // from long side
    layer_zero = atx_board_height-1.016;
    layer_one = atx_board_height-2.286;
    layer_two = atx_board_height-15.494;
    layer_three = atx_board_height-22.733;
    
    // A
    translate([0, layer_zero, top]) MMountCave();
    
    // B
    translate([0, layer_zero, top + 3.1 * 2.54]) MMountCave();
    
    translate([0, layer_zero, mid]) MMountCave();
    
    translate([0, layer_one, bottom]) MMountCave();
    
    
    translate([0, layer_two, top]) MMountCave();
    
    translate([0, layer_two, mid]) MMountCave();
    
    translate([0, layer_two, bottom]) MMountCave();
    
    
    translate([0, layer_three, top]) MMountCave();
    
    translate([0, layer_three, mid]) MMountCave();
    
    translate([0, layer_three, bottom]) MMountCave();
}

module ATXMotherboardMountSurface()
{
    
    // A (above IO shield)
    
    // from short side
    top = 0.6 * 2.54;
    mid = top + 4.9 * 2.54;
    bottom = top + 11.1 * 2.54;
    
    // from long side
    layer_zero = atx_board_height-1.016;
    layer_one = atx_board_height-2.286;
    layer_two = atx_board_height-15.494;
    layer_three = atx_board_height-22.733;
    
    // A
    translate([0, layer_zero, top]) MMountSurface();
    
    // B
    translate([0, layer_zero, top + 3.1 * 2.54]) MMountSurface();
    
    translate([0, layer_zero, mid]) MMountSurface();
    
    translate([0, layer_one, bottom]) MMountSurface();
    
    
    translate([0, layer_two, top]) MMountSurface();
    
    translate([0, layer_two, mid]) MMountSurface();
    
    translate([0, layer_two, bottom]) MMountSurface();
    
    
    translate([0, layer_three, top]) MMountSurface();
    
    translate([0, layer_three, mid]) MMountSurface();
    
    translate([0, layer_three, bottom]) MMountSurface();
}

// ATX Specification Version 2.2
module ATXMotherboardMount() {
    // Constants for distances (in mm)
    atx_board_height = 24.4 * 2.54; // Adjust this to your board height
    top = 0.6 * 2.54;
    mid = top + 4.9 * 2.54;
    bottom = top + 11.1 * 2.54;

    // Screw positions along the layers
    layers = [
        atx_board_height - 1.016,
        atx_board_height - 2.286,
        atx_board_height - 15.494,
        atx_board_height - 22.733
    ];
    positions = [top, mid, bottom];

    // Loop over layers and positions to place screws
    for (i = [0 : len(layers) - 1]) {
        for (j = [0 : len(positions) - 1]) {
            translate([0, layers[i], positions[j]])
                rotate([0, 90, 0]) cylinder(30, (0.3+screw_clearance)/2, (0.3+screw_clearance)/2);
        }
    }
}

// IO shield overhang/GPU support slit
module AtxSupportSlit()
{
    io_shield_length = 6.25*2.4;
    gap = 0.0;
    // We don't include the IO slot because it should fit within the standoffs
    //translate([atx_board_length-io_shield_length, atx_board_height, -2.5]) cube([io_shield_length, 0.3, 5.0]);
    translate([0, atx_board_height, -2.5]) cube([atx_board_length-gap-io_shield_length, 0.3, 5.0]);
    //translate([0, atx_board_height, -2.5]) cube([atx_board_length, 0.3, 5.0]);
}

//ATXSpecification();
//ATXPowerPassthrough();
