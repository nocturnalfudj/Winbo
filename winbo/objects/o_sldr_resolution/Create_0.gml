// Inherit the parent event
event_inherited();

#region Slider
	group_enable = false;

	#region Value
		value_current = o_camera.resolution_slot_current;
		value_previous = value_current+1;

		value_max = o_camera.resolution_slot_count - 1;
		value_max_previous = value_max;

		value_min = 0;
		value_min_previous = value_min;
		
		value_current_percent = (value_current-value_min) / (value_max-value_min);
		
		percent = false;
		decimal_digits = 0;
	#endregion

	#region Discrete
		discrete = true;
		discrete_count = value_max + 1;
		discrete_bar_enable = true;
	#endregion

	#region Part Draw
		draw_part = true;
		draw_part_len = 0;
	#endregion
	
	live = true;
#endregion

#region Text
	var _text_y_gap = height*2.5;
	
	#region Subtitle
		var _res_w,_res_h;
		with(o_camera){
			_res_w = resolution[resolution_slot_current][RES_W];
			_res_h = resolution[resolution_slot_current][RES_H];
		}
		subtitle_string = string(_res_w) + "  *  " + string(_res_h);

		subtitle_enable = true;

		subtitle_x = 0;
		
		subtitle_y = -_text_y_gap;
		if(text_value_current_enable)
			subtitle_y += text_value_current_y +_text_y_gap/2;
	#endregion

	#region Title
		title_enable = true;
		
		title_text = new Text(TextGroup.ui,220); // "Resolution"
		title_string = title_text.value;

		title_x = 0;
		
		title_y = -_text_y_gap;
		if(text_value_current_enable)
			title_y += text_value_current_y +_text_y_gap/2;
		if(subtitle_enable)
			title_y += subtitle_y +_text_y_gap/2;
	#endregion
#endregion

#region Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_display_create_main_scroll;
	state_script[UIState.active][UIStateStage.main] = sldr_resolution_active_main;
#endregion

#region Apply Button
	var _x,_y;
	_x = x;
	_y = y + 150;
	instance_create_layer(_x,_y,layer,o_btn_resolution_apply);
#endregion