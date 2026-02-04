/// @function player_state_dash
/// @summary Execute the player's dash maneuver.
/// @returns {void} No return value.
function player_state_dash(){
	var _delta_time_factor_scaled;
	_delta_time_factor_scaled = global.delta_time_factor_scaled;
	
	//Bump Allow Countdown
	bump_allow_countdown = bump_allow_countdown_max;
	
	#region Dash Input
		//Update Input Control System
		input_control_system_update();
		
		#region Check Inputs
			var _user_input,_key,_key_gamepad;
			_user_input = user.input;
			
			var _gamepad_using,_gamepad_device;
			if(GAMEPAD_ENABLE){
				_gamepad_using = user.gamepad_using;
				_gamepad_device = user.input_device;
			}
			else{
				_gamepad_using = false;
				_gamepad_device = 0;
			}
			
			//Must be a Valid Input Type to Check
			if(_user_input >= 0){
				//Input Current Values
				switch(_user_input){
					case Input.keyboard:
						_key = user.control[UserControl.dash].input[_user_input][InputProperty.key];
						input_current[UserControl.dash] = keyboard_check(_key);
					break;
					
					case Input.mouse:
						_key = user.control[UserControl.dash].input[_user_input][InputProperty.key];
						input_current[UserControl.dash] = mouse_check_button(_key);
					break;
			
					case Input.mouse_and_keyboard:
							_key = user.control[UserControl.dash].input[_user_input][InputProperty.key];
							input_current[UserControl.dash] = input_check_keyboard_mouse(_key);
					break;
			
					case Input.gamepad:
						_key = user.control[UserControl.dash].input[_user_input][InputProperty.key];
						input_current[UserControl.dash] = input_check_gamepad(_gamepad_device,_key);
					break;
					
					case Input.mouse_and_keyboard_and_gamepad:
						_key = user.control[UserControl.dash].input[Input.mouse_and_keyboard][InputProperty.key];
						_key_gamepad = user.control[UserControl.dash].input[Input.gamepad][InputProperty.key];
					
						input_current[UserControl.dash] = input_check_keyboard_mouse(_key) || input_check_gamepad(_gamepad_device,_key_gamepad);
					break;
				}
			}
		#endregion
	#endregion
	
	#region Dash Hold
		//Dash Not Held by Default
		var _dash_held;
		_dash_held = false;
	
		//Can Dash Hold
		if(dash_hold_enable){
			//If Dash Input Ever Released
			if(!input_current[UserControl.dash]){
				//Complete Dash Hold Allow Countdown
				//So even if the check countdown completes - allowed dash hold time will be 0
				dash_hold_allow_countdown = 0;
			}
			
			//Check Countdown Running Down
			if(dash_hold_check_countdown > 0){
				dash_hold_check_countdown -= _delta_time_factor_scaled;
			}
			//Check Countdown Complete - Can Check for Dash Hold
			else{
				//Dash Input Held
				if(input_current[UserControl.dash]){
					//Dash Hold Allow Countdown Running Down
					if(dash_hold_allow_countdown > 0){
						//Decrease Countdown
						dash_hold_allow_countdown -= _delta_time_factor_scaled;
						
						//Flag Dash Held
						_dash_held = true;
					}
				}
			}
		}
	#endregion
	
	//Dash CountDown
	if(dash_countdown > 0){
		//Countdown Decrease
		dash_countdown -= _delta_time_factor_scaled;
		
		//Input Acceleration
		acceleration.AddMagnitudeDirection(dash_acceleration,input_move_direction);
	}
	else if(!_dash_held){
		//Countdown Finished
		state = PlayerState.move;
		
		//Reset Velocity Retention
		velocity_retention = velocity_retention_default;
		
		//Disable Speed Stretch
		speed_stretch_enable = false;
		
		//Start Invincible
		//status_effect_start(StatusEffect.invincible_dash,0.5*SECOND);
	}
	
	//Update Health
	character_health();
	
	//Face
	character_face(false);
	
	//Dash
	character_dash();
	
	#region PFX
		//if(irandom(100) > 10){
		//	//Trigger Dash PFX
		//	pfx_trigger(PFXPlayer.dash);
		//}
	#endregion
	
	//Collision Situations
	player_collisions();
	
	//Movement Update
	player_movement_update();
}