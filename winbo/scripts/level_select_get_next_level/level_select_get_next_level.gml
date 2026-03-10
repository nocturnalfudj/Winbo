/// @function level_select_get_next_level
/// @summary Get the next configured campaign level after the given level.
/// @param {string|asset.GMRoom} _current_identifier Current level ID or room
/// @returns {struct|undefined} Next LevelData struct or undefined if at end
function level_select_get_next_level(_current_identifier) {
	var _current_data = level_select_get_data(_current_identifier);
	
	if (is_undefined(_current_data)) {
		return undefined;
	}
	
	if (!is_undefined(_current_data.next_level_id)) {
		var _next_level = level_select_get_data(_current_data.next_level_id);
		if (!is_undefined(_next_level)) {
			return _next_level;
		}
	}
	
	// No next level found - loop back to first playable level (level_0)
	return level_select_get_data("level_0");
}
