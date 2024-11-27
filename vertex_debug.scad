module vertex_debug()
{
    $fn=32;
    color([1, 0, 1, 0.5])
    translate([0, 0, -2])
    {
    hull()
    {
    sphere(.1);
    translate([0, 0, 4]) sphere(.3);
    }
    }
}

//vertex_debug();