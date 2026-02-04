function text_load() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	var _save_map_val;
	bad_load = false;
	
	//Language Current
	_save_map_val = load("language_current");
	if(_save_map_val != undefined)
		text_language_set(_save_map_val);
	
	if(bad_load == true){
		sdm(bad_load_string + "Destroying old map");
		ds_map_destroy(save_map);
		
		sdm(bad_load_string + "Creating new map");
		save_map = ds_map_create();
		
		sdm(bad_load_string + "Saving Text");
		text_save();
	}
}