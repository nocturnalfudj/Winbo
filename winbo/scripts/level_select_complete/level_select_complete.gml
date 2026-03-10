/// @function level_select_complete
/// @summary Mark a level as completed and unlock the next campaign steps.
/// @param {string|asset.GMRoom} _level_identifier Level ID or room that was completed
/// @returns {bool} True if successful
function level_select_complete(_level_identifier) {
	var _level_data = level_select_get_data(_level_identifier);
	
	if (is_undefined(_level_data)) {
		return false;
	}
	
	// Mark as completed
	_level_data.completed = true;
	
	var _unlock_string = "";
	
	if (_level_data.transition_style == LEVEL_SELECT_TRANSITION_VIA_PRESENCE_HUB) {
		var _presence_data = level_select_get_data("presence");
		if (!is_undefined(_presence_data) && !_presence_data.unlocked) {
			_presence_data.unlocked = true;
			_unlock_string = _presence_data.name;
		}
	}
	
	// Unlock the next configured campaign room
	var _next_level = level_select_get_next_level(_level_identifier);
	if (!is_undefined(_next_level) && !_next_level.unlocked) {
		_next_level.unlocked = true;
		if (_unlock_string != "") {
			_unlock_string += ", ";
		}
		_unlock_string += _next_level.name;
	}
	
	if (_unlock_string != "") {
		sdm("Level completed: " + _level_data.name + " | Unlocked: " + _unlock_string, LOG_COLOUR_COMMAND_SUCCESS);
	}
	else {
		sdm("Level completed: " + _level_data.name, LOG_COLOUR_COMMAND_SUCCESS);
	}
	
	return true;
}
