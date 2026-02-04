if(!gui && camera_visible){
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x;
	_y = y;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale;
	_scale_y = image_yscale;
	
	//Background
	if(sprite_current!=noone)
		draw_sprite_ext_ags(sprite_current,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
	
	#region Text
		draw_set_font(text_font);
		draw_set_halign(text_alignment_h);
		draw_set_valign(text_alignment_v);
		
		draw_set_alpha(_alpha);
		
		//Text
		var _text_x,_text_y,_text_str;
		_text_x = _x + text_x*_scale_x;
		_text_y = _y + text_y*_scale_y;
		
		if(text_string != ""){
			draw_set_color(text_colour);
			_text_str = text_string;
			
			//Password
			if(password_enable){
				_text_str = password_string;
			}
			
			draw_text_transformed(_text_x,_text_y,_text_str,_scale_x,_scale_y,_angle);
		}
		else{
			if(hint_text_enable){
				draw_set_color(hint_colour);
				_text_str = hint_string;
				
				draw_text_transformed(_text_x,_text_y,_text_str,_scale_x,_scale_y,_angle);
			}
		}
		
		//Highlight
		if(text_highlight_active){
			var _highlight_x1,_highlight_y1,_highlight_x2,_highlight_y2;
			_highlight_x1 = _x + text_highlight_x1 * _scale_x;
			_highlight_x2 = _x + text_highlight_x2 * _scale_x;
			_highlight_y1 = _y - (text_highlight_h_half * _scale_y);
			_highlight_y2 = _y + (text_highlight_h_half * _scale_y);
			
			draw_set_colour(text_highlight_c);
			draw_set_alpha(TEXT_FIELD_HIGHLIGHT_ALPHA);
			draw_rectangle(_highlight_x1,_highlight_y1,_highlight_x2,_highlight_y2,false);
				
		}
		//Edit Transform Blink
		else if((state == UIState.edit) && (text_edit_pos_blink)){
			draw_set_color(text_colour);
			var _blink_x,_blink_y;
			_blink_x = _x + text_edit_pos_blink_x * _scale_x; 
			_blink_y = _y + text_edit_pos_blink_y * _scale_y; 
			draw_text_transformed(_blink_x,_blink_y,TEXT_FIELD_EDIT_POS_STRING,_scale_x,_scale_y,_angle);
		}

		draw_set_alpha(1);
	#endregion
	
	#region Title
		if(title_enable){
			draw_set_font(title_font);
			draw_set_halign(title_alignment_h);
			draw_set_valign(title_alignment_v);
			draw_set_color(title_colour);
			
			var _title_x,_title_y;
			_title_x = _x + title_x*_scale_x;
			_title_y = _y + title_y*_scale_y;
				
			draw_text_transformed(_title_x,_title_y,title_string,_scale_x,_scale_y,0);
		}
	#endregion
	
	//Frame
	if((frame_enable) && (sprite_frame!=noone))
		draw_sprite_ext_ags(sprite_frame,0,_x,_y,_scale_x,_scale_y,_angle,_colour,_alpha);
}