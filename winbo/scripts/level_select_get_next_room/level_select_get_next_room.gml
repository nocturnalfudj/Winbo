/// @function level_select_get_next_room
/// @summary Get the next room asset in sequence.
/// @param {asset.GMRoom} _current_room Current room
/// @returns {asset.GMRoom} Next room asset
function level_select_get_next_room(_current_room) {
	var _next_level = level_select_get_next_level(_current_room);
	
	if (!is_undefined(_next_level)) {
		return _next_level.level_room;
	}
	
	// Fallback to test level if not found
	return r_game_level_0;
}
