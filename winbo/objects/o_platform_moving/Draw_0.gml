//Ignore if Not Visible
if(!camera_visible)
	exit;

//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

var _sprite;
_sprite = sprite_solo;
if(use_ns)
	_sprite = sprite_ns;
	
draw_sprite_ext(_sprite,sprite_current_frame,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
	
if(o_master.dev_mode){
	draw_bounding_box(true);
}