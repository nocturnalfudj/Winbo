/// @function camera_save
/// @summary Persist camera related settings to disk.
function camera_save() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	//Resolution
	save("resolution_width",resolution[resolution_slot_current][RES_W]);
	save("resolution_height",resolution[resolution_slot_current][RES_H]);
	
	//Full Screen
	save("fullscreen",fullscreen);
	
	//Vsync
	save("vsync",vsync);
	
	//Anti Aliasing
	save("anti_aliasing",anti_aliasing);
	
	//Camera Shake
	save("shake_magnitude_factor",shake_magnitude_factor);
	
	//Filters
	for(var _i=0;_i<CameraFilter.SIZE;_i++){		
		save("camera_filter_setting_" + string(_i),filter_setting[_i]);
	}
	
	//Lighting Enable
	save("lighting_enable",lighting_enable);

	//ds_map_secure_save(save_map,SAVE_FILE_CAMERA);
	
	map_save_json(save_map,SAVE_FILE_CAMERA);
}