/// @function btn_pause_idle_main
/// @summary Update button state visuals when not pressed.
/// @returns {void} No return value.
function btn_pause_idle_main(){
	if(global.game_state == GameState.pause){
		if(!toggle){
			button_toggle_set(!toggle);
		}
	}
	else{
		if(toggle){
			button_toggle_set(!toggle);
		}
	}
}