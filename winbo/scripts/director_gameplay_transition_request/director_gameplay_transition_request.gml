/// director_gameplay_transition_request()
/// @param {asset.GMRoom} _target_room Room to load.
/// @param {struct} _options Canonical transition options built by director_gameplay_transition_options_build().
/// @returns {bool} True if the request was accepted.
function director_gameplay_transition_request(_target_room, _options) {
	if(!room_exists(_target_room)){
		sdm("Gameplay transition target room is invalid", LOG_COLOUR_COMMAND_ERROR);
		return false;
	}
	
	if(o_master.gameplay_loading_active || o_master.gameplay_loading_request != noone){
		sdm("Gameplay transition ignored while another transition is active", LOG_COLOUR_COMMAND_ERROR);
		return false;
	}
	
	if(!is_struct(_options)){
		sdm("Gameplay transition request requires canonical options from director_gameplay_transition_options_build", LOG_COLOUR_COMMAND_ERROR);
		return false;
	}
	
	var _request;
	_request = {
		origin_game_state: global.game_state,
		target_room: _target_room,
		environment_id: _options.environment_id,
		load_groups: _options.load_groups,
		reset_level_timer: _options.reset_level_timer,
		reset_level_stats: _options.reset_level_stats,
		start_black: _options.start_black,
		target_game_state: _options.target_game_state,
		resolve_script: _options.resolve_script,
		teardown_script: _options.teardown_script,
		setup_script: _options.setup_script,
		finalize_script: _options.finalize_script
	};
	
	o_director.level_transitioning = true;
	with(o_master){
		gameplay_loading_request = _request;
		gameplay_loading_phase = GameplayLoadingPhase.transition_in;
		gameplay_loading_active = true;
	}
	
	return true;
}
