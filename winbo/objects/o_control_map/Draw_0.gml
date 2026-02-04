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
		
	#region Text
		draw_set_font(text_font);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(text_colour);
	
		var _x1,_y1;
		if(name_string != ""){
			_x1 = _x + name_x*_scale_x;
			_y1 = _y + name_y*_scale_y;
			draw_text_transformed(_x1,_y1,name_string,_scale_x,_scale_y,0);
		}
		
		if(key_sprite != noone){
			_x1 = _x + key_x*_scale_x;
			_y1 = _y + key_y*_scale_y;
			draw_sprite_ext_ags(key_sprite,0,_x1,_y1,_scale_x,_scale_y,_angle,_colour,_alpha);
		}
		else if(key_string != ""){
			_x1 = _x + key_x*_scale_x;
			_y1 = _y + key_y*_scale_y;
			draw_text_transformed(_x1,_y1,key_string,_scale_x,_scale_y,0);
		}
	#endregion
		
	if(notification_active){
		var _not_x,_not_y;
		_not_x = _x + notification_x * _scale_x;
		_not_y = _y + notification_y * _scale_y;
		draw_sprite_ext_ags(notification_sprite,0,_not_x,_not_y,_scale_x,_scale_y,_angle,c_white,_alpha);
	}
}