/// director_gameplay_transition_resolve_request()
/// @param {struct} _request Active gameplay transition request.
/// @returns {bool} True when the request is valid and ready for the remaining phases.
function director_gameplay_transition_resolve_request(_request) {
	if(!is_struct(_request)){
		sdm("Gameplay transition resolve failed: request is not a struct", LOG_COLOUR_COMMAND_ERROR);
		return false;
	}
	
	if(!room_exists(_request.target_room)){
		sdm("Gameplay transition resolve failed: target room is invalid", LOG_COLOUR_COMMAND_ERROR);
		return false;
	}
	
	var _level_data;
	_level_data = level_select_get_data(_request.target_room);
	
	if(is_undefined(_request.environment_id)){
		if(!is_undefined(_level_data)){
			_request.environment_id = _level_data.environment_id;
		}
		else{
			_request.environment_id = director_environment_resolve_room(_request.target_room);
		}
	}
	
	var _load_groups;
	_load_groups = _request.load_groups;
	if(is_undefined(_load_groups)){
		if(!is_undefined(_level_data)){
			_load_groups = _level_data.load_groups;
		}
		else{
			_load_groups = ["game"];
		}
	}
	
	if(is_string(_load_groups)){
		_load_groups = [_load_groups];
	}
	if(array_length(_load_groups) <= 0){
		_load_groups = ["game"];
	}
	
	var _load_groups_clean;
	_load_groups_clean = array_create(array_length(_load_groups));
	for(var _i = 0; _i < array_length(_load_groups); _i++){
		_load_groups_clean[_i] = string(_load_groups[_i]);
	}
	_request.load_groups = _load_groups_clean;
	
	_request.target_game_state ??= GameState.play;
	_request.resolve_script ??= director_gameplay_transition_resolve_request;
	_request.teardown_script ??= director_room_exit_gameplay;
	_request.setup_script ??= director_room_enter_gameplay;
	_request.finalize_script ??= director_room_finalize_gameplay;
	
	return true;
}
