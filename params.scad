$fn = 128;

module cube_on_z0 (width, length, height) {
    translate(v = [0,0,height/2]) {
        cube([width
             ,length
             ,height]
            ,center=true);
    }
}

module param_cyl_hull(length, width, corner_radius, height) {
    center_length = length-2*corner_radius;
    center_width = width-2*corner_radius;
    hull() {
        translate([-center_length/2, -center_width/2, 0]) {
            cylinder(r=corner_radius, h=height, center=false);
        }
        translate([-center_length/2, +center_width/2, 0]) {
            cylinder(r=corner_radius, h=height, center=false);
        }
        translate([+center_length/2, +center_width/2, 0]) {
            cylinder(r=corner_radius, h=height, center=false);
        }
        translate([+center_length/2, -center_width/2, 0]) {
            cylinder(r=corner_radius, h=height, center=false);
        }
    }
}

anchor_rail_tolerance = 0.03;
bowl_insert_tolerance = 0.005;

anchor_small_diam   = 10;
anchor_small_height = 3;
anchor_big_diam     = 20;
anchor_big_height   = 5;
anchor_hole_diam    = 4.5;

countersink_big_diam = 8.5;
countersink_height = 4.5;

bowl_out_corner_radius = 6;
bowl_wall_thickness = 1;
bowl_in_corner_radius = bowl_out_corner_radius-bowl_wall_thickness;

soap_length = 105;
soap_width = 60;

bowl_height = 30;

mesh_cutout_height = 13;
bowl_shelf_thickness = 2;

rail_wall_thickness = 1.5;
rail_length = 40;

mesh_line_size = 2;
mesh_thickness = 2;
mesh_hole_size = 5.1;
mesh_hole_margin = 1;

assert(anchor_small_height > rail_wall_thickness*(1+anchor_rail_tolerance), "anchor_small_height should be larger to make sure rail has space");
