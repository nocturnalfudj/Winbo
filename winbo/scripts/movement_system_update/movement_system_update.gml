/// @function movement_system_update
/// @summary Update movement physics for the current instance.
/// @param {real} [_time_scale_factor=1] Optional delta-time multiplier.
function movement_system_update(_time_scale_factor) {
	//Move Trapped
	if(move_trapped && move_trapped_free_self){
		acceleration.Set(0,0);
		acceleration.AddMagnitudeDirection(5,move_trapped_acceleration_direction);
	}
	
	//Gravity
	movement_gravity_update();
	
	//System Has Movement
	if(!velocity.EqualsValues(0,0) || !acceleration.EqualsValues(0,0) || (move_grounded)){
		_time_scale_factor ??= 1;
	
		//Detla Time Factor
		var _delta_time;
		if(time_scale_enable)
			_delta_time = global.delta_time_factor_scaled;
		else
			_delta_time = global.delta_time_factor;
		_delta_time *= _time_scale_factor;
		
		//Update Transform With Collision
		var _collision;
		//_delta_time = 1;
		//_delta_time *= _time_scale_factor;
		_collision = movement_transform_update_with_collision_direction(_delta_time,move_use_transform);

		//Update Velocity
		movement_velocity_update(_delta_time,_collision);
	}
	else{
		velocity_mag = 0;
		velocity_percent = 0;
		velocity_input_percent = 0;
		
		#region Round Position
			////TODO - Setup a toggle variable in the movement system to control whether this rounding logic executes
			////TODO - Setup a check to see if the rounding logic even needs to execut - no need to round if it's already int values
			
			//// Update object's position
		    //if(move_use_transform){
			//	// Get Transform
			//	var _transform = transform[TransformType.anchor];
			
			//	 // Get Old Coordinate Values
			//	var _x_old, _y_old;
		    //    with(_transform){
		    //        _x_old = value[TransformValue.x].current;
		    //        _y_old = value[TransformValue.y].current;
		    //    }
			
		    //    // Update Transform
		    //    transform_set(_transform, TransformValue.x, round(_x_old), false);
		    //    transform_set(_transform, TransformValue.y, round(_y_old), false);
		    //}
			//else{
		    //    x = round(x);
		    //    y = round(y);
		    //}
		#endregion
	}
	
	//Transform Effects
	movement_effects_update();
	
	//Reset Acceleration
	acceleration.Set(0,0);
}