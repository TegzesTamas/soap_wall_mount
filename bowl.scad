include <params.scad>

bowl_shelf_length = bowl_in_length - 2*bowl_shelf_thickness;
bowl_shelf_width = bowl_in_width - 2*bowl_shelf_thickness;
bowl_shelf_corner_radius = bowl_in_corner_radius - bowl_shelf_thickness;
assert(bowl_shelf_corner_radius > 0, "Shelf corner radius too small");

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

module param_hull(length, width, corner_radius, height) {
    center_length = length-2*corner_radius;
    center_width = width-2*corner_radius;
    hull() {
        // Bottom corners
        translate([-center_length/2, -center_width/2, 0]) {
            sphere(r=corner_radius);
        }
        translate([-center_length/2, +center_width/2, 0]) {
            sphere(r=corner_radius);
        }
        translate([+center_length/2, +center_width/2, 0]) {
            sphere(r=corner_radius);
        }
        translate([+center_length/2, -center_width/2, 0]) {
            sphere(r=corner_radius);
        }

        // Top corners
        param_cyl_hull(length, width, corner_radius, height-corner_radius);
    }
}
module bowl_body() {
    difference() {
        param_hull(bowl_out_length, bowl_out_width, bowl_out_corner_radius, bowl_height);
        union(){
            param_hull(bowl_shelf_length, bowl_shelf_width, bowl_shelf_corner_radius, bowl_height-bowl_wall_thickness);
            translate([0, 0, bowl_height-mesh_cutout_height-bowl_out_corner_radius]) {
                param_cyl_hull(bowl_in_length, bowl_in_width, bowl_in_corner_radius, mesh_cutout_height*2);
            }
        }
    }
}

rail_in_width = anchor_big_diam*(1+tolerance);
rail_in_height = anchor_big_height*(1+tolerance);
rail_out_width = rail_in_width+2*rail_wall_thickness;
rail_out_height = rail_in_height+2*rail_wall_thickness;

rail_cutout_width = anchor_small_diam+(1+tolerance);

module cyl_cube(width, length, height) {
    hull() {
        cylinder(d=width, h=height, center=false);
        translate([0, length/2, 0]) {
            cube_on_z0(width, length, height);
        }
    }
}

module rail() {
    translate([0, -rail_out_height+rail_wall_thickness, rail_length]) {
        rotate([-90, 0, 0]) {
            difference() {
                cyl_cube(rail_out_width, rail_length, rail_out_height);
                union(){
                    translate([0, 0, rail_wall_thickness]) {
                        cyl_cube(rail_in_width, rail_length+1, rail_in_height);
                    }
                    translate([0, 0, -rail_wall_thickness*0.05]) {
                        cyl_cube(rail_cutout_width, rail_length+1, rail_wall_thickness*1.1);
                    }
                }
            }
        }
    }
}

union(){
    translate([0, -bowl_out_width/2, ]) {
        rail();
    }
    translate([0, 0, bowl_out_corner_radius]) {
        bowl_body();
    }
    difference() {
        translate([0, -bowl_out_width/4, 0]) {
            cube_on_z0(rail_out_width, bowl_out_width/2, bowl_out_corner_radius);
        }
        translate([0, 0, bowl_out_corner_radius]) {
            param_hull(bowl_shelf_length, bowl_shelf_width, bowl_shelf_corner_radius, bowl_height-bowl_wall_thickness);
        }
    }
}
