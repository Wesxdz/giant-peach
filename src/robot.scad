include <atx_compliance.scad>

// https://developer.nvidia.com/blog/develop-ai-powered-robots-smart-vision-systems-and-more-with-nvidia-jetson-orin-nano-developer-kit/

module JetsonOrinNano()
{
    cube([10, 7.9, 2.1]);
}

ATXSpecification();

translate([0, -12, 0]) 
JetsonOrinNano();