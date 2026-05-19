// Draw_0.gml event
//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

if(image_angle != 0){
	draw_sprite_ext(sprite_current,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	exit;
}

var _source_width = sprite_get_width(sprite_current);
var _source_height = sprite_get_height(sprite_current);
var _slice = min(shifting_wall_track_slice_size,_source_width * 0.5,_source_height * 0.5,shifting_wall_track_width * 0.5,shifting_wall_track_height * 0.5);
var _source_mid_width = _source_width - (_slice * 2);
var _source_mid_height = _source_height - (_slice * 2);
var _draw_mid_width = shifting_wall_track_width - (_slice * 2);
var _draw_mid_height = shifting_wall_track_height - (_slice * 2);

draw_sprite_part_ext(sprite_current,0,0,0,_slice,_slice,x,y,1,1,image_blend,image_alpha);
draw_sprite_part_ext(sprite_current,0,_slice,0,_source_mid_width,_slice,x + _slice,y,_draw_mid_width / _source_mid_width,1,image_blend,image_alpha);
draw_sprite_part_ext(sprite_current,0,_source_width - _slice,0,_slice,_slice,x + shifting_wall_track_width - _slice,y,1,1,image_blend,image_alpha);

draw_sprite_part_ext(sprite_current,0,0,_slice,_slice,_source_mid_height,x,y + _slice,1,_draw_mid_height / _source_mid_height,image_blend,image_alpha);
draw_sprite_part_ext(sprite_current,0,_slice,_slice,_source_mid_width,_source_mid_height,x + _slice,y + _slice,_draw_mid_width / _source_mid_width,_draw_mid_height / _source_mid_height,image_blend,image_alpha);
draw_sprite_part_ext(sprite_current,0,_source_width - _slice,_slice,_slice,_source_mid_height,x + shifting_wall_track_width - _slice,y + _slice,1,_draw_mid_height / _source_mid_height,image_blend,image_alpha);

draw_sprite_part_ext(sprite_current,0,0,_source_height - _slice,_slice,_slice,x,y + shifting_wall_track_height - _slice,1,1,image_blend,image_alpha);
draw_sprite_part_ext(sprite_current,0,_slice,_source_height - _slice,_source_mid_width,_slice,x + _slice,y + shifting_wall_track_height - _slice,_draw_mid_width / _source_mid_width,1,image_blend,image_alpha);
draw_sprite_part_ext(sprite_current,0,_source_width - _slice,_source_height - _slice,_slice,_slice,x + shifting_wall_track_width - _slice,y + shifting_wall_track_height - _slice,1,1,image_blend,image_alpha);
