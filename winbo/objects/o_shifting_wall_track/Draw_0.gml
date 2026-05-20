// Draw_0.gml event
//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

var _source_width = sprite_get_width(sprite_current);
var _source_height = sprite_get_height(sprite_current);
var _draw_xscale = (shifting_wall_track_width / _source_width) * sign(image_xscale);
var _draw_yscale = (shifting_wall_track_height / _source_height) * sign(image_yscale);

if(image_angle != 0 || image_xscale < 0 || image_yscale < 0){
	draw_sprite_ext(sprite_current,0,x,y,_draw_xscale,_draw_yscale,image_angle,image_blend,image_alpha);
}
else{
	draw_sprite_stretched_ext(sprite_current,0,x,y,shifting_wall_track_width,shifting_wall_track_height,image_blend,image_alpha);
}
