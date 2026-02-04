function enemy_apocalypse_survivor_state_move(){
	// Relaxed patrol pause logic
	if(!is_hostile){
		if(patrol_pause_cooldown > 0){
			patrol_pause_cooldown -= (time_scale_enable ? global.delta_time_factor_scaled : global.delta_time_factor);
		}
		else if(random(1) < patrol_pause_chance){
			patrol_pause_timer = random_range(patrol_pause_min, patrol_pause_max);
			patrol_pause_cooldown = patrol_pause_cooldown_max;
			state = EnemyState.idle;
			velocity.x = 0;
			acceleration.x = 0;
			input_move_magnitude = 0;
			return;
		}
	}
	else{
		// Hostile posture: kneel/aim and hold position (no chase movement)
		is_kneeling = true;

		// Track aim angle continuously while hostile
		target_update(TargetType.attack);
		aim_angle = point_direction(x, y, target[TargetType.attack].x, target[TargetType.attack].y);
	}

	// If de-aggro resets hostility, clear kneel flag
	if(!is_hostile && is_kneeling){
		is_kneeling = false;
	}

	// Disable grounded movement while hostile (aim in place)
	if(is_hostile){
		var _move_grounded_prev = move_grounded;
		move_grounded = false;
		enemy_state_move();
		move_grounded = _move_grounded_prev;
		return;
	}

	// Default movement logic
	enemy_state_move();
}
