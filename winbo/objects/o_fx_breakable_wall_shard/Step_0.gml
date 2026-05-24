switch(global.game_state){
	case GameState.play:
		x += velocity_x * global.delta_time_factor_scaled;
		y += velocity_y * global.delta_time_factor_scaled;
		velocity_y += gravity * global.delta_time_factor_scaled;
		lifetime -= global.delta_time_factor_scaled;

		var _fade_time = max(1, lifetime_max - fade_delay);
		var _fade_lifetime = lifetime_max - fade_delay;

		if(lifetime > _fade_lifetime){
			image_alpha = 1;
		}
		else{
			image_alpha = max(0, lifetime / _fade_time);
		}

		if(lifetime <= 0){
			instance_destroy();
		}
	break;
}
