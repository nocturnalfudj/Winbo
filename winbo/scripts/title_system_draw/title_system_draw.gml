function title_system_draw(_x,_y,_angle,_colour,_alpha,_scale_x,_scale_y){
	var _x1,_y1;
	
	#region Title
		if(title_enable){
			//Position
			_x1 = _x + title_x * _scale_x;
			_y1 = _y + title_y * _scale_y;
			
			//Text Format
			draw_set_font(title_font);
			draw_set_halign(title_halign);
			draw_set_valign(title_valign);
		
			//Shadow
			if(title_shadow_enable){
				//Shadow Position
				var _shadow_x,_shadow_y;
				_shadow_x = _x1 + title_shadow_x * _scale_x;
				_shadow_y = _y1 + title_shadow_y * _scale_y;
				
				//Shadow Alpha
				if(title_shadow_alpha != 1)
					draw_set_alpha(_alpha * title_shadow_alpha);
				
				draw_set_color(title_shadow_colour);
				draw_text_ext_transformed(_shadow_x,_shadow_y,title_string,-1,title_width,_scale_x,_scale_y,_angle);
			}
		
			//Title Text
			draw_set_alpha(_alpha);
			draw_set_color(title_colour);
			draw_text_ext_transformed(_x1,_y1,title_string,-1,title_width,_scale_x,_scale_y,_angle);
		}
	#endregion
	
	#region Subtitle
		if(subtitle_enable){
			//Position
			_x1 = _x + subtitle_x * _scale_x;
			_y1 = _y + subtitle_y * _scale_y;
			
			//Text Format
			draw_set_font(subtitle_font);
			draw_set_halign(subtitle_halign);
			draw_set_valign(subtitle_valign);
			
			//Shadow
			if(subtitle_shadow_enable){
				//Shadow Position
				var _shadow_x,_shadow_y;
				_shadow_x = _x1 + subtitle_shadow_x * _scale_x;
				_shadow_y = _y1 + subtitle_shadow_y * _scale_y;
				
				//Shadow Alpha
				if(subtitle_shadow_alpha != 1)
					draw_set_alpha(_alpha * subtitle_shadow_alpha);
				
				//Shadow Text
				draw_set_color(subtitle_shadow_colour);
				draw_text_ext_transformed(_shadow_x,_shadow_y,subtitle_string,-1,subtitle_width,_scale_x,_scale_y,_angle);
			}
			
			//Subtitle Text
			draw_set_alpha(_alpha);
			draw_set_color(subtitle_colour);
			draw_text_ext_transformed(_x1,_y1,subtitle_string,-1,subtitle_width,_scale_x,_scale_y,_angle);
		}
	#endregion
	
	//Reset Alpha
	draw_set_alpha(1);
}