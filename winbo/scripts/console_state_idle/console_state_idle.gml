function console_state_idle() {
	//Open / Close
	if(input_check_keyboard_mouse_pressed(o_input.app_control[AppControl.console].input[Input.keyboard][InputProperty.key])){
		if(visible)
			console_close();
		else
			console_open();
	}
	
	if(visible){
		#region Scroll Through Log
			#region Mouse Wheel
				if(mouse_wheel_up()){
					log_draw_start_pos++;
					log_draw_start_pos = clamp(log_draw_start_pos,0,ds_list_size(log)-1);
				}
				if(mouse_wheel_down()){
					log_draw_start_pos--;
					log_draw_start_pos = clamp(log_draw_start_pos,0,ds_list_size(log)-1);
				}
			#endregion
			
			
			var _scroll_input_allow;
			_scroll_input_allow = (o_ui.mouse_gui[0].x < width);
			
			var _drag_active_pre_update,_drag_active_post_update,_scroll_difference;
			_scroll_difference = 0;
			with(scroll){
				#region Move
					_drag_active_pre_update = drag_active;
					movement_drag_pan_update(_scroll_input_allow,1);
					_drag_active_post_update = drag_active;
				#endregion
				
				//Transform Update
				transform_system_update();
				
				//Scroll Difference
				_scroll_difference = transform[TransformType.anchor].value[TransformValue.y].current - drag_start.y;
				_scroll_difference *= 0.025;
			}
			
			if(_drag_active_post_update){
				//Started Dragging this Step
				if(!_drag_active_pre_update){
					scroll_drag_start_log_pos = log_draw_start_pos;
				}
				
				log_draw_start_pos = scroll_drag_start_log_pos + _scroll_difference;
				log_draw_start_pos = clamp(log_draw_start_pos,0,ds_list_size(log)-1);
			}
		#endregion
		
		#region ID Instance Select
			if(id_show != IDShow.off){
				var _x,_y;
				with(o_ui){
					_x = mouse_gui_scale_inverted[0].x;
					_y = mouse_gui_scale_inverted[0].y;
				}
				id_show_inst = instance_position(_x,_y,all);
		
				_x = mouse_x;
				_y = mouse_y;
				id_show_inst_ui = instance_position(_x,_y,all);
		
				if(device_mouse_check_button_pressed(0,mb_left)){
					var _id_show_inst,_id_show_inst_ui;
					_id_show_inst = id_show_inst;
					_id_show_inst_ui = id_show_inst_ui;
			
					if((_id_show_inst != noone) || (_id_show_inst_ui != noone))
					with(text_field_id){
						if(command_stage == 0){
							if(_id_show_inst == noone)
								text_string = "i." + string(_id_show_inst_ui);
							else
								text_string = "i." + string(_id_show_inst);
						
							keyboard_string = text_string;
				
							//Update Text Highlight String
							text_highlight_string = "";
				
							//Update Edit Position
							text_field_edit_pos_move(string_length(text_string),false);
						}
					}
				}
			}	
		#endregion
	}
}