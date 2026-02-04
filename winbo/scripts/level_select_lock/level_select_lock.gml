/// @function level_select_lock
/// @summary Lock a level by ID.
/// @param {string} _level_id Level identifier to lock
/// @returns {bool} True if successful
function level_select_lock(_level_id) {
	var _level_data = level_select_get_data(_level_id);
	
	if (is_undefined(_level_data)) {
		return false;
	}
	
	_level_data.unlocked = false;
	return true;
}
