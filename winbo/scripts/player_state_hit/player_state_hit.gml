function player_state_hit(){
	// Make sure GameState is Player Hit
	if(global.game_state != GameState.play_player_hit){
		game_state_set_target(GameState.play_player_hit);
		global.game_state = global.game_state_target;
	}
	
	// Run Countdown
	hit_countdown.Update();
	
	// Countdown Finished
	if(hit_countdown.trigger_active){
		// Apply i-frames so we don't get hit again immediately
		status_effect_start(StatusEffect.invincible, SECOND * 2, noone);

		// Return to normal play state
		game_state_set_target(GameState.play);
		global.game_state = GameState.play;
		
		// Go back to previous state
		state = hit_state_previous;
	}
}