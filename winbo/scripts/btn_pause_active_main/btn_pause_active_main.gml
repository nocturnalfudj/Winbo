/// @function btn_pause_active_main
/// @summary Toggle between play and pause states when the button is pressed.
/// @returns {void} No return value.
function btn_pause_active_main(){
	if(toggle){
		if(global.game_state != GameState.pause){
			//Go To Pause Game State
			game_state_set_target(GameState.pause);
			
			//Add Pause
			ui_anchor_create(o_anchor_pause,"lyr_pause");
		}
	}
	else{
		if(global.game_state != GameState.play){
			//Go to Play GameState
			game_state_set_target(GameState.play);
			
			//Remove Pause
			ui_anchor_remove(o_anchor_pause);
		}
	}
}