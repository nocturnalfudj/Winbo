// Inherit the parent event
event_inherited();

#region Slider
	group_enable = true;
	group = 0;

	value_current = 1;
	value_previous = value_current+1;

	value_max = 1;
	value_max_previous = value_max;

	value_min = 0;
	value_min_previous = value_min;

	percent = true;
	decimal_digits = 0;

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
		title_text = noone;//new Text(TextGroup.ui,221); // "Master"
		title_string = "Gamepad Aim Assist";
		title_enable = true;

		title_x = 0;
		title_y = -_text_y_gap;
		if(text_value_current_enable)
			title_y += text_value_current_y +_text_y_gap/2;
		if(subtitle_enable)
			title_y += subtitle_y +_text_y_gap/2;
	#endregion
#endregion

//User
user = o_input.user[0];

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = ui_tab_settings_input_create_main;
	
	state_script[UIState.idle][UIStateStage.main] = sldr_gamepad_aim_assist_idle_main;

	state_script[UIState.active][UIStateStage.main] =  sldr_gamepad_aim_assist_active_main;
	state_script[UIState.down][UIStateStage.stop] =  sldr_gamepad_aim_assist_down_stop;
#endregion