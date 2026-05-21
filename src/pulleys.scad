include <openscad.pulley-generator/pulley-generator.scad>

globalToothWidthTweak = 0.0;
globalToothDepthTweak = 0;

module DirectGearmotorPulley()
{
pulley(
    model           = "GT2 2mm",
// For some reason the HTD and GT2 models are flipped relative to each other
//    model           = "HTD 3mm",
    teethCount      = 20,
    beltWidth       = 6,
    shaftDiameter   = 6,              //
    retainerInfo    = [2,1,1],        
    idlerInfo       = [2,1,1],        
    baseInfo        = [18,8],         // 18mm wide base is plenty for M3 nuts
    nutProfile      = ["hex",3.2,5.5,2.4], // Standard M3 nut
    captiveNuts     = [0,120,1.5],    // 2 nuts is usually sufficient
    toothWidthTweak = 0,
    toothDepthTweak = 0,
    autoFlip        = false 
);
}

module WheelAxisPulley()
{
pulley(
    model           = "GT2 2mm",
    teethCount      = 20,
    beltWidth       = 6,
    shaftDiameter   = 8,              //
    retainerInfo    = [2,1,1],        
    idlerInfo       = [2,1,1],        
    baseInfo        = [18,8],
    nutProfile      = ["hex",3.2,5.5,2.4],
    captiveNuts     = [0,120,1.5],
    autoFlip        = false 
);
}

//DirectGearmotorPulley();