//Ignore if Not Visible (but allow phantom mode to draw)
if(!camera_visible && !phantom)
	exit;

//Only Operate In Normal Draw Event
if(o_director.depth_grid_draw_event_state != 1)
	exit;
	
/// @description Draw the platform with visual offset for shake effect

// Determine draw position based on phantom mode
var _draw_x, _draw_y;
if(phantom){
	// When phantom, draw at original position with visual offsets
	_draw_x = origin_x + visual_offset_x;
	_draw_y = origin_y + visual_offset_y;
} else {
	// When normal, draw at current position with visual offsets
	_draw_x = x + visual_offset_x;
	_draw_y = y + visual_offset_y;
}

// Draw the sprite at the calculated position using Image system
draw_sprite_ext(
	image.sprite_current,  // Use Image system sprite
	image.frame,           // Use Image system frame
	_draw_x, 
	_draw_y, 
	image_xscale, 
	image_yscale, 
	image_angle, 
	image_blend, 
	image_alpha
);
	
if(o_master.dev_mode){
	// For debug bounding box, use actual position when not phantom
	if(!phantom){
		draw_bounding_box(true);
	}
}