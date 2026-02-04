/// @function player_input_aim_target_gamepad_thumbstick
/// @summary Update aim direction using the player's right thumbstick.
/// @param _gamepad_using Instance of the gamepad user.
function player_input_aim_target_gamepad_thumbstick(_gamepad_using){
	var _gamepad_device;
	_gamepad_device = user.input_device;
	
	#region Magnitude & Direction
		//Default Magnitude to 0
		input_aim_magnitude = 0;
	
		//Get Thumbstick Values
		var _thumbstick_h,_thumbstick_v,_aim_dir_target;
		_thumbstick_h = input_check_gamepad(_gamepad_device,gp_axislh);
		_thumbstick_v = input_check_gamepad(_gamepad_device,gp_axislv);
		
		//Thumbstick being Used
		if((_thumbstick_h != 0) || (_thumbstick_v != 0)){
			#region Direction
				_aim_dir_target = point_direction(0,0,_thumbstick_h,_thumbstick_v);
		
				if((_aim_dir_target < 90) && (input_aim_direction > 180))
					input_aim_direction -= 360;
				else if((_aim_dir_target > 190) && (input_aim_direction < 90))
					input_aim_direction += 360;
			
				var _aim_difference;
				_aim_difference = abs(input_aim_direction - _aim_dir_target);
			
				if(_aim_difference > 2)
					input_aim_direction = lerp(input_aim_direction,_aim_dir_target,0.3);
			#endregion
			
			//Magnitude
			input_aim_magnitude = point_distance(0,0,_thumbstick_h,_thumbstick_v);
			
			_gamepad_using = true;
		}
	#endregion
	
	if(_gamepad_using){
		var _input_aim_target_x,_input_aim_target_y;
		_input_aim_target_x = 0;
		_input_aim_target_y = 0;
				
		_input_aim_target_x += x;
		_input_aim_target_y += y;
				
		var _target_dist;
		_target_dist = lerp(GAMEPAD_DIST_MIN,GAMEPAD_DIST_MAX,input_aim_magnitude);
		_input_aim_target_x += lengthdir_x(_target_dist,input_aim_direction);
		_input_aim_target_y += lengthdir_y(_target_dist,input_aim_direction);
				
		var _x_difference,_y_difference;
		_x_difference = abs(input_aim_target_x - _input_aim_target_x);
		_y_difference = abs(input_aim_target_y - _input_aim_target_y);
				
		if(_x_difference > 5)
			input_aim_target_x = lerp(input_aim_target_x,_input_aim_target_x,0.3);
				
		if(_y_difference > 5)
			input_aim_target_y = lerp(input_aim_target_y,_input_aim_target_y,0.3);
					
		_input_aim_target_x = input_aim_target_x;
		_input_aim_target_y = input_aim_target_y;
				
		//Update Input Gamepad Aim Position
		user.gamepad_using = true;
		user.gamepad_aim_x = _input_aim_target_x;
		user.gamepad_aim_y = _input_aim_target_y;
	}
	
	return _gamepad_using;
}