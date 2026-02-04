// Inherit the parent event
event_inherited();

#region Tab Creation
	var _instance,_x,_y,_x_center,_y_center,_x_width,_y_height;
	with(o_camera){
		_x_center = width_ini_half;
		_y_center = height_ini_half;
		_x_width = width_ini;
		_y_height = height_ini;
	}
	
	//Fullscreen
	_x = _x_center - 150;
	_y = 700;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_btn_full_screen);
	
	//VSync
	_x = _x_center + 150;
	_y = 700;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_btn_vsync);
	
	//Resolution
	_x = _x_center;
	_y = 950;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_sldr_resolution);
	
	//Anti Aliasing
	_x = _x_center;
	_y = 1150;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_sldr_anti_aliasing);
	
	//PFX
	_x = _x_center;
	_y = 1400;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_sldr_pfx_setting);
	
	//Camera Shake
	_x = _x_center;
	_y = 1650;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_sldr_camera_shake);
	
	//Lighting enable
	_x = _x_center - 300;
	_y = 2000;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_btn_lighting_enable);
	
	//Vignette enable
	_x = _x_center + 300;
	_y = 2000;
	_instance = instance_create_layer(_x,_y,"lyr_menu",o_btn_vignette_enable);
	
	#region Camera Filters
		for(var _i=0;_i<CameraFilter.SIZE;_i++){
			_x = _x_center;
			_y = 2300 + 150*_i;
			_instance = instance_create_layer(_x,_y,"lyr_menu",o_sldr_camera_filter);
			with(_instance){
				filter_setting = _i;
			}
		}
	#endregion
	
	//Update Settings Scroll
	with(scroll){
		var _y_min;
		_y_min = y - 1500;
		position_clamp_min.Set(0,_y_min);
	}
	
	////Scroll Slider
	//_x = _x_width - 100;
	//_y = _y_center;
	//scroll_slider_create_from_anchor(_x,_y,"lyr_menu",true,ui_tab_settings_display_create_main);
#endregion