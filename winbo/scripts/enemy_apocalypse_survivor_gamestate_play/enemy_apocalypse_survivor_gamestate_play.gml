function enemy_apocalypse_survivor_gamestate_play(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;
	
	#region Countdowns
		// Attack
		if(attack_countdown > 0){
			attack_countdown -= _delta_time_scaled;
		}
	#endregion

	// State Switch - using base enemy state functions for now
	switch(state){
		case EnemyState.create:
			enemy_state_create();
		break;

		case EnemyState.idle:
			enemy_apocalypse_survivor_state_idle();
		break;

		case EnemyState.move:
			enemy_apocalypse_survivor_state_move();
		break;

		case EnemyState.sheathe:
			enemy_state_sheathe();
		break;

		case EnemyState.startled:
			enemy_apocalypse_survivor_state_startled();
		break;
		
		case EnemyState.attack_telegraph:
			enemy_state_attack_telegraph();
		break;
		
		case EnemyState.attack_active:
			enemy_state_attack_active();
		break;
		
		case EnemyState.attack_recover:
			enemy_state_attack_recover();
		break;

		case EnemyState.death:
			enemy_apocalypse_survivor_state_death();
		break;

		case EnemyState.destroy:
			enemy_state_destroy();
		break;
	}

	#region Movement Update
		// Edge guard during attack states: prevent stepping off ledges while attacking
		if(state == EnemyState.attack_telegraph || state == EnemyState.attack_active || state == EnemyState.attack_recover){
			enemy_edge_guard_attack();
		}
		
		movement_system_update();

		// Stationary tracking
		if(velocity_mag > 0.05){
			stationary = false;
			stationary_time = 0;
		}
		else{
			stationary = true;
			stationary_time += _delta_time_scaled;
		}
	#endregion

	// Image Update
	image_system_update();

	// Transform Update
	transform_system_update();
}
