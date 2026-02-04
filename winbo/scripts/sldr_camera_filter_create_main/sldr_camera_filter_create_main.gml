/// @function sldr_camera_filter_create_main
/// @summary Initialize the slider used to adjust camera filter settings.
/// @returns {void}
function sldr_camera_filter_create_main() {
	//Default Settings Display Tab Scroll
	ui_tab_settings_display_create_main_scroll();
	
	//Title
	switch(filter_setting){
		case CameraFilter.contrast:
			title_string = "Contrast";
		break;
		
		case CameraFilter.saturation:
			title_string = "Saturation";
		break;
		
		case CameraFilter.brightness:
			title_string = "Brightness";
		break;
		
		break;
		
		case CameraFilter.gamma:
			title_string = "Gamma";
		break;
		
		case CameraFilter.bloom:
			title_string = "Bloom Intensity";
			
			var _text_y_gap = height*1.5;
			
			#region Subtitle
				subtitle_enable = true;
				subtitle_string = "when used";

				subtitle_x = 0;
				
				//Raise Above Discrete Bars if Enabled
				subtitle_y = -_text_y_gap;
		
				//Raise Above Value Current if Enabled
				if(text_value_current_enable)
					subtitle_y += text_value_current_y;
			#endregion
			
			#region Title
				title_x = 0;
				title_y = -_text_y_gap;
				if(text_value_current_enable)
					title_y += text_value_current_y +_text_y_gap/1;
				if(subtitle_enable)
					title_y += subtitle_y +_text_y_gap*1.5;
			#endregion
		break;
		
		case CameraFilter.noise_additional:
			title_string = "Additional Noise";
		break;
		
		case CameraFilter.noise_intensity:
			title_string = "Noise Intensity";
			
			var _text_y_gap = height*1.5;
			
			#region Subtitle
				subtitle_enable = true;
				subtitle_string = "when used";

				subtitle_x = 0;
				
				//Raise Above Discrete Bars if Enabled
				subtitle_y = -_text_y_gap;
		
				//Raise Above Value Current if Enabled
				if(text_value_current_enable)
					subtitle_y += text_value_current_y;
			#endregion
			
			#region Title
				title_x = 0;
				title_y = -_text_y_gap;
				if(text_value_current_enable)
					title_y += text_value_current_y +_text_y_gap/1;
				if(subtitle_enable)
					title_y += subtitle_y +_text_y_gap*1.5;
			#endregion
		break;
		
		case CameraFilter.vignette:
			title_string = "Vignette";
		break;
	}
	
	#region Slider
		value_current = o_camera.filter_setting[filter_setting];
		value_previous = value_current+1;

		value_max = o_camera.filter_setting_max[filter_setting];
		value_max_previous = value_max;

		value_min = o_camera.filter_setting_min[filter_setting];
		value_min_previous = value_min;
	#endregion
}