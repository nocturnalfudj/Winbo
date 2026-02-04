/// @desc Stops the game session and returns to the menu
function btn_stop_active_main() {
	game_state_set_target(GameState.stop);
}