// Draw_0.gml event
//Ignore if Not Visible
if(!camera_visible)
	exit;

//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

var _track_x = start_x + (sprite_get_width(spr_shifting_wall) - sprite_get_width(spr_shifting_wall_track)) * 0.5;
var _track_y = min(start_y, start_y + path_point[1].y) - ((sprite_get_height(spr_shifting_wall_track) - (sprite_get_height(spr_shifting_wall) + abs(path_point[1].y))) * 0.5);
draw_sprite_ext(spr_shifting_wall_track,0,_track_x,_track_y,1,1,0,image_blend,image_alpha);

var _gear_angle = current_time * 0.72;
var _gear_x = x + sprite_get_width(spr_shifting_wall) * 0.5;
draw_sprite_ext(spr_shifting_wall_gear,0,_gear_x,y + 128,1,1,_gear_angle,image_blend,image_alpha);
draw_sprite_ext(spr_shifting_wall_gear,0,_gear_x,y + 320,1,1,-_gear_angle,image_blend,image_alpha);
draw_sprite_ext(spr_shifting_wall_gear,0,_gear_x,y + 512,1,1,_gear_angle,image_blend,image_alpha);

draw_sprite_ext(sprite_current,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
if(o_master.dev_mode){
	draw_bounding_box(true);
}
