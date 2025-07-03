union() {
    original_radius = 20;  // Original radius of the pentagon
    angle = 10;  // Rotation angle in degrees
    scaled_radius = original_radius * cos(angle * 3.14159 / 180);  // Scale the second pentagon based on the rotation

    // Display the original and scaled radius
    echo("Original Radius: ", original_radius);
    echo("Scaled Radius after ", angle, " degree rotation: ", scaled_radius);

    // Draw the original pentagon
    pentagon(original_radius);  

    // Draw the rotated and scaled pentagon
    rotate([0, 0, angle]) 
        pentagon(scaled_radius);  
}

// Module to draw a pentagon
module pentagon(size) {
    angle = 360 / 5;  // Each interior angle of the pentagon
    points = [
        [size * cos(0), size * sin(0)],
        [size * cos(angle), size * sin(angle)],
        [size * cos(2 * angle), size * sin(2 * angle)],
        [size * cos(3 * angle), size * sin(3 * angle)],
        [size * cos(4 * angle), size * sin(4 * angle)]
    ];
    polygon(points);
}
