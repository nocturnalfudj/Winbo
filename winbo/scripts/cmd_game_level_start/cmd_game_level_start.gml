/// @function cmd_game_level_start
/// @summary Console command to start a specific level.
/// @param _subject Console subject (unused)
/// @param _argument_list Arguments: [level_id]
/// @returns {void}
function cmd_game_level_start(_subject, _argument_list) {
	var _level_id = _argument_list[| 0];
	
	// Try to start the level
	if (!level_select_start(_level_id)) {
		// If failed, list available levels
		sdm("Available levels:", LOG_COLOUR_COMMAND_ANALYSE);
		
		var _ids = level_select_get_all_ids();
		for (var _i = 0; _i < array_length(_ids); _i++) {
			var _data = level_select_get_data(_ids[_i]);
			var _status = _data.unlocked ? "" : " [LOCKED]";
			sdm("  " + _ids[_i] + " - " + _data.name + _status, LOG_COLOUR_COMMAND_ANALYSE);
		}
	}
}
