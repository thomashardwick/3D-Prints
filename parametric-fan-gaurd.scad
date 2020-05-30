/* [Dimensions] */
// Height of the fan
height = 4;
// Width of the fan
width = 40;
// Thickness of the grill sides
edgeW = 1;

/* [Gaurd] */
// Number of bars in the fan grill
bladesN = 9;
// How wide each bar is
bladeW = 2;
// How deep each bar is
bladeH = 1;

/* [Screws] */
// How far from the edges are the center of the screw holes
screwInset = 4;
// Diameter of the head of the screw
screwHeadW = 5.75;
// Diameter of the shaft of the screw
screwShaftW = 3;
/* [Fineness]*/
// Number of edges for 'circles'. Decreasing this speeds up rendering but will make screws hard to turn
$fn=128;
// Tollerance for screw sizing to to allow easier turning
screwTol = 0.4;


fScrewHeadW = (screwHeadW + screwTol);
fScrewShaftW = (screwShaftW + screwTol);

screwDepth = (height - fScrewHeadW + fScrewShaftW)/2 - 0.2;

difference () {
    //The frame
    cube([width, width, height], center=true);
    //The area for the fan to draw air
    difference() {
        cylinder(h=height+0.02, d=width-(edgeW*2), center=true);
        //Removing the grill from the hole prevents detached surfaces
        grill();
    }
    //The screw holes
    translate([ (width/2 - screwInset),  (width/2 - screwInset), screwDepth])
        screwHole();
    translate([-(width/2 - screwInset),  (width/2 - screwInset), screwDepth])
        screwHole();
    translate([ (width/2 - screwInset), -(width/2 - screwInset), screwDepth])
        screwHole();
    translate([-(width/2 - screwInset), -(width/2 - screwInset), screwDepth])
        screwHole();
}


module screwHole() {
    screwShaftL = height * 3;
    union() {
        //Outer hole to the screw can be set into the frame
        translate([0,0, -screwShaftL])cylinder(d=fScrewHeadW, h=screwShaftL);
        //Taper for the screw head
        intersection() {
          translate([0,0, -0.01]) cylinder(d1=screwHeadW+screwTol + 0.01, d2=0, h=(fScrewHeadW)/2 + 0.01);
            
            //Add a little to the bottom of the screw head so it attaches properly to the outer hole
          translate([0,0, -screwShaftL/2]) cylinder(d=fScrewHeadW, h=screwShaftL);
        }
        //Hole for the shaft
        cylinder(h=screwShaftL, d=fScrewShaftW);
        
    }
}

module grill() {
    for(i=[1:bladesN]) {
        rotate(a=(360/bladesN)*i, v=[0,0,1])
            grillBar();
    }
}

module grillBar() {
    translate([0, -bladeW/2, -height/2])
        prism(width/2, bladeW, bladeH);
}

module prism(l, w, h){
   polyhedron(
       points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w/2,h], [l,w/2,h]],
       faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
   );
}
