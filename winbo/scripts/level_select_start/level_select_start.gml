/// @function level_select_start
/// @summary Start a specific level by ID. Bypasses presence room - goes directly to level.
/// @param {string} _level_id Level identifier to start
/// @returns {bool} True if level started successfully, false otherwise
function level_select_start(_level_id) {
	var _level_data = level_select_get_data(_level_id);
	
	if (is_undefined(_level_data)) {
		sdm("Level not found: " + _level_id, LOG_COLOUR_COMMAND_ERROR);
		return false;
	}
	
	if (!_level_data.unlocked) {
		sdm("Level is locked: " + _level_id, LOG_COLOUR_COMMAND_ERROR);
		return false;
	}
	
	// Set the next level in director (for door transitions within the level)
	o_director.next_level = _level_data.level_room;
	
	// Set flag to prevent life deduction during transition
	o_director.level_transitioning = true;
	
	// Go directly to the level room (bypass presence)
	room_goto(_level_data.level_room);
	
	// Set game state to play
	global.game_state = GameState.play;
	global.game_state_target = noone;
	
	sdm("Starting level: " + _level_data.name + " (" + _level_id + ")", LOG_COLOUR_COMMAND_SUCCESS);
	
	return true;
}
