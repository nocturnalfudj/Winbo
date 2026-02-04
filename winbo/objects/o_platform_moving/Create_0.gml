// Inherit the parent event
event_inherited();

//Image
sprite_current = sprite_index;//director_get_custom_sprite(spr_platform_moving);
sprite_solo = spr_platform_moving_green_solo;
sprite_ns = spr_platform_moving_green_ns;

//Snap Width to Tile Width Factor
var _tile_width;
_tile_width = sprite_get_width(sprite_solo);

//image_xscale from room editor represents the desired number of tiles
var _desired_tiles;
_desired_tiles = round(image_xscale);

//Determine if we use nineslice or solo sprite
use_ns = (_desired_tiles > 1);

//Calculate the appropriate scale and set sprite_index for collision
if(use_ns) {
	//For nineslice: scale to achieve the desired pixel width
	var _desired_pixel_width = _desired_tiles * _tile_width;
	var _ns_base_width = sprite_get_width(sprite_ns);
	image_xscale = _desired_pixel_width / _ns_base_width;
	sprite_index = sprite_ns;
} else {
	//For solo sprite: just use scale of 1
	image_xscale = 1;
	sprite_index = sprite_solo;
}


//State
enum MovingPlatformState{
	move,
	stop,
	
	SIZE
}

moving_platform_state = MovingPlatformState.move;


path_point[0] =	{
					x: 0,
					y: 0,
					forward:	{
									ease_x: ease_quad_in_out,
									ease_y: ease_quad_in_out,
									time: SECOND * 5
								},
					backward:	{
									ease_x: ease_quad_in_out,
									ease_y: ease_quad_in_out,
									time: SECOND * 5
								},
				}
				
path_point[1] =	{
					x: 0,
					y: 1500,
					forward:	{
									ease_x: ease_quad_in_out,
									ease_y: ease_quad_in_out,
									time: SECOND * 5
								},
					backward:	{
									ease_x: ease_quad_in_out,
									ease_y: ease_quad_in_out,
									time: SECOND * 5
								},
				}
				
//path_point[2] =	{
//					x: 1000,
//					y: -1000,
//					forward:	{
//									ease_x: ease_quad_in_out,
//									ease_y: ease_quad_in_out,
//									time: SECOND * 5
//								},
//					backward:	{
//									ease_x: ease_quad_in_out,
//									ease_y: ease_quad_in_out,
//									time: SECOND * 5
//								},
//				}

//Total Path Points
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