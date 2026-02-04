/// @function movement_velocity_update
/// @summary Integrate velocity and apply collision constraints.
/// @param _delta_time Delta time in seconds.
/// @param _collision  Whether to respect collision flags.
function movement_velocity_update(_delta_time,_collision) {
	var _velocity_x,_velocity_y;
	_velocity_x = velocity.x;
	_velocity_y = velocity.y;
	_velocity_x += acceleration.x*_delta_time;
	_velocity_y += acceleration.y*_delta_time;
	
	#region Collision Reset
		if(_collision){
			if(collision.x == 1){
				if(sign(_velocity_x) > 0){
					_velocity_x = 0;
					acceleration.x = 0;
				}
			}
			else if(collision.x == -1){
				if(sign(_velocity_x) < 0){
					_velocity_x = 0;
					acceleration.x = 0;
				}
			}
	
			if(collision.y == 1){
				if(sign(_velocity_y) > 0){
					_velocity_y = 0;
					acceleration.y = 0;
				}
			}
			else if(collision.y == -1){
				if(sign(_velocity_y) < 0){
					_velocity_y = 0;
					acceleration.y = 0;
				}
			}
		}
	#endregion
	
	//Retention
	if(velocity_retention != 1){
		var _retention;
		_retention = power(velocity_retention,_delta_time);
		
		if(move_grounded_check && !move_grounded)
			_retention = velocity_retention_aerial;
		
		if(velocity_retention_enable.x)
			_velocity_x *= _retention;
			
		if(velocity_retention_enable.y)
			_velocity_y *= _retention;
	}
	
	//Zero Insignificant Values
	if(abs(_velocity_x) < 0.01) _velocity_x = 0;
	if(abs(_velocity_y) < 0.01) _velocity_y = 0;
	
	//Set Velocity
	velocity.Set(_velocity_x,_velocity_y);
	
	//Magnitude & Direction
	velocity_mag = velocity.Magnitude();
	velocity_dir = velocity.Direction();
	
	//Percent
	if(velocity_mag != 0){
		velocity_percent = velocity_mag/velocity_terminal;
		velocity_input_percent = velocity_mag/velocity_input_terminal;
	}
	else{
		velocity_percent = 0;
		velocity_input_percent = 0;
	}
	
		
	//Terminal Velocity Check & Clamp
	if(velocity_percent > 1){
		var _clamp_scale;
		_clamp_scale = velocity_terminal / velocity_mag;
		velocity.MultiplyFactor(_clamp_scale);
		velocity_mag = 1;
		velocity_percent = 1;
		velocity_input_percent = velocity_mag/velocity_input_terminal;
	}
}
