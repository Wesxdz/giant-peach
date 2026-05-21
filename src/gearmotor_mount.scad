include <din_rail_ts35.scad>
use <gearmotor.scad>
include <nutsnbolts/cyl_head_bolt.scad>

$fn=36;

attachment_len = slot_pitch*3;
motor_secure_len = 60;
motor_secure_cut_len = 3;

din_under_width = slot_width-2;
und_dis = 2.0;

clamp_dist = 3.4;
clamp_len = 3.0;

// M3 with brass inserts pulled tight against it...
module ModularDINEntry()
{
for(i = [0:2])
{
translate([-3.4-i*0.75, 0, 0])
{
cylinder(und_dis, m3_rad, m3_rad);
BrassInsert();
}
}
}

// M5 bolts designed to hang down further...
module M5DINEntry()
{
for(i = [0:1])
{
translate([-3.6-i*1.2, 0, 0])
{
union()
{
cylinder(und_dis, 0.25+0.01, 0.25+0.01);
rotate([0, 0, 90])
translate([0, 0, .4+.8])
//scale(0.1) nut("M5");
scale(0.1) nutcatch_sidecut("M5", l=100, clk=0.1, clh=0.1, clsl=0.1);
}
}
}
}

module MotorAttachment()
{
//// DIN rail underside displacement 

difference()
{

union()
{
translate([-attachment_len/10/2, -din_under_width/2, 0])
cube([attachment_len/10, din_under_width, und_dis]);

// mid region
translate([-motor_secure_len/10/2, -din_under_width/2, -und_dis])
cube([motor_secure_len/10, din_under_width, und_dis]);

// bottom-most clamp
translate([-clamp_len/2, -din_under_width/2, -3.4])
cube([clamp_len, din_under_width, und_dis]);
}

// TODO: Two sidescrews form the clamp

translate([-motor_secure_cut_len/10/2, -din_under_width /2, -clamp_dist])
cube([motor_secure_cut_len/10, din_under_width , clamp_dist]);

M5DINEntry();
mirror([1, 0, 0]) M5DINEntry();
//ModularDINEntry();
//mirror([1, 0, 0]) ModularDINEntry();

translate([0, 1.5, 0])
rotate([90, 180, 0]) scale(0.1) Gearmotor37D();

}
}

module MotorSecureScrew()
{
    translate([clamp_len/2, 0, -3])
    rotate([0, -90, 0])
    {
    cylinder(10, m3_rad, m3_rad);
    BrassInsert();
    }
}
//translate([0, 1.5, -3])


module GearmotorHookup()
{
scale(10)
translate([0, 0, -und_dis])
difference()
{
MotorAttachment();

translate([0, -din_under_width/3, 0])
MotorSecureScrew();

translate([0, din_under_width/3, 0])
MotorSecureScrew();

}



//translate([0, 15, -und_dis*10])
//rotate([90, 180, 0]) Gearmotor37D();
}

// TODO: OpenSSCAD needs namespaces...
module UndersideBearingPassthrough()
{
    rotate([0, 180, 0])
    {
    cylinder(15, m3_rad, m3_rad);
    BrassInsert();
    }
}

module NeoMotorAttachment()
{
//// DIN rail underside displacement 
screw_offset = [-motor_secure_len/10/2-0.5+0.75, 2.4, und_dis];
difference()
{

union()
{

translate([-motor_secure_len/10/2-0.5, -din_under_width, 0.5])
cube([1.5, din_under_width*2, 1.5]);

mirror([1, 0, 0])
translate([-motor_secure_len/10/2-0.5, -din_under_width, 0.5])
cube([1.5, din_under_width*2, 1.5]);

translate([-motor_secure_len/10/2, -din_under_width/2, 0])
cube([motor_secure_len/10, din_under_width, und_dis]);

// mid region
translate([-motor_secure_len/10/2, -din_under_width/2, -und_dis])
cube([motor_secure_len/10, din_under_width, und_dis]);

// bottom-most clamp
translate([-clamp_len/2, -din_under_width/2, -3.4])
cube([clamp_len, din_under_width, und_dis]);
}

// TODO: Two sidescrews form the clamp

translate([-motor_secure_cut_len/10/2, -din_under_width /2, -clamp_dist])
cube([motor_secure_cut_len/10, din_under_width , clamp_dist]);

//M5DINEntry();
//mirror([1, 0, 0]) M5DINEntry();
//ModularDINEntry();
//mirror([1, 0, 0]) ModularDINEntry();

translate([0, 1.5, 0])
rotate([90, 180, 0]) scale(0.1) Gearmotor37D();



translate(screw_offset)
UndersideBearingPassthrough();

mirror([1, 0, 0])
translate(screw_offset) 
UndersideBearingPassthrough();

mirror([0, 1, 0])
translate(screw_offset) 
UndersideBearingPassthrough();

mirror([1, 0, 0])
mirror([0, 1, 0])
translate(screw_offset) 
UndersideBearingPassthrough();


}
}
//
//scale(10)
//rotate([0, 180, 0])
//NeoMotorAttachment();

//rotate([90, 0, 0])
//GearmotorHookup();