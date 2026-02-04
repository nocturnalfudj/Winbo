/// @desc Persists the master volume level using the global save map
function audio_save_master_volume() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	save("volume_master",volume_master);

	//ds_map_secure_save(save_map,SAVE_FILE_AUDIO);
	map_save_json(save_map,SAVE_FILE_AUDIO);
}