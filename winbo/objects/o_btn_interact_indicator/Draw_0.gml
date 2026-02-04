if(!gui && camera_visible){
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x;
	_y = y;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale;
	_scale_y = image_yscale;
	
	if(sprite_current!=noone){
		draw_sprite_ext_ags(sprite_current,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
	}
	
	//Key
	if((key_sprite!=noone) && (key_draw_enable)){
		var _sprite_scale;
		_sprite_scale = 0.8;
		draw_sprite_ext_ags(key_sprite,0,_x,_y,_scale_x*_sprite_scale,_scale_y*_sprite_scale,_angle,_colour,_alpha);
	}
	
	//Title System
	if((title_enable) || (subtitle_enable))
		title_system_draw(_x,_y,_angle,_colour,_alpha,_scale_x,_scale_y);
		
	//Down Time Indicator
	if(down_time_indicator_enable && (down_time_indicator_percent > 0)){
		var _down_time_indicator_x,_down_time_indicator_y,_outer_radius,_inner_radius,_colour,_alpha,_segments,_start_angle,_clockwise;
		_down_time_indicator_x = _x + down_time_indicator_x;
		_down_time_indicator_y = _y + down_time_indicator_y;
		_outer_radius = 30;
		_inner_radius = 20*(1-(down_time_indicator_percent*0.75));
		_colour = c_white;
		_segments = 64;
		_start_angle = -90;
		_clockwise = true;
		
		_outer_radius *= _scale_x;
		_inner_radius *= _scale_x;
			
		draw_ring(_down_time_indicator_x,_down_time_indicator_y,_outer_radius,_inner_radius,c_black,0.5*down_time_indicator_percent,_segments,1,_start_angle,_clockwise);
		draw_ring(_down_time_indicator_x,_down_time_indicator_y,_outer_radius,_inner_radius,_colour,_alpha,_segments,down_time_indicator_percent,_start_angle,_clockwise);
	}
	
	//draw_bounding_box();
}