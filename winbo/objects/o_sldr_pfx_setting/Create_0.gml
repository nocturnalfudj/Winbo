// Inherit the parent event
event_inherited();

#region Slider
	group_enable = false;

	#region Value
		value_current = o_pfx.pfx_setting;
		value_previous = value_current+1;

		value_max = PFXSetting.high;
		value_max_previous = value_max;

		value_min = 0;
		value_min_previous = value_min;
		
		value_current_percent = (value_current-value_min) / (value_max-value_min);
		
		percent = false;
		decimal_digits = 0;
	#endregion

	#region Discrete
		discrete = true;
		discrete_count = PFXSetting.SIZE;
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
	
	#region Current
		text_value_current = string(value_current);
		text_value_current_enable = true;
		text_value_current_x = 0;
		text_value_current_y = -_text_y_gap;
	#endregion

	#region Title
		title_enable = true;
		
		title_text = new Text(TextGroup.ui,224); // "Particle Effects"
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

	state_script[UIState.active][UIStateStage.main] =  sldr_pfx_setting_active_main;
#endregion