/// @function game_unpause
/// @summary Resume gameplay from a paused state.
function game_unpause(){
	//Go to Previous GameState
	game_state_set_target(o_master.pause_prev_game_state);
			
	//Remove Pause
	ui_anchor_remove(o_anchor_pause);
}