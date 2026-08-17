switch(global.game_state){
	case GameState.play:
		ash_lifetime -= global.delta_time_factor_scaled;

		var _fade_lifetime = ash_lifetime_max - ash_fade_delay;
		if(ash_lifetime <= _fade_lifetime){
			image_alpha = ash_alpha_max * max(0, ash_lifetime / max(1, _fade_lifetime));
		}

		if(ash_lifetime <= 0){
			instance_destroy();
		}
	break;
}
