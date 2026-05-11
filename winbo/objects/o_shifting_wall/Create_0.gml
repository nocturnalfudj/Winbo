event_inherited();

sprite_current = spr_shifting_wall;
sprite_solo = spr_shifting_wall;
sprite_ns = spr_shifting_wall;
sprite_index = spr_shifting_wall;
image_xscale = 1;
image_yscale = 1;
use_ns = false;

with(path_point[0]){
	x = 0;
	y = 0;
	backward.time = SECOND * 1.25;
}

with(path_point[1]){
	x = 0;
	y = -192;
	forward.time = SECOND * 1.25;
	backward.time = SECOND * 1.25;
}

path_point_total = array_length(path_point);
path_loop = true;
path_loop_swap_direction = true;
path_direction = 1;
path_point_current = 0;
path_time = 0;
path_point_start_x = 0;
path_point_start_y = 0;
path_x = 0;
path_y = 0;
start_x = x;
start_y = y;
