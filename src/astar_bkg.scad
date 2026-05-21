
// https://www.pololu.com/product/3113/resources
// https://www.pololu.com/file/0J1145/a-star-32u4-prime-sv-dimension-diagram.pdf

$fn=32;

board_width = 68.6;
board_height = 53.3;

difference()
{
cube([board_width, board_height, 1.57+4]);

secure_pos = [[14, 2.5, 0], [14, board_height-2.5, 0], [board_width-2.5, 7.9, 0], [board_width-2.5, 7.9+27.9, 0]];
for (i = [0:3])
{
    translate(secure_pos[i])
    cylinder(1.57+4, 3.2/2, 3.2/2);
}
}