// Inherit the parent event
event_inherited();

#region Slider
	group_enable = false;

	#region Value
		switch(o_camera.anti_aliasing){
			case 0:
				value_current = 0;
			break;
			
			case 2:
				value_current = 1;
			break;
			
			case 4:
				value_current = 2;
			break;
			
			case 8:
				value_current = 3;
			break;
		}
		value_previous = value_current+1;

		value_max = 3;
		value_max_previous = value_max;

		value_min = 0;
		value_min_previous = value_min;
		
		value_current_percent = (value_current-value_min) / (value_max-value_min);
		
		percent = false;
		decimal_digits = 0;
	#endregion

	#region Discrete
		discrete = true;
		discrete_count = 4;
		discrete_bar_enable = true;
	#endregion

	#region Part Draw
		draw_part = true;
		draw_part_len = 0;
	#endregion
	
	live = false;
#endregion

#region Text
	var _text_y_gap = height*2.5;
	
	#region Current
		text_value_current = string(value_current);
		text_value_current_enable = false;
		text_value_current_x = 0;
		text_value_current_y = -_text_y_gap;
	#endregion
	
	#region Subtitle
		subtitle_enable = true;
		
		subtitle_text = noone; //new Text();
		switch(value_current){
			case 0:
				subtitle_string = "off";
			break;
			
			case 1:
				subtitle_string = "x2";
			break;
			
			case 2:
				subtitle_string = "x4";
			break;
			
			case 3:
				subtitle_string = "x8";
			break;
		}

		subtitle_x = 0;
		subtitle_y = -_text_y_gap;
		if(text_value_current_enable)
			subtitle_y += text_value_current_y;
	#endregion

	#region Title
		title_enable = true;
		
		title_text = new Text(TextGroup.ui,225); // "Anti Aliasing"
		title_string = title_text.value;

		title_x = 0;
		title_y = -_text_y_gap;
		if(text_value_current_enable)
			title_y += text_value_current_y +_text_y_gap/2;
		if(subtitle_enable)
			title_y += subtitle_y +_text_y_gap/2;
	#endregion
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_display_create_main_scroll;
	
	state_script[UIState.down][UIStateStage.main] = sldr_anti_aliasing_down_main;

	state_script[UIState.active][UIStateStage.main] =  sldr_anti_aliasing_active_main;
#endregion