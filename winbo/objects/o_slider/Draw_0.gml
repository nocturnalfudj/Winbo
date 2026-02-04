if(!gui && camera_visible){
	var _x,_y,_x1,_y1,_angle,_colour,_alpha,_scale_x,_scale_y;
	
	#region Slider
		_x = x;
		_y = y;
		_alpha = image_alpha;
		_colour = image_blend;
		_angle = image_angle;
		_scale_x = image_xscale;
		_scale_y = image_yscale;


		#region Frame
			if((frame_enable) && (sprite_frame!=noone)){
				draw_sprite_ext_ags(sprite_frame,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
			}
		#endregion

		if(sprite_current!=noone){
			if(draw_all){
				draw_sprite_ext_ags(sprite_current,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
			}
			else if(draw_part){
				var _width,_height;
				if(vertical){
					_width = slider_sprite_width;
					_height = draw_part_len;
					_x1 = _x + draw_slider_x * _scale_x;
					_y1 = _y - draw_slider_y * _scale_y;
					draw_sprite_part_ext(sprite_current,0,0,0,_width,_height,_x1,_y1,_scale_x,-_scale_y,_colour,_alpha);
				}
				else{
					_width = draw_part_len;
					_height = slider_sprite_height;
					_x1 = _x + draw_slider_x * _scale_x;
					_y1 = _y + draw_slider_y * _scale_y;
					draw_sprite_part_ext(sprite_current,0,0,0,_width,_height,_x1,_y1,_scale_x,_scale_y,_colour,_alpha);
				}
			}
			else{
				if(vertical){
					_scale_y *= value_current_percent;
					_y1 = _y - draw_slider_y * _scale_y;
				}
				else{
					_scale_x *= value_current_percent;
					_x1 = _x - draw_slider_x * _scale_x;
				}
				draw_sprite_ext_ags(sprite_current,0,_x1,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
			}
		}
	#endregion
	
	#region Text
		var _string;
		draw_set_alpha(_alpha);
		
		#region Values
			if(text_value_current_enable){
				_string = text_value_current;
				_x1 = _x + text_value_current_x * _scale_x;
				_y1 = _y + text_value_current_y * _scale_y;
				
				draw_set_font(text_value_current_font);
				draw_set_color(text_value_current_colour);
				draw_set_halign(text_value_current_halign);
				draw_set_valign(text_value_current_valign);
				
				draw_text_transformed(_x1,_y1,_string,_scale_x,_scale_y,_angle);
			}
			
			if(text_value_max_enable){
				_string = text_value_max;
				_x1 = _x + text_value_max_x * _scale_x;
				_y1 = _y + text_value_max_y * _scale_y;
				
				draw_set_font(text_value_max_font);
				draw_set_color(text_value_max_colour);
				draw_set_halign(text_value_max_halign);
				draw_set_valign(text_value_max_valign);
				
				draw_text_transformed(_x1,_y1,_string,_scale_x,_scale_y,_angle);
			}
			
			if(text_value_min_enable){
				_string = text_value_min;
				_x1 = _x + text_value_min_x * _scale_x;
				_y1 = _y + text_value_min_y * _scale_y;
				
				draw_set_font(text_value_min_font);
				draw_set_color(text_value_min_colour);
				draw_set_halign(text_value_min_halign);
				draw_set_valign(text_value_min_valign);
				
				draw_text_transformed(_x1,_y1,_string,_scale_x,_scale_y,_angle);
			}
		#endregion
	
		//Title System
		if((title_enable) || (subtitle_enable))
			title_system_draw(_x,_y,_angle,_colour,_alpha,_scale_x,_scale_y);
		
		draw_set_alpha(1);
	#endregion

	#region Discrete Bars
		if((discrete_bar_enable) && (sprite_discrete_bar!=noone)){
			if(vertical){
				for(var _i=1;_i<discrete_count-1;_i++){
					_y1 = _y + (height*(1/(discrete_count - 1))*_i - height_half);
					draw_sprite_ext_ags(sprite_discrete_bar,0,_x,_y1,_scale_x,_scale_y,_angle,_colour,_alpha);
				}
			}
			else{
				for(var _i=1;_i<discrete_count-1;_i++){
					_x1 = _x + (width*(1/(discrete_count - 1))*_i - width_half);
					draw_sprite_ext_ags(sprite_discrete_bar,0,_x1,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
				}
			}	
		}
	#endregion

	#region Pointer
		if((pointer_enable) && (sprite_pointer!=noone)){
			if(vertical){
				_y += pointer_position.current * _scale_y;
			}
			else{
				_x += pointer_position.current * _scale_x;
			}
			draw_sprite_ext_ags(sprite_pointer,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
		}
	#endregion
}