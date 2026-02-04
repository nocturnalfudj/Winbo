/// @function level_select_complete
/// @summary Mark a level as completed and unlock the next level in sequence.
/// @param {string|asset.GMRoom} _level_identifier Level ID or room that was completed
/// @returns {bool} True if successful
function level_select_complete(_level_identifier) {
	var _level_data = level_select_get_data(_level_identifier);
	
	if (is_undefined(_level_data)) {
		return false;
	}
	
	// Mark as completed
	_level_data.completed = true;
	
	// Unlock the next level in sequence
	var _next_level = level_select_get_next_level(_level_identifier);
	if (!is_undefined(_next_level)) {
		_next_level.unlocked = true;
		sdm("Level completed: " + _level_data.name + " | Unlocked: " + _next_level.name, LOG_COLOUR_COMMAND_SUCCESS);
	}
	else {
		sdm("Level completed: " + _level_data.name, LOG_COLOUR_COMMAND_SUCCESS);
	}
	
	return true;
}
