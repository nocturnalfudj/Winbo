/// @function movement_transform_update_with_collision
/// @summary Integrate velocity while handling collisions and transforms.
/// @param _delta_time        Time step in seconds.
/// @param _use_transform_anchor Whether to move via the anchor transform.
function movement_transform_update_with_collision(_delta_time,_use_transform_anchor) {
	//Check for No Movement
	if(velocity.EqualsValues(0,0) && acceleration.EqualsValues(0,0)){
		return false;
	}
	
	var _collision;
	_collision = false;

	var _displacement_x,_displacement_y;
	var _acceleration_multiplier;
	_acceleration_multiplier = 0.5*_delta_time;
	_displacement_x = (velocity.x + acceleration.x*_acceleration_multiplier)*_delta_time;
	_displacement_y = (velocity.y + acceleration.y*_acceleration_multiplier)*_delta_time;

	if(move_collision_object != noone){
		var _displacement_collision_sign;
		
		var _collision_x,_collision_y;
		_collision_x = false;
		_collision_y = false;
		collision.Set(0,0);
		
		#region X Collision
			if(_displacement_x != 0){	
				var _x_check,_displacement_x_sign_initial;
				_x_check = round(x + _displacement_x);
				_displacement_x_sign_initial = sign(_displacement_x);
				
				while(place_meeting(_x_check,y,move_collision_object)){
					_collision_x = true;
					
					_displacement_x -= _displacement_x_sign_initial;
					_displacement_collision_sign = sign(_displacement_x);
					
					_x_check = round(x + _displacement_x);
					
					
					if(_displacement_collision_sign != _displacement_x_sign_initial){
						_displacement_x = 0;
						sdm("pass here");
						break;
					}
					else{
						_displacement_x = _displacement_x;
					}
				}
				
				if(_collision_x){
					_collision = true;
					collision.x = _displacement_x_sign_initial;
					sdm("collision x : " + string(_displacement_x_sign_initial));
					sdm("velocity: " + string(velocity));
					sdm("acceleration: " + string(acceleration));
				}
			}
		#endregion
		
		#region Y Collsion
			if(_displacement_y != 0){	
				var _y_check,_displacement_y_sign_initial;
				_y_check = round(y + _displacement_y);
				_displacement_y_sign_initial = sign(_displacement_y);
				
				while(place_meeting(x,_y_check,move_collision_object)){
					_collision_y = true;
					
					_displacement_y -= _displacement_y_sign_initial;
					_displacement_collision_sign = sign(_displacement_y);
					
					_y_check = round(y + _displacement_y);
					
					
					if(_displacement_collision_sign != _displacement_y_sign_initial){
						_displacement_y = 0;
						sdm("pass here 2");
						break;
					}
					else{
						_displacement_y = _displacement_y;
					}
				}
				
				if(_collision_y){
					_collision = true;
					collision.y = _displacement_y_sign_initial;
					
					sdm("collision y : " + string(_displacement_y_sign_initial));
					sdm("velocity: " + string(velocity));
					sdm("acceleration: " + string(acceleration));
				}
			}
		#endregion
	}
	
	var _x_new,_y_new;
	var _x_old,_y_old;

	#region Update X & Y
		//Uses Transform for Movement
		if(_use_transform_anchor){
			//Get Transform
			var _transform;
			_transform = transform[TransformType.anchor];
			
			//Get Old Coordinate Values
			with(_transform){
				_x_old = value[TransformValue.x].current;
				_y_old = value[TransformValue.y].current;
			}
		}
		else{
			//Get Old Coordinate Values
			_x_old = x;
			_y_old = y;
		}
		
		//Calculate New Value
		_x_new = _x_old + _displacement_x;
		_y_new = _y_old + _displacement_y;
			
		//Round New Value if there was a Collision
		if(collision.x != 0)	_x_new = round(_x_old + _displacement_x);
		if(collision.y != 0)	_y_new = round(_y_old + _displacement_y);
		
		#region Limits
			var _limit_min,_limit_max;
			
			//X
			if(move_limit_enable_x){
				//Get Min & Max
				with(move_limit_x){
					_limit_min = x;
					_limit_max = y;
				}
				
				//Lower than Min Check
				if(_x_new < _limit_min){
					_x_new = _limit_min;
					collision.x = -1;
				}
				//Greater than Max Check
				else if(_x_new > _limit_max){
					_x_new = _limit_max;
					collision.x = 1;
				}
			}
			
			//Y
			if(move_limit_enable_y){
				//Get Min & Max
				with(move_limit_y){
					_limit_min = x;
					_limit_max = y;
				}
				
				//Lower than Min Check
				if(_y_new < _limit_min){
					_y_new = _limit_min;
					collision.y = -1;
				}
				//Greater than Max Check
				else if(_y_new > _limit_max){
					_y_new = _limit_max;
					collision.y = 1;
				}
			}
		#endregion
			
		//Update Coordinates
		if(_use_transform_anchor){
			//Update Transform
			if(_x_new != _x_old)	transform_set(_transform,TransformValue.x,_x_new,false);
			if(_y_new != _y_old)	transform_set(_transform,TransformValue.y,_y_new,false);
		}
		else{
			x = _x_new;
			y = _y_new;
		}
	#endregion

	#region Handle Other Collisions
		if(move_collision_object != noone){
			#region Trapped
				if(move_trapped_check){
					if((place_meeting(_x_new,_y_new,move_collision_object)) || (place_meeting(x,y,move_collision_object))){
						move_trapped = true;
		
						//acceleration.AddValue(1);
					}
					else{
						move_trapped = false;
					}
				}
			#endregion
		
			#region Grounded
				if(move_grounded_check){
					if(collision.y == 1 || (place_meeting(_x_new,_y_new+1,move_collision_object))){
						move_grounded = true;
					}
					else{
						move_grounded = false;
					}
				}
			#endregion
		}
	#endregion

	//Return Whether or Not there was a Collision
	return _collision;
}