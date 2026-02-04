/// @function master_save
/// @summary Save core game state to disk.
/// @returns {-1|undefined} Returns -1 when running in a browser.
function master_save() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
	
	var _map_key_string;

	#region Version
		save("version_current",VERSION);
		save("version_any_run_count",version_any_run_count);
		save("version_current_run_count",version_current_run_count);
	#endregion

	//ds_map_secure_save(save_map,SAVE_FILE_MASTER);
	map_save_json(save_map,SAVE_FILE_MASTER);
}
