function text_save(){
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	//Language Current Setting
	save("language_current",language_current);

	//ds_map_secure_save(save_map,SAVE_FILE_TEXT);
	
	map_save_json(save_map,SAVE_FILE_TEXT);
}