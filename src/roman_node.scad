module RomanNode()
{
    $fn=36;
    translate([0, 0, -3])
    scale(3.0)
    rotate([0, 180, 0])
    hull()
    {
    sphere(1.0);
    translate([0, 0, -1.0]) cylinder(1, 0.5, 0.5);
    }
}

module Sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module PlatformSection(radius, angles, fn)
{
    linear_extrude(24)
    Sector(radius, angles, fn);
}

module PiSections(slices)
{
    union()
    {
    if (slices[0])
    {
        color([0.5, 0.0, 1.0, 0.5])
        PlatformSection(12, [30, 150], 24);
    }
    if (slices[1])
    {
        color([1.0, 0.5, 1.0, 0.5])
        PlatformSection(12, [150, 270], 24);
    }
    if (slices[2])
    {
        color([1.0, 0.0, 0.0, 0.5])
        PlatformSection(12, [30, -90], 24);
    }
    }
}

module RomanNotch(sections=[1, 1, 1])
{
    intersection()
    {
        translate([0, 0, -15.5])
        PiSections(sections);
        RomanNode();
    }
}

//RomanNode();