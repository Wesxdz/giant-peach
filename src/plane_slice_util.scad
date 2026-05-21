module slice_above_p(height = 0, size = 1000, axis = "Z") {
    difference() {
        children();
        
        if (axis == "Z" || axis == "z") {
            translate([-size/2, -size/2, height])
                cube([size, size, size]);
        } else if (axis == "Y" || axis == "y") {
            translate([-size/2, height, -size/2])
                cube([size, size, size]);
        } else if (axis == "X" || axis == "x") {
            translate([height, -size/2, -size/2])
                cube([size, size, size]);
        }
    }
}
// Usage:
//slice_above_p(height = 20) {
//    sphere(r = 50);
//}