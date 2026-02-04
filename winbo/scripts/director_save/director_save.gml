/// @function director_save
/// @summary Serialize the director save map to disk if possible.
/// @returns {real} 0 on success, -1 when unsupported.
/// Typically invoked before changing rooms.
function director_save() {
	//If Game is Running in a Browser Return -1
	if(os_browser != browser_not_a_browser)
		return -1;
		
	//ds_map_secure_save(save_map,SAVE_FILE_DIRECTOR);
	
	map_save_json(save_map,SAVE_FILE_DIRECTOR);
}