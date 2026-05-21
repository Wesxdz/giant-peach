include <din_rail_ts35.scad>
include <gearmotor_mount.scad>

module MotorRail()
{
TS35_DIN_Rail();
translate([0, 0, length_in_cm*10/2])
rotate([-90, 270, 0])
GearmotorHookup();
}

MotorRail();