include <nutsnbolts/cyl_head_bolt.scad>

difference() {
	translate([-15, -15, 0]) cube([80, 30, 50]);
	rotate([180,0,0]) nutcatch_parallel("M5", clh=0.1);
	translate([0, 0, 50]) hole_through(name="M5", l=50+5, cld=0.1, h=10, hcld=0.4);
	translate([55, 0, 9]) nutcatch_sidecut("M8", l=100, clk=0.1, clh=0.1, clsl=0.1);
}