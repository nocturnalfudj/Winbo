function enemy_space_ranger_gamestate_play(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;
	
	#region Countdowns
		// Attack
		if(attack_countdown > 0){
			attack_countdown -= _delta_time_scaled;
		}
	#endregion

	// State Switch - Using Space Ranger specific state functions where applicable
	switch(state){
		case EnemyState.create:
			enemy_space_ranger_state_create();
		break;

		case EnemyState.idle:
			enemy_space_ranger_state_idle();
		break;

		case EnemyState.move:
			enemy_space_ranger_state_move();
		break;

		case EnemyState.sheathe:
			enemy_space_ranger_state_sheathe();
		break;

		case EnemyState.startled:
			enemy_state_startled();
		break;
		
		case EnemyState.attack_telegraph:
			enemy_space_ranger_state_aim();
		break;
		
		case EnemyState.attack_active:
			enemy_space_ranger_state_attack();
		break;
		
		case EnemyState.attack_recover:
			enemy_state_attack_recover();
		break;

		case EnemyState.death:
			enemy_space_ranger_state_death();
		break;

		case EnemyState.destroy:
			enemy_state_destroy();
		break;
	}

	#region Movement Update
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
