include <params.scad>

tol_anchor_small_diam   = anchor_small_diam*(1-tolerance);
tol_anchor_small_height = anchor_small_height*(1+tolerance);
tol_anchor_big_diam     = anchor_big_diam*(1-tolerance);
tol_anchor_big_height   = anchor_big_height*(1-tolerance);

anchor_total_height = tol_anchor_small_height + tol_anchor_big_height;



module anchor() {
    difference() {
        union() {
            cylinder(d=tol_anchor_small_diam
                    ,h=anchor_total_height
                    ,center=false);
            translate([0, 0, tol_anchor_small_height]) {
                cylinder(d=tol_anchor_big_diam
                        ,h=tol_anchor_big_height
                        ,center=false);
            }
        }
        union(){
            cylinder(d=anchor_hole_diam, h=anchor_total_height*3, center=true);
            translate([0, 0, anchor_total_height-countersink_height]) {
                cylinder(d1=anchor_hole_diam
                        ,d2=countersink_big_diam+0.01
                        ,h=countersink_height+0.01, center = false);
            }
        }
    }
}

anchor();

echo(str("Anchor total height = ", anchor_total_height));
echo(str("Anchor wall_thickness = ", (tol_anchor_small_diam - anchor_hole_diam)/2));