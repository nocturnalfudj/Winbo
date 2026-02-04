/// @function camera_save_filters
/// @summary Persist camera filter settings.
function camera_save_filters() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
	
	//Filters
	for(var _i=0;_i<CameraFilter.SIZE;_i++){		
		save("camera_filter_setting_" + string(_i),filter_setting[_i]);
	}

	//ds_map_secure_save(save_map,SAVE_FILE_CAMERA);
	
	map_save_json(save_map,SAVE_FILE_CAMERA);
}