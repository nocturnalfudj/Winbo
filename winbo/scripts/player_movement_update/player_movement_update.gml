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
		var _was_jump_grounded = jump_grounded;
		jump_grounded = player_jump_grounded();
		if(!swim_active && (state == PlayerState.move || state == PlayerState.float)
		&& jump_grounded && !_was_jump_grounded){
			player_land_begin();
			velocity.x = 0;
			acceleration.x = 0;
		}
	#endregion
}
