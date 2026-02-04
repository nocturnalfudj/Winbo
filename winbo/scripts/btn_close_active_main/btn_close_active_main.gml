/// @function btn_close_active_main
/// @summary Exit the game when the close button is activated.
function btn_close_active_main() {
	game_state_set_target(GameState.close);
}