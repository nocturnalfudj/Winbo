/// @function btn_continue_active_main
/// @summary Resume gameplay when the continue button is activated.
/// @returns {void}
function btn_continue_active_main() {
	game_state_set_target(GameState.play);

	ui_anchor_remove(o_anchor_pause);
}