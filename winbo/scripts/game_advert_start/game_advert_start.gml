/// @function game_advert_start
/// @summary Transition into the advertisement game state.
/// @returns {void}
function game_advert_start() {
	if(global.game_state != GameState.advert){
		with(o_master){
			advert_active = true;
			
			advert_game_state_prev = global.game_state;
			game_state_set_target(GameState.advert);
			
			//Reset Foced Exit Countdown
			advert_force_exit_countdown.Reset();
		}
	}
}