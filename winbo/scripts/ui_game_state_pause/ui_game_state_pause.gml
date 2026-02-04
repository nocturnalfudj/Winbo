/// @function ui_game_state_pause
/// @summary Step logic when the game is paused.
/// @returns {void} No return value.
function ui_game_state_pause() {
	//Mouse & Touch Interaction
	ui_mouse_interaction();

	//Pause Check
	game_pause_check();
}