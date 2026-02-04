/// @function ui_game_state_play
/// @summary Step logic when the game is in play state.
/// @returns {void} No return value.
function ui_game_state_play() {
	//Mouse & Touch Interaction
	ui_mouse_interaction();

	//Pause Check
	game_pause_check();
}