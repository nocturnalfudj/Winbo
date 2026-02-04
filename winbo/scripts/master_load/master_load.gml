/// @function master_load
/// @summary Load the master save map and update version stats.
/// @returns {-1|undefined} Returns -1 when running in a browser.
/// @description
///   Handles upgrading save data between versions and creates a new
///   save map when loading fails. Should be called once on startup.
function master_load() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
	
	var _save_map_val;
	
	bad_load = false;
	
	#region Version
		var _save_version;
		_save_version = noone;
		
		//Save Version
		_save_version = load("version_current");
		save("version_current",VERSION);
		
		#region Current Version Run Num			
			_save_map_val = load("version_current_run_count");
			if(_save_map_val != undefined){
				if(_save_version == VERSION){
					version_current_run_count = _save_map_val + 1;
				}
			}
			
			save("version_current_run_count",version_current_run_count);
		#endregion
		
		#region Any Version Run Num
			_save_map_val = load("version_any_run_count");
			if(_save_map_val != undefined)
				version_any_run_count = _save_map_val + 1;
			
			save("version_any_run_count",version_any_run_count);
		#endregion
	#endregion
	
	if(bad_load == true){
		sdm(bad_load_string + "Destroying old map");
		ds_map_destroy(save_map);
		
		sdm(bad_load_string + "Creating new map");
		save_map = ds_map_create();
		
		sdm(bad_load_string + "Saving Master");
		master_save();
	}
}