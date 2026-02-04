function enemy_gamestate_stop_game(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;

	//State Switch
	switch(state){
		case EnemyState.death:
			enemy_state_death();
		break;

		case EnemyState.destroy:
			enemy_state_destroy();
		break;
	}
	
	//Movement Update
	movement_system_update();

	//Transform Update
	transform_system_update();

	//PFX System Execute
	//pfx_system_execute();
}