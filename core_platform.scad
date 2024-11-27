include <nutsnbolts/cyl_head_bolt.scad>

module PSUVolume()
{
    cube([15.0, 14.0, 8.6]);
}

module GTX1660SUPER()
{
    cube([22.9, 11.1, 3.5]);
}

module ATXMotherboardVolume()
{
    // cube([4.0, 24.4, 30.5]);
    cube([4.0, 24.384, 30.5]);
}

module hexagon(apothem) {
    num_sides = 6;
    side_length = 2 * apothem * tan(180 / num_sides);
    radius = apothem / cos(180 / num_sides);

    points = [
        for (i = [0 : num_sides - 1])
            [radius * cos(360 * i / num_sides), radius * sin(360 * i / num_sides)]
    ];

    polygon(points);
}

module pentagon(apothem, color) {
    num_sides = 5;
    side_length = 2 * apothem * tan(180 / num_sides);
    radius = apothem / cos(180 / num_sides);

    points = [
        for (i = [0 : num_sides - 1])
            [radius * cos(360 * i / num_sides), radius * sin(360 * i / num_sides)]
    ];

    color(color)
        polygon(points);
}