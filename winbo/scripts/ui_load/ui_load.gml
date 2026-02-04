/// @function ui_load
/// @summary Load saved UI settings from disk or create defaults.
function ui_load() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	bad_load = false;
	
	if(bad_load == true){
		sdm(bad_load_string + "Destroying old map");
		ds_map_destroy(save_map);
		
		sdm(bad_load_string + "Creating new map");
		save_map = ds_map_create();
		
		sdm(bad_load_string + "Saving UI");
		ui_save();
	}
}