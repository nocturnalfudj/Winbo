function player_movement_update(){
	var _delta_time_scaled;
	_delta_time_scaled = global.delta_time_factor_scaled;
	
	movement_system_update();
	
	//Stationary
	if(velocity_mag > 0.05){
		stationary = false;
		stationary_time = 0;
	}
	else{
		stationary = true;
		stationary_time += _delta_time_scaled;
	}
		
	if(second_jump_landing_armed && !move_grounded) second_jump_airborne_seen = true;

	#region Landing
		if(!swim_active && (state == PlayerState.move || state == PlayerState.float)
		&& move_grounded && !move_grounded_previous){
			var _land = player_second_jump_landed();
			image_system_setup(_land, ANIMATION_FPS_DEFAULT, true, false, 0, IMAGE_LOOP_FULL);
			velocity.x = 0;
			acceleration.x = 0;
		}
	#endregion
}
