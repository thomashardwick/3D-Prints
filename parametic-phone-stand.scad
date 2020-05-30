
/* [Dimensions] */
// Thickness of the stand parts thicker is stronger but increases print itme.
t = 2.5;
// Overall width of the stand. Adjust for your phone.
w = 60;
// Depth of the stand base. Stops the sand toppling backwards.
d = 75;
// Overall Height of the stand. May want increasing for phablets.
h = 130;
// Height of the phone support fingers from the base
sup = 45;
// Width of the gap between the phone support fingers.
gap = 20;
// Depth of the phone support fingers. Adjust for your phone + case
sd = 16;
// Height of the phone supprt fingers up the phone front.
sh = 5;

sw = (w - gap) / 2;

sheer = 0.5;

sheerMatrix1 = [
    [1, 0, 0, 0],
    [0, 1, sheer, 0, 0],
    [0, 0, 1, 0]
    ];
    
sheerMatrix2 = [
    [1, 0, 0, 0],
    [0, 1, -sheer, 0, 0],
    [0, 0, 1, 0]
    ];
    
union() {
    // The bottom
    translate([0, t, 0]) cube([w, d - 2*t, t]);
    
    multmatrix(m = sheerMatrix1) union() {
        // The back
        cube([w, t, h]);
        // Left finger top
        translate([0, -sd, sup]) cube([sw, t, sh]);
        // Right finger top
        translate([w, -sd, sup]) mirror([1,0,0]) cube([sw, t, sh]);
    }
    multmatrix(m = sheerMatrix2) union() {
        
        // The support 
        translate([0, d - t, 0]) cube([w, t, d - t]);
        // Left finger bottom
        translate([0, sup - sd, sup - sd]) cube([sw, t, sd]);
        // Right finger bottom
        translate([w, sup - sd, sup - sd]) mirror([1,0,0]) cube([sw, t, sd]);
    }
}