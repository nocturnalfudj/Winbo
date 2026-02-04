if(gui && camera_visible_gui){
	var _gui_scale;
	_gui_scale = o_ui.gui_scale;
	
	var _x,_y,_angle,_colour,_alpha,_scale_x,_scale_y;
	_x = x * _gui_scale;
	_y = y * _gui_scale;
	_alpha = image_alpha;
	_colour = image_blend;
	_angle = image_angle;
	_scale_x = image_xscale * _gui_scale;
	_scale_y = image_yscale * _gui_scale;
	
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
	
	#region Autofill Lists
		if(o_console.command_autofill_help_enable){
			_text_x += o_console.width * _scale_x;
			
			switch(command_stage){
				case 0:
					#region Subject Autofill
						var _command_autofill_count,_command_autofill_string;
						_command_autofill_count = array_length(o_console.command_subject);
					
						for(var _i=0;_i<_command_autofill_count;_i++){
							_command_autofill_string = o_console.command_subject[_i].prefix;
						
							//Draw highlight background for selected
							if(_i == command_subject){
								draw_set_color(c_flat_green_emerald);
							}
							else{
								draw_set_color(c_flat_red_monza);
							}
						
							draw_text_transformed(_text_x,_text_y - ((_i - 1)*20),_command_autofill_string,_scale_x,_scale_y,0);
						}
					#endregion
				break;
			
				case 1:
					#region Action Autofill
						//Exit if Subject is Invalid
						if(command_subject == -1)
							exit;
				
						//If Subject is Object or Instance use Instance Object Subject
						var _command_subject;
						_command_subject = command_subject;
						if(command_subject == CMDSubject.object || command_subject == CMDSubject.instance)
							_command_subject = CMDSubject.instance_object;
					
						//Get the number of Actions for the Subject
						var _command_subject_action_num;
						_command_subject_action_num = o_console.command_subject[_command_subject].action_num;
				
						//Continue only if Subject has at least one Action
						if(_command_subject_action_num > 0){
						
							var _command_autofill_count,_command_autofill_string;
							_command_autofill_count = _command_subject_action_num
					
							for(var _i=0;_i<_command_autofill_count;_i++){
								_command_autofill_string = o_console.command_subject[_command_subject].action_list[| _i].action_string
						
								//Draw highlight background for selected
								if(_i == command_action){
									draw_set_color(c_flat_green_emerald);
								}
								else{
									draw_set_color(c_flat_red_monza);
								}
						
								draw_text_transformed(_text_x,_text_y - (_i*20),_command_autofill_string,_scale_x,_scale_y,0);
							}
						}
					#endregion
				break;
			
				case 2:
					//Exit if Subject is Invalid
					if(command_subject == -1)
						exit;
						
					//If Subject is Object or Instance use Instance Object Subject
					var _command_subject;
					_command_subject = command_subject;
					if(command_subject == CMDSubject.object || command_subject == CMDSubject.instance)
						_command_subject = CMDSubject.instance_object;
				
					//Exit if Action is Invalid
					if(command_action == -1)
						exit;
						
					//Exit if Argument Slot is Invalid
					if(command_argument_slot == -1)
						exit;
				
					//Get Action Argument Autofill Array
					var _argument_autofill_array;
					_argument_autofill_array = o_console.command_subject[_command_subject].action_list[| command_action].argument_autofill[command_argument_slot];
					
					//Get the number of Argument Autofills for the Action
					var _argument_autofill_array_length;
					_argument_autofill_array_length = array_length(_argument_autofill_array);
				
					//Continue only if Action has at least one Argument Autofill
					if(_argument_autofill_array_length > 0){
					
					
						var _command_autofill_count,_command_autofill_string;
						_command_autofill_count = _argument_autofill_array_length
					
						for(var _i=0;_i<_command_autofill_count;_i++){
							_command_autofill_string = _argument_autofill_array[_i];
						
							//Draw highlight background for selected
							if(_i == command_argument){
								draw_set_color(c_flat_green_emerald);
							}
							else{
								draw_set_color(c_flat_red_monza);
							}
						
							draw_text_transformed(_text_x,_text_y - (_i*20),_command_autofill_string,_scale_x,_scale_y,0);
						}
					}
				break;
			}
		}
	#endregion
}