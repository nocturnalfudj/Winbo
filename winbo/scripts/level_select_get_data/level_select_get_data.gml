/// @function level_select_get_data
/// @summary Get level data by ID or room asset.
/// @param {string|asset.GMRoom} _identifier Level ID string or room asset
/// @returns {struct|undefined} LevelData struct or undefined if not found
function level_select_get_data(_identifier) {
	// If it's a string, look up directly
	if (is_string(_identifier)) {
		if (ds_map_exists(o_director.level_registry, _identifier)) {
			return o_director.level_registry[? _identifier];
		}
	}
	// If it's a room asset, search through registry
	else {
		var _key = ds_map_find_first(o_director.level_registry);
		while (!is_undefined(_key)) {
			var _level_data = o_director.level_registry[? _key];
			if (_level_data.level_room == _identifier) {
				return _level_data;
			}
			_key = ds_map_find_next(o_director.level_registry, _key);
		}
	}
	
	return undefined;
}
