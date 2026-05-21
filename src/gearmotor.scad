// Pololu 37D mm Metal Gearmotor
// Offset shaft: 7.0mm from center

$fn = 60;
use <pulleys.scad>
include <nutsnbolts/cyl_head_bolt.scad>


include <dodecahedroid_config.scad>

// --- Dimensions from Diagram ---
motor_dia = 34.8;             // [cite: 5, 43, 90]
motor_length = 30.7;          // [cite: 17, 53, 101]
gearbox_dia = 36.8;           // [cite: 8, 57]
gearbox_L = 21.5;             // For 19:1 or 30:1 ratios [cite: 11, 49]
encoder_dia = 34.0;           // [cite: 72, 104]
encoder_length = 15.4;        // [cite: 71, 102]
boss_dia = 12.0;              // [cite: 21, 58]
boss_height = 6.0;            // [cite: 22, 59]

// Shaft & Offset
shaft_offset = 7.0;           // Offset from center 
shaft_dia = 6.0;              // [cite: 20, 56]
shaft_length = 22.0;          // [cite: 15, 51]
shaft_flat_depth = 0.6;       // 6.0mm dia - 5.4mm at flat [cite: 14, 50]
shaft_flat_length = 12.0;     // [cite: 21, 58]

// Mounting & Wires
mounting_bc = 31.0;           // 
wire_length = 200;            // [cite: 64, 96]

module Gearmotor37D() {

    // Encoder Housing
    color("Black")
    translate([0, 0, -encoder_length])
    cylinder(h = encoder_length, d = encoder_dia);

    // Motor Body
    color("Silver")
    cylinder(h = motor_length, d = motor_dia);
    
    // Gearbox with 6x M3 Holes
    translate([0, 0, motor_length])
    color("DimGray")
    difference() {
        cylinder(h = gearbox_L, d = gearbox_dia);
        
        // 6x M3 Threaded Holes on 31mm Bolt Circle [cite: 3, 10, 44, 55]
        for (a = [0:60:359]) {
            rotate([0, 0, a])
            translate([mounting_bc / 2, 0, gearbox_L - 3.0])
            cylinder(h = 3.1, d = 3); // Max depth 3.0mm 
        }
    }
    
    // Offset Boss (7.0mm from center)
    translate([0, shaft_offset, motor_length + gearbox_L])
    color("Silver")
    cylinder(h = boss_height, d = boss_dia);
    
    // Offset D-Shaft
    translate([0, shaft_offset, motor_length + gearbox_L + boss_height])
    color("LightGrey")
    difference() {
        cylinder(h = shaft_length, d = shaft_dia);
        // Flat section: 12mm long, reducing dia to 5.4mm [cite: 14, 50]
        translate([-shaft_dia/2, shaft_dia/2 - shaft_flat_depth, shaft_length - shaft_flat_length])
        cube([shaft_dia, shaft_dia, shaft_flat_length + 0.1]);
    }
    translate([0, shaft_offset, motor_length + gearbox_L + boss_height + 4]) DirectGearmotorPulley();
}

//Gearmotor37D();

clamp_dia = motor_dia + 16;
plat_width = clamp_dia + 12;

module MotorPlatInserts()
{
translate([0, 8, 0])
translate([0, 0, 45])
rotate([-90, 0, 0]) 
{
translate([clamp_dia/4+9, 0, -6])
rotate([-90, 0, 0])
scale(10) BrassInsert();

translate([-(clamp_dia/4+9), 0, -6])
rotate([-90, 0, 0])
scale(10) BrassInsert();

translate([clamp_dia/4+9, 0, motor_dia+6])
rotate([-90, 0, 0])
scale(10) BrassInsert();

translate([-(clamp_dia/4+9), 0, motor_dia+6])
rotate([-90, 0, 0])
scale(10) BrassInsert();
}
}

module MotorPlatScrewHoles()
{
translate([0, 8, 0])
translate([0, 0, 45])
rotate([-90, 0, 0]) 
{
translate([clamp_dia/4+9, 0, -6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);

translate([-(clamp_dia/4+9), 0, -6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);

translate([clamp_dia/4+9, 0, motor_dia+6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);

translate([-(clamp_dia/4+9), 0, motor_dia+6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);
}
}

module GearmotorCage()
{

difference()
{
union()
{



cylinder(motor_dia, clamp_dia/2, clamp_dia/2);
//
translate([0, clamp_dia/4, motor_dia/2])
cube([clamp_dia, clamp_dia/2, motor_dia], true);

hull()
{
translate([0, clamp_dia/4+6, motor_dia/2])
cube([plat_width, clamp_dia/2-12, motor_dia], true);

translate([0, clamp_dia/4+6, motor_dia/2])
cube([clamp_dia, clamp_dia/2-12, motor_dia+28], true);
}

}


translate([clamp_dia/4+9, 0, -6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);

translate([-(clamp_dia/4+9), 0, -6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);

translate([clamp_dia/4+9, 0, motor_dia+6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);

translate([-(clamp_dia/4+9), 0, motor_dia+6])
rotate([-90, 0, 0])
cylinder(40, m3_rad*10, m3_rad*10);


wire_cut_width = 12;
rotate([0, 0, 45])
translate([0, clamp_dia/4+6, motor_dia/2])
cube([wire_cut_width, 6, (motor_dia+28)], true);

motor_secure_gap = 5;
translate([0, -clamp_dia/2, motor_dia/2])
cube([motor_secure_gap, clamp_dia/2, motor_dia], true);


screw_len = 35;    // Total length of the screw clearance cut
m3_head_rad = 3.0;  // Standard M3 cap head radius
m3_head_h = 3.0;    // Standard M3 cap head height

// Top Cut
translate([-screw_len/2, -clamp_dia/2 + (clamp_dia-motor_dia)/4, motor_dia/4]) {
    rotate([0, 90, 0]) {
        // TODO: Replace Brass Inserts with m3 nut hole inserts...
        rotate([0, 90, 0])
        rotate([90, 0, -90])
        translate([0, 0, 6+screw_len/2+6.8])
        nutcatch_sidecut("M3", l=100, clk=0.1, clh=0.1, clsl=0.1);
        // Main screw shaft / clearance hole
        cylinder(screw_len, m3_rad*10, m3_rad*10); 
        // Screw head counterbore
        cylinder(m3_head_h, m3_head_rad, m3_head_rad);
    }
}

// Bottom Cut
translate([-screw_len/2, -clamp_dia/2 + (clamp_dia-motor_dia)/4, motor_dia/4*3]) {
    rotate([0, 90, 0]) {
//        translate([0, 0, screw_len/2+2.5]) scale(10) BrassInsert();
        
        rotate([0, 90, 0])
        rotate([90, 0, -90])
        translate([0, 0, 6+screw_len/2+6.8])
        nutcatch_sidecut("M3", l=100, clk=0.1, clh=0.1, clsl=0.1);
        // Main screw shaft / clearance hole
        cylinder(screw_len, m3_rad*10, m3_rad*10);
        // Screw head counterbore
        cylinder(m3_head_h, m3_head_rad, m3_head_rad);
    }
}

Gearmotor37D();

}
}

//rotate([-90, 180, 0]) 
GearmotorCage();


//translate([-screw_len/2, -clamp_dia/2 + (clamp_dia-motor_dia)/4, motor_dia/4])
