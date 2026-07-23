// Draw_0.gml event
//Ignore if Not Visible
if(!camera_visible)
	exit;

//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

var _track_sprite = (shifting_wall_variant == 1) ? spr_shifting_wall_track_stone : spr_shifting_wall_track;
var _track_x = start_x + (sprite_get_width(sprite_current) - sprite_get_width(_track_sprite)) * 0.5;
var _track_y = min(start_y, start_y + path_point[1].y) - ((sprite_get_height(_track_sprite) - (sprite_get_height(sprite_current) + abs(path_point[1].y))) * 0.5);

if(shifting_wall_track_draw){
	draw_sprite_ext(_track_sprite,0,_track_x,_track_y,1,1,0,image_blend,image_alpha);
}

var _gear_angle = current_time * 0.72;
var _cos = dcos(image_angle);
var _sin = dsin(image_angle);
var _gear_local_x = sprite_get_width(sprite_current) * 0.5;
var _gear_y_0 = 128;
var _gear_y_1 = 320;
var _gear_y_2 = 512;

draw_sprite_ext(spr_shifting_wall_gear,0,x + (_gear_local_x * _cos) + (_gear_y_0 * _sin),y - (_gear_local_x * _sin) + (_gear_y_0 * _cos),1,1,image_angle + _gear_angle,image_blend,image_alpha);
draw_sprite_ext(spr_shifting_wall_gear,0,x + (_gear_local_x * _cos) + (_gear_y_1 * _sin),y - (_gear_local_x * _sin) + (_gear_y_1 * _cos),1,1,image_angle - _gear_angle,image_blend,image_alpha);
draw_sprite_ext(spr_shifting_wall_gear,0,x + (_gear_local_x * _cos) + (_gear_y_2 * _sin),y - (_gear_local_x * _sin) + (_gear_y_2 * _cos),1,1,image_angle + _gear_angle,image_blend,image_alpha);

draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);

if(o_master.dev_mode){
	draw_bounding_box(true);
}
