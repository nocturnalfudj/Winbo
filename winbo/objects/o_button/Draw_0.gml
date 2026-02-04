if(!gui && camera_visible){
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x;
	_y = y;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale;
	_scale_y = image_yscale;
	
	if(sprite_current!=noone)
		draw_sprite_ext_ags(sprite_current,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
		
	if(notification_active){
		var _not_x,_not_y;
		_not_x = _x + notification_x * _scale_x;
		_not_y = _y + notification_y * _scale_y;
		draw_sprite_ext_ags(notification_sprite,0,_not_x,_not_y,_scale_x,_scale_y,_angle,c_white,_alpha);
	}
	
	//Title System
	if((title_enable) || (subtitle_enable))
		title_system_draw(_x,_y,_angle,_colour,_alpha,_scale_x,_scale_y);
	
	//draw_bounding_box();
}