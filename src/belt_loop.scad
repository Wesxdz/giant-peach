// (pitch_len is permiter)
module BeltLoop(pitch_len =20.0, belt_width=0.6, start_loop_rad=0.6, end_loop_rad=0.6)
{
    $fn=32;
    loop_length = ( pitch_len -(PI*(start_loop_rad+end_loop_rad)) )/2;
    linear_extrude(belt_width)
    {
        difference()
        {
            hull()
            {

                circle(start_loop_rad);
                translate([loop_length, 0, 0]) circle(end_loop_rad);
            }
            hull()
            {

                circle(start_loop_rad-0.1);
                translate([loop_length, 0, 0]) circle(end_loop_rad-0.1);
            }
        }
    }
}

BeltLoop();