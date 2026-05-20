switch(global.game_state){
	case GameState.play:
		x += velocity_x * global.delta_time_factor_scaled;
		y += velocity_y * global.delta_time_factor_scaled;
		velocity_y += gravity * global.delta_time_factor_scaled;
		lifetime -= global.delta_time_factor_scaled;
		image_alpha = max(0, lifetime / lifetime_max);

		if(lifetime <= 0){
			instance_destroy();
		}
	break;
}
