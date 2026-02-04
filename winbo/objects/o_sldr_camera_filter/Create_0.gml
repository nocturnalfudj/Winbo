// Inherit the parent event
event_inherited();

//Filter
filter_setting = CameraFilter.contrast;

#region Slider
	value_current = o_camera.filter_setting[filter_setting];
	value_previous = value_current+1;

	value_max = o_camera.filter_setting_max[filter_setting];
	value_max_previous = value_max;

	value_min = o_camera.filter_setting_min[filter_setting];
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
		title_enable = true;
		
		title_text = noone;
		title_string = "Camera Setting";

		title_x = 0;
		title_y = -_text_y_gap;
		if(text_value_current_enable)
			title_y += text_value_current_y +_text_y_gap/2;
		if(subtitle_enable)
			title_y += subtitle_y +_text_y_gap/2;
	#endregion
#endregion

#region State Scripts
	state_script[UIState.create][UIStateStage.main] = sldr_camera_filter_create_main;

	state_script[UIState.active][UIStateStage.main] = sldr_camera_filter_active_main;
#endregion