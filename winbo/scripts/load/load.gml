/// @function load
/// @summary Retrieve a value from the save map.
/// @param {string} _map_key_string Key string in the map.
/// @returns {any} Stored value or undefined.
function load(_map_key_string){
	var _save_map_val;
	_save_map_val = save_map[? _map_key_string];
	
	if(!is_undefined(_save_map_val)){
		return _save_map_val;
	}
	else{
		sdm(bad_load_string + _map_key_string);
			
		bad_load = true;
		
		return undefined;
	}
}