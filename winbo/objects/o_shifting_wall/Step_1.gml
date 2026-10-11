// Override the generic platform loop so only sliding walls lock at each end.
if(global.game_state == GameState.play){
	shifting_wall_motion_update(global.delta_time_factor_scaled);
}
