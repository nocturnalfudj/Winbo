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
	
	var _next_level = level_select_get_next_level(_level_id);
	
	// Set the presence exit target when this room routes back through the hub.
	if (!is_undefined(_next_level)) {
		o_director.next_level = _next_level.level_room;
	}
		else {
			o_director.next_level = _level_data.level_room;
		}
		
		if(global.game_state == GameState.menu){
			director_game_session_start_prepare();
		}
		
		var _started;
		_started = director_gameplay_transition_request(
			_level_data.level_room,
			director_gameplay_transition_options_build(_level_data.level_room, true, true, false)
		);
		if(!_started){
			return false;
		}
		
		sdm("Starting level: " + _level_data.name + " (" + _level_id + ")", LOG_COLOUR_COMMAND_SUCCESS);
		
		return _started;
	}
