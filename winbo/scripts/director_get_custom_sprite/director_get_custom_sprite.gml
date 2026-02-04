/// @function director_get_custom_sprite
/// @summary Get custom sprite if available, otherwise return original
/// @param {real} _original_sprite The original sprite to potentially replace
/// @returns {real} The replacement sprite or original sprite
function director_get_custom_sprite(_original_sprite) {
	// Don't run in browser
	if(os_browser != browser_not_a_browser) return _original_sprite;
	
	// Check if we already have a custom sprite loaded for this original
	var _custom_sprite = ds_map_find_value(o_director.custom_sprite_map, _original_sprite);
	if(_custom_sprite != undefined) {
		return _custom_sprite;
	}
	
	// Try to find the filename for this sprite
	var _filename = ds_map_find_value(o_director.custom_sprite_files, _original_sprite);
	if(_filename == undefined) {
		// No filename mapping found, return original
		return _original_sprite;
	}
	
	// Build the full file path
	var _file_path = o_director.custom_sprite_folder + _filename;
	
	// Check if file exists
	if(!file_exists(_file_path)) {
		// File doesn't exist, store original sprite to avoid checking again
		ds_map_add(o_director.custom_sprite_map, _original_sprite, _original_sprite);
		return _original_sprite;
	}
	
	// Get original sprite properties for consistency
	var _width = sprite_get_width(_original_sprite);
	var _height = sprite_get_height(_original_sprite);
	var _xorigin = sprite_get_xoffset(_original_sprite);
	var _yorigin = sprite_get_yoffset(_original_sprite);
	
	// Try to load the external sprite
	var _new_sprite = sprite_add(_file_path, 0, false, false, _xorigin, _yorigin);
	
	if(_new_sprite != -1) {
		// Successfully loaded - store in map and return
		ds_map_add(o_director.custom_sprite_map, _original_sprite, _new_sprite);
		sdm("Loaded custom sprite: " + _filename);
		return _new_sprite;
	} else {
		// Failed to load - store original to avoid trying again
		ds_map_add(o_director.custom_sprite_map, _original_sprite, _original_sprite);
		sdm("Failed to load custom sprite: " + _filename);
		return _original_sprite;
	}
}