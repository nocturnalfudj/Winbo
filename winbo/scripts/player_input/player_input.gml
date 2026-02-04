/// @function player_input
/// @summary Poll keyboard, mouse and gamepad input for the player.
function player_input(){
	//Update Input Control System
	input_control_system_update();
	
	#region Mobile
		if(IS_MOBILE){
			var _mouse_gui,_mouse_gui_x,_mouse_gui_y;
			_mouse_gui = o_ui.mouse_gui;
			
			//Loop Through All Possible Inputs
			for(var _i=0;_i<MOUSE_INPUT_COUNT;_i++){
				//Get X Position
				_mouse_gui_x = _mouse_gui[_i].x;
				
				//If Pressed & On Left Side of Screen
				if((device_mouse_check_button_pressed(_i,mb_left)) && (_mouse_gui_x < o_camera.width_half)){
					//Get Y Position
					_mouse_gui_y = _mouse_gui[_i].y;
					
					//Update Thumbstick Start Position
					input_mobile_thumbstick_start_x = _mouse_gui_x;
					input_mobile_thumbstick_start_y = _mouse_gui_y;
					
					//Update Input Device
					input_mobile_mouse_device = _i;
				}
			}
		
			if(device_mouse_check_button(input_mobile_mouse_device,mb_left)){
				#region Movement
					var _thumbstick_x,_thumbstick_y;
					_thumbstick_x = _mouse_gui[input_mobile_mouse_device].x;
				
					if(_thumbstick_x < o_camera.width_half){
						_thumbstick_y = _mouse_gui[input_mobile_mouse_device].y;
			
						var _thumbstick_dir,_thumbstick_dist,_thumbstick_mag,_thumbstick_rad;
						_thumbstick_dir = point_direction(input_mobile_thumbstick_start_x,input_mobile_thumbstick_start_y,_thumbstick_x,_thumbstick_y);
						_thumbstick_dist = point_distance(input_mobile_thumbstick_start_x,input_mobile_thumbstick_start_y,_thumbstick_x,_thumbstick_y);
			
						_thumbstick_rad = 100;
						_thumbstick_mag = _thumbstick_dist/_thumbstick_rad;
			
						if(_thumbstick_mag > 1){
							var _thumbstick_node_update_len;
							_thumbstick_node_update_len = (_thumbstick_mag-1)*_thumbstick_rad;
							input_mobile_thumbstick_start_x += lengthdir_x(_thumbstick_node_update_len,_thumbstick_dir);
							input_mobile_thumbstick_start_y += lengthdir_y(_thumbstick_node_update_len,_thumbstick_dir);
						}
			
						_thumbstick_mag = min(1,_thumbstick_mag);
			
						input_move_direction = _thumbstick_dir;
						input_move_magnitude = _thumbstick_mag;
					}
				#endregion
			
				//Aim & Attack
				input_current[UserControl.attack] = false;
				input_aim_direction = input_move_direction;
				input_aim_target_x = x + lengthdir_x(GAMEPAD_DIST_MAX,input_aim_direction);
				input_aim_target_y = y + lengthdir_y(GAMEPAD_DIST_MAX,input_aim_direction);
			}
			else{
				//Do Not Shoot if Not Pressing
				input_current[UserControl.attack] = false;
			}
			
			//No Need to Consider Other Inputs so Exit
			exit;
		}
	#endregion
	
	var _gamepad_using,_gamepad_device;
	if(GAMEPAD_ENABLE){
		_gamepad_using = user.gamepad_using;
		_gamepad_device = user.input_device;
	}
	else{
		_gamepad_using = false;
		_gamepad_device = 0;
	}
	
	#region Movement
		//Gamepad Thumbstick
		var _gamepad_thumbstick_check_enable;
		_gamepad_thumbstick_check_enable = false;
	
		#region Check Inputs
			var _user_input,_key,_key_gamepad;
			_user_input = user.input;
			
			//Must be a Valid Input Type to Check
			if(_user_input >= 0){
				//Input Current Values
				switch(_user_input){
					case Input.keyboard:
						for(var _i=0;_i<UserControl.SIZE;_i++){
							_key = user.control[_i].input[_user_input][InputProperty.key];
							input_current[_i] = keyboard_check(_key);
						}
					break;
					
					case Input.mouse:
						for(var _i=0;_i<UserControl.SIZE;_i++){
							_key = user.control[_i].input[_user_input][InputProperty.key];
							input_current[_i] = mouse_check_button(_key);
						}
					break;
			
					case Input.mouse_and_keyboard:
						for(var _i=0;_i<UserControl.SIZE;_i++){
							_key = user.control[_i].input[_user_input][InputProperty.key];
							input_current[_i] = input_check_keyboard_mouse(_key);
						}
					break;
			
					case Input.gamepad:
						for(var _i=0;_i<UserControl.SIZE;_i++){
							_key = user.control[_i].input[_user_input][InputProperty.key];
							input_current[_i] = input_check_gamepad(_gamepad_device,_key);
						}
					
						//Check Gamepad
						_gamepad_thumbstick_check_enable = true;
					break;
					
					case Input.mouse_and_keyboard_and_gamepad:
						for(var _i=0;_i<UserControl.SIZE;_i++){
							_key = user.control[_i].input[Input.mouse_and_keyboard][InputProperty.key];
							_key_gamepad = user.control[_i].input[Input.gamepad][InputProperty.key];
					
							if(_i == UserControl.attack){
								//Make Sure User is Not Interacting with UI before Checking For Click Attack
								if(o_ui.mouse_collision_any == false)
									input_current[_i] = input_check_keyboard_mouse(_key) || input_check_gamepad(_gamepad_device,_key_gamepad);
							}
							else{
								input_current[_i] = input_check_keyboard_mouse(_key) || input_check_gamepad(_gamepad_device,_key_gamepad);
							}
						}
				
						//Check Gamepad
						_gamepad_thumbstick_check_enable = true;
					break;
				}
			}
		#endregion
		
		//Up Down
		var _input_y;
		_input_y = 0;
		//_input_y = input_current[UserControl.down] - input_current[UserControl.up];
		//if((_input_y == 0) && (_gamepad_thumbstick_check_enable)){
		//	_input_y = input_check_gamepad(_gamepad_device,gp_axislv);
		//	if(_input_y != 0)
		//		_gamepad_using = true;
		//}
	
		//Left Right
		var _input_x;
		_input_x = input_current[UserControl.right] - input_current[UserControl.left];
		if((_input_x == 0) && (_gamepad_thumbstick_check_enable)){
			_input_x = input_check_gamepad(_gamepad_device,gp_axislh);
			if(_input_x != 0)
				_gamepad_using = true;
		}
		
		//Calculate Movement Direction
		input_move_direction = point_direction(0,0,_input_x,_input_y);
		
		//Calculate Movement Magnitude
		if(_gamepad_using)
			input_move_magnitude = point_distance(0,0,_input_x,_input_y);
		else
			input_move_magnitude = ((_input_x != 0) || (_input_y != 0));
	#endregion
	
	#region Aim Direction
		switch(user.input){
			case Input.keyboard:
			case Input.mouse_and_keyboard:
				input_aim_direction = point_direction(x,y,mouse_x,mouse_y);
	
				input_aim_target_x = mouse_x;
				input_aim_target_y = mouse_y;
			break;
			
			case Input.gamepad:
				 player_input_aim_target_gamepad_thumbstick(_gamepad_using);
			break;
			
			case Input.mouse_and_keyboard_and_gamepad:
				//Gamepad Shoot Direction
				if(GAMEPAD_ENABLE){
					_gamepad_using = player_input_aim_target_gamepad_thumbstick(_gamepad_using);
				}
			
				//Mouse
				if(!_gamepad_using){
					input_aim_direction = point_direction(x,y,mouse_x,mouse_y);
	
					input_aim_target_x = mouse_x;
					input_aim_target_y = mouse_y;
				}
			break;
		}
	#endregion
	
	if(input_move_magnitude > 0)
		input_aim_direction = input_move_direction;
}