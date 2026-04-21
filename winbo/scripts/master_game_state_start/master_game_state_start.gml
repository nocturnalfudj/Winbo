/// @function master_game_state_start
/// @summary Transition from the boot state into gameplay.
/// @returns {void}
function master_game_state_start() {
	if(!o_master.gameplay_loading_active && o_master.gameplay_loading_request == noone){
		director_game_session_start_prepare();
		director_gameplay_transition_request(
			o_director.campaign_entry_room,
			director_gameplay_transition_options_build(
				o_director.campaign_entry_room,
				true,
				true,
				false,
				GameState.play,
				director_player_spawn_context_for_room_entry(o_director.campaign_entry_room)
			)
		);
	}
}
