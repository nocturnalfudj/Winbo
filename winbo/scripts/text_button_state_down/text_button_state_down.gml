/// @function text_button_state_down
/// @summary Update behaviour while a text button is pressed down.
function text_button_state_down() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;

	var _button_pushed,_button_released;
	_button_pushed = false;
	_button_released = false;

	if(keyboard_input_enable){
		_button_pushed = input_check_keyboard_mouse(input_keyboard_active);
		_button_released = input_check_keyboard_mouse_released(input_keyboard_active);
	}

	if(!_button_pushed && !_button_released && gamepad_input_enable){
		var _gamepad_dev;
		_gamepad_dev = global.gamepad_device_ui_control;
		_button_pushed = gamepad_button_check(_gamepad_dev,input_gamepad_active);
		_button_released = gamepad_button_check_released(_gamepad_dev,input_gamepad_active);
	}

	if(!_button_pushed && !_button_released){
		if(mouse_collision){
			_button_pushed = mouse_check_button(mouse_control_button);
			_button_released = mouse_check_button_released(mouse_control_button);
		
			if(!_button_pushed && !_button_released){
				if(!IS_MOBILE){
					//State to Hover
					ui_object_state_set(UIState.hover);
			
					//Finished with State
					_state_stop = true;
				}
				else{
					//State to Idle
					ui_object_state_set(UIState.idle);
			
					//Finished with State
					_state_stop = true;
				}
			}
		}
		else{
			//State to Idle
			ui_object_state_set(UIState.idle);
		
			//Finished with State
			_state_stop = true;
		}
	}

	if(_button_released){
		//State to Active
		ui_object_state_set(UIState.active);
			
		//Finished with State
		_state_stop = true;
	}
	
	//Custom Script
	var _stage;
	_stage = (_state_stop)? UIStateStage.stop : UIStateStage.main;
	ui_object_state_script_stage_execute(_state_current,_stage);
}