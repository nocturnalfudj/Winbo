// Draw_0.gml event
//Ignore if Not Visible
if(!camera_visible)
	exit;
	
//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;

if(saw_track_draw){
	draw_sprite_ext(
		spr_saw_track,
		0,
		saw_start_x - sprite_get_xoffset(spr_saw_blade),
		saw_start_y - sprite_get_yoffset(spr_saw_blade),
		saw_track_draw_width_scale,
		saw_track_draw_height_scale,
		0,
		image_blend,
		image_alpha
	);
}

draw_sprite_ext(
	sprite_current,
	sprite_current_frame,
	x,
	y,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);
	
if(o_master.dev_mode){
	draw_bounding_box();
}
