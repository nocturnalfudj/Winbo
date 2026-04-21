/// director_gameplay_transition_options_build()
/// @param {asset.GMRoom} _target_room Room to load.
/// @param {bool} _reset_level_timer Whether to reset the level timer after entering the room.
/// @param {bool} _reset_level_stats Whether to reset level stats after entering the room.
/// @param {bool} [_start_black=false] Whether the loading overlay should begin fully black.
/// @param {real} [_target_game_state=GameState.play] Game state to enter when loading finishes.
/// @param {real} [_player_spawn_context=PlayerSpawnContext.none] Player spawn context to apply after room entry.
/// @returns {struct} Canonical gameplay transition options struct.
function director_gameplay_transition_options_build(_target_room, _reset_level_timer, _reset_level_stats, _start_black = false, _target_game_state = GameState.play, _player_spawn_context = PlayerSpawnContext.none) {
	var _level_data;
	_level_data = level_select_get_data(_target_room);
	
	var _environment_id;
	if(!is_undefined(_level_data)){
		_environment_id = _level_data.environment_id;
	}
	else{
		_environment_id = director_environment_resolve_room(_target_room);
	}
	
	var _load_groups;
	if(!is_undefined(_level_data)){
		_load_groups = _level_data.load_groups;
	}
	else{
		_load_groups = ["game"];
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
	
	return {
		environment_id: _environment_id,
		load_groups: _load_groups_clean,
		reset_level_timer: _reset_level_timer,
		reset_level_stats: _reset_level_stats,
		start_black: _start_black,
		target_game_state: _target_game_state,
		player_spawn_context: _player_spawn_context,
		resolve_script: director_gameplay_transition_resolve_request,
		teardown_script: director_room_exit_gameplay,
		setup_script: director_room_enter_gameplay,
		finalize_script: director_room_finalize_gameplay
	};
}

function director_player_spawn_context_for_room_entry(_target_room) {
	return (_target_room == r_game_level_presence)
		? PlayerSpawnContext.presence_start
		: PlayerSpawnContext.level_start;
}
