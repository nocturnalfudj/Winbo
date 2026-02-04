/// @function camera_save_shake
/// @summary Save the current camera shake magnitude.
function camera_save_shake() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
	
	//Camera Shake
	save("shake_magnitude_factor",shake_magnitude_factor);

	//ds_map_secure_save(save_map,SAVE_FILE_CAMERA);
	
	map_save_json(save_map,SAVE_FILE_CAMERA);
}