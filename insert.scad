include <params.scad>


tol_soap_length = soap_length * (1-tolerance);
tol_soap_width = soap_width * (1-tolerance);

module hexagon_grid(rows, columns, size, height) {
    union(){
        for (i = [0:rows - 1])
            for (j = [0:columns - 1])
                translate([3/2 * (size+mesh_hole_margin) * j
                          ,sqrt(3) * (size+mesh_hole_margin) * i + (j % 2) * sqrt(3)/2 * (size+mesh_hole_margin)
                          ,0]){
                    cylinder(h = height, r = size, $fn = 6);
                }
    }
}


union(){
    difference() {
        cube(size=[tol_soap_length, tol_soap_width, mesh_thickness], center=false);
        translate([mesh_hole_size+mesh_hole_margin+mesh_line_size*0.8, -mesh_hole_size+mesh_hole_margin, -0.1]) {
            hexagon_grid(ceil(tol_soap_width/(2*mesh_hole_size)+2), ceil(tol_soap_length/(2*mesh_hole_size)+2), mesh_hole_size, mesh_thickness+0.2);
        }
    }
    difference() {
        cube(size=[tol_soap_length, tol_soap_width, mesh_thickness], center=false);
        translate([mesh_line_size, mesh_line_size, -0.1]) {
            cube(size=[tol_soap_length-2*mesh_line_size, tol_soap_width-2*mesh_line_size, mesh_thickness+0.2], center=false);
        }
    }
}