function pfx_save() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	//PFX Setting
	save("pfx_setting",pfx_setting);

	//ds_map_secure_save(save_map,SAVE_FILE_PFX);
	
	map_save_json(save_map,SAVE_FILE_PFX);
}