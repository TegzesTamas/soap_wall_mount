$fn = 128;

module cube_on_z0 (width, length, height) {
    translate(v = [0,0,height/2]) {
        cube([width
             ,length
             ,height]
            ,center=true);
    }
}

tolerance = 0.03;

anchor_small_diam   = 10;
anchor_small_height = 5;
anchor_big_diam     = 20;
anchor_big_height   = 5;
anchor_hole_diam    = 4;

countersink_big_diam = 8.5;
countersink_height = 4.5;

bowl_out_corner_radius = 6;
bowl_wall_thickness = 1;
bowl_in_corner_radius = bowl_out_corner_radius-bowl_wall_thickness;

soap_length = 105;
soap_width = 60;

bowl_in_length = soap_length * (1+tolerance);
bowl_in_width = soap_width * (1+tolerance);

bowl_out_length = bowl_in_length + 2*bowl_wall_thickness;
bowl_out_width = bowl_in_width + 2*bowl_wall_thickness;

bowl_height = 20;

mesh_cutout_height = 13;
bowl_shelf_thickness = 2;
bowl_shelf_length = bowl_in_length - 2*bowl_shelf_thickness;
bowl_shelf_width = bowl_in_width - 2*bowl_shelf_thickness;
bowl_shelf_corner_radius = bowl_in_corner_radius - bowl_shelf_thickness;
assert(bowl_shelf_corner_radius > 0, "Shelf corner radius too small");

rail_wall_thickness = 1;
rail_length = 40;
