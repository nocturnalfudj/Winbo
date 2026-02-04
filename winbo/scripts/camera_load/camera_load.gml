/// @function camera_load
/// @summary Apply saved camera settings from disk.
function camera_load() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	var _save_map_val;
	
	bad_load = false;

	#region Resolution
		//Get Saved Dimensions
		var _resolution_width,_resolution_height;
		_resolution_width = load("resolution_width");
		_resolution_height = load("resolution_height");
		
		if((_resolution_width != undefined) && (_resolution_height != undefined)){
			for(var _i=0;_i<resolution_slot_count;_i++){
				if((_resolution_width == resolution[_i][RES_W]) && (_resolution_height == resolution[_i][RES_H])){
					resolution_slot_current = _i;
					resolution_slot_next = _i;
					break;
				}
			}
		}
	#endregion
	
	#region Full Screen
		_save_map_val = load("fullscreen");
		if(_save_map_val != undefined){
			fullscreen = _save_map_val;
			
			if(fullscreen)
				window_set_fullscreen(true);
			else{
				window_set_fullscreen(false);
	
				with(o_master){
					//Center Window Alarm
					alarm[MasterAlarm.center_window] = 1;
				}
			}
		}
	#endregion
	
	#region Vsync
		_save_map_val = load("vsync");
		if(_save_map_val != undefined)
			vsync = _save_map_val;
	#endregion
	
	#region Anti Aliasing
		_save_map_val = load("anti_aliasing");
		if(_save_map_val != undefined)
			anti_aliasing = _save_map_val;
	#endregion
	
	#region Shake Factor
		_save_map_val = load("shake_magnitude_factor");
		if(_save_map_val != undefined)
			shake_magnitude_factor = _save_map_val;
	#endregion
	
	#region Filters
		for(var _i=0;_i<CameraFilter.SIZE;_i++){
			_save_map_val = load("camera_filter_setting_" + string(_i));
			save("camera_filter_setting_" + string(_i),filter_setting[_i]);
			if(_save_map_val != undefined)
				filter_setting[_i] = _save_map_val;
		}
	#endregion
	
	#region Lighting Enable
		_save_map_val = load("lighting_enable");
		if(_save_map_val != undefined)
			lighting_enable = _save_map_val;
	#endregion
	
	if(bad_load == true){		
		sdm(bad_load_string + "Destroying old map");
		ds_map_destroy(save_map);
		
		sdm(bad_load_string + "Creating new map");
		save_map = ds_map_create();
		
		sdm(bad_load_string + "Saving Camera");
		camera_save();
	}
}