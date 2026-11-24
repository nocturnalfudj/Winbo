/// @function btn_pause_active_main
/// @summary Toggle between play and pause states when the button is pressed.
/// @returns {void} No return value.
function btn_pause_active_main(){
	if(toggle && global.game_state != GameState.pause){
		game_pause();
	}
	else if(!toggle && global.game_state == GameState.pause){
		game_unpause();
	}
}
