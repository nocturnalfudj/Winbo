/// @function cmd_game_level_unlock
/// @summary Console command to unlock a specific level or all levels.
/// @param _subject Console subject (unused)
/// @param _argument_list Arguments: [level_id or "all"]
/// @returns {void}
function cmd_game_level_unlock(_subject, _argument_list) {
	var _level_id = _argument_list[| 0];
	
	// Check if unlocking all levels
	if (_level_id == "all") {
		level_select_unlock_all();
		return;
	}
	
	// Try to unlock specific level
	if (level_select_unlock(_level_id)) {
		var _level_data = level_select_get_data(_level_id);
		sdm("Unlocked level: " + _level_data.name + " (" + _level_id + ")", LOG_COLOUR_COMMAND_SUCCESS);
	}
	else {
		sdm("Level not found: " + _level_id, LOG_COLOUR_COMMAND_ERROR);
		
		// List available levels
		sdm("Available levels:", LOG_COLOUR_COMMAND_ANALYSE);
		var _ids = level_select_get_all_ids();
		for (var _i = 0; _i < array_length(_ids); _i++) {
			var _data = level_select_get_data(_ids[_i]);
			var _status = _data.unlocked ? " [UNLOCKED]" : " [LOCKED]";
			sdm("  " + _ids[_i] + " - " + _data.name + _status, LOG_COLOUR_COMMAND_ANALYSE);
		}
	}
}
