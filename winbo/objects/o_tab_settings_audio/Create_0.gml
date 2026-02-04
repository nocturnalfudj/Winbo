// Inherit the parent event
event_inherited();

#region Tab Creation
	var _x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	#region Audio
		#region Master
			//Mute Button
			_x = _x_center - 400;
			_y = _y_center - 200;
			instance_create_layer(_x,_y,"lyr_menu",o_btn_audio_mute_master);
			
			//Slider
			_x = _x_center;
			_y = _y_center - 200;
			instance_create_layer(_x,_y,"lyr_menu",o_sldr_audio_master);
		#endregion
		
		#region Music
			//Mute Button
			_x = _x_center - 400;
			_y = _y_center;
			instance_create_layer(_x,_y,"lyr_menu",o_btn_audio_mute_music);
			
			//Slider
			_x = _x_center;
			_y = _y_center;
			instance_create_layer(_x,_y,"lyr_menu",o_sldr_audio_music);
		#endregion
		
		#region SFX
			//Mute Button
			_x = _x_center - 400;
			_y = _y_center + 200;
			instance_create_layer(_x,_y,"lyr_menu",o_btn_audio_mute_sfx);
			
			//Slider
			_x = _x_center;
			_y = _y_center + 200;
			instance_create_layer(_x,_y,"lyr_menu",o_sldr_audio_sfx);
		#endregion
	#endregion
	
	////Update Settings Scroll
	//with(scroll){
	//	var _y_min;
	//	_y_min = y - 1200;
	//	position_clamp_min.Set(0,_y_min);
	//}
	
	////Scroll Slider
	//_x = _x_width - 100;
	//_y = _y_center;
	//scroll_slider_create_from_anchor(_x,_y,"lyr_menu",true,ui_tab_settings_audio_create_main);
#endregion