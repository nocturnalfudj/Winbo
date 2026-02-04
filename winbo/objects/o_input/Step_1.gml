//Gamepad
if(GAMEPAD_ENABLE){
	//Rumble Update
	gamepad_rumble_update();
	
	//Gamepad Using
	if(user[0].gamepad_using){
		cursor_sprite = noone;
	}
}

#region User Input
	for(var _user=0;_user<USER_NUM_MAX;_user++){
		with(user[_user]){
			//Update Input Control System
			input_control_system_update();
		
			var _gamepad_using,_gamepad_device;
			if(GAMEPAD_ENABLE){
				_gamepad_using = gamepad_using;
				_gamepad_device = input_device;
			}
			else{
				_gamepad_using = false;
				_gamepad_device = 0;
			}
		
			//Gamepad Thumbstick
			var _gamepad_thumbstick_check_enable;
			_gamepad_thumbstick_check_enable = false;
	
			#region Check Inputs
				var _user_input,_key,_key_gamepad;
				_user_input = input;
			
				//Must be a Valid Input Type to Check
				if(_user_input >= 0){
					//Input Current Values
					switch(_user_input){
						case Input.keyboard:
							for(var _i=0;_i<UserControl.SIZE;_i++){
								_key = control[_i].input[_user_input][InputProperty.key];
								input_current[_i] = keyboard_check(_key);
							}
						break;
					
						case Input.mouse:
							for(var _i=0;_i<UserControl.SIZE;_i++){
								_key = control[_i].input[_user_input][InputProperty.key];
								input_current[_i] = mouse_check_button(_key);
							}
						break;
			
						case Input.mouse_and_keyboard:
							for(var _i=0;_i<UserControl.SIZE;_i++){
								_key = control[_i].input[_user_input][InputProperty.key];
								input_current[_i] = input_check_keyboard_mouse(_key);
							}
						break;
			
						case Input.gamepad:
							for(var _i=0;_i<UserControl.SIZE;_i++){
								_key = control[_i].input[_user_input][InputProperty.key];
								input_current[_i] = input_check_gamepad(_gamepad_device,_key);
							}
					
							//Check Gamepad
							_gamepad_thumbstick_check_enable = true;
						break;
					
						case Input.mouse_and_keyboard_and_gamepad:
							for(var _i=0;_i<UserControl.SIZE;_i++){
								_key = control[_i].input[Input.mouse_and_keyboard][InputProperty.key];
								_key_gamepad = control[_i].input[Input.gamepad][InputProperty.key];
					
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
		}
	}
#endregion