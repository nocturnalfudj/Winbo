/// @function level_select_get_next_level
/// @summary Get the next level in sequence after the given level.
/// @param {string|asset.GMRoom} _current_identifier Current level ID or room
/// @returns {struct|undefined} Next LevelData struct or undefined if at end
function level_select_get_next_level(_current_identifier) {
	var _current_data = level_select_get_data(_current_identifier);
	
	if (is_undefined(_current_data)) {
		return undefined;
	}
	
	var _next_order = _current_data.order + 1;
	
	// Search for level with next order number
	var _key = ds_map_find_first(o_director.level_registry);
	while (!is_undefined(_key)) {
		var _level_data = o_director.level_registry[? _key];
		if (_level_data.order == _next_order) {
			return _level_data;
		}
		_key = ds_map_find_next(o_director.level_registry, _key);
	}
	
	// No next level found - loop back to first level (level_test)
	return level_select_get_data("level_test");
}
