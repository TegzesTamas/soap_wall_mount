include <params.scad>


tol_soap_length = soap_length * (1-bowl_insert_tolerance);
tol_soap_width = soap_width * (1-bowl_insert_tolerance);

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

insert_out_corner_radius = bowl_in_corner_radius * (1-bowl_insert_tolerance);
insert_in_corner_radius = insert_out_corner_radius - mesh_line_size;

union(){
    difference() {
        param_cyl_hull(tol_soap_length, tol_soap_width, insert_out_corner_radius, mesh_thickness);
        translate([mesh_hole_size+mesh_hole_margin+mesh_line_size*0.8-tol_soap_length/2-1.1, -mesh_hole_size+mesh_hole_margin-tol_soap_length/2, -0.1]) {
            hexagon_grid(ceil(tol_soap_width/(2*mesh_hole_size)+3), ceil(tol_soap_length/(2*mesh_hole_size)), mesh_hole_size, mesh_thickness+0.2);
        }
    }
    difference() {
        param_cyl_hull(tol_soap_length, tol_soap_width, insert_out_corner_radius, mesh_thickness);
        translate([0, 0, -0.1]) {
            param_cyl_hull(tol_soap_length-2*mesh_line_size, tol_soap_width-2*mesh_line_size, insert_in_corner_radius, mesh_thickness+0.2);
        }
    }
}

echo(str("tol_soap_length        = ", tol_soap_length));
echo(str("tol_soap_width         = ", tol_soap_width));
echo(str("insert_out_corner_radius = ", insert_out_corner_radius));
