// ATX Version 3 Multi Rail Desktop Platform Power Supply Design

module PSUSpec()
{
    unc_2b_radius = 0.3505/2;

    cube([15.0, 14.0, 8.6]); 
    difference()
    {
    translate([0, -1, 0]) cube([15.0, 1.0, 8.6]);
    // No. 6-32 UNC-2B THREADED HOLE
    union()
    {
    $fn = 36;
    rotate([90, 0, 0]) translate([0.6, 1.6, 0]) cylinder(1.0, unc_2b_radius, unc_2b_radius);
    rotate([90, 0, 0]) translate([0.6, 1.6+6.4, 0]) cylinder(1.0, unc_2b_radius, unc_2b_radius);

    rotate([90, 0, 0]) translate([0.6+11.4, 0.6, 0]) cylinder(1.0, unc_2b_radius, unc_2b_radius);
    rotate([90, 0, 0]) translate([0.6+13.8, 1.6+6.4, 0]) cylinder(1.0, unc_2b_radius, unc_2b_radius);

    translate([1.2, -1, 1.2]) cube([15.0-2.4, 1.0, 8.6-2.4]);
    }
    }
    
    // IEC C14 receptacle
    color([1.0, 0.0, 0.0, 0.5])
    translate([9.4, -2, 2.2])
    cube([3, 3, 2]);
    
    // Wire harness
    $fn = 36;
    color([1.0, 0.3, 0.1, 0.5])
    translate([15.0-1.6, 14.0+2, 8.6-5.3])
    rotate([90, 0, 0]) cylinder(2, 1, 1);
    
}

//PSUSpec();