/// @function master_os_paused_check
/// @summary Pause the game when the operating system is paused.
function master_os_paused_check() {
	if(os_is_paused()){
		os_paused_prev_game_state = global.game_state;
		game_state_set_target(GameState.os_paused);
		alarm[MasterAlarm.os_pause_delay] = os_paused_unpause_delay;
	}
}