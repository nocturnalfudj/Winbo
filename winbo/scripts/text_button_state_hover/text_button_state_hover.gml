/// @function text_button_state_hover
/// @summary State logic when a text button is hovered by input.
/// @returns {void}
function text_button_state_hover() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;

	var _button_pushed;
	_button_pushed = false;

	if(keyboard_input_enable){
		if(input_active_pressed_required)
			_button_pushed = input_check_keyboard_mouse_pressed(input_keyboard_active);
		else
			_button_pushed = input_check_keyboard_mouse(input_keyboard_active);
	}

	if(!_button_pushed && gamepad_input_enable){
		if(input_active_pressed_required)
			_button_pushed = gamepad_button_check_pressed(global.gamepad_device_ui_control,input_gamepad_active);
		else
			_button_pushed = gamepad_button_check(global.gamepad_device_ui_control,input_gamepad_active);
	}

	if(!_button_pushed){
		//Mouse is Over Button
		if(mouse_collision){
			if(input_active_pressed_required)
				_button_pushed = mouse_check_button_pressed(mouse_control_button);
			else
				_button_pushed = mouse_check_button(mouse_control_button);
		}
		//Mouse is Not Over Button
		//So return to Idle
		else{
			//State to Idle
			ui_object_state_set(UIState.idle);
		
			//Finished with State
			_state_stop = true;
		}
	}

	if(_button_pushed){
		//State to Down
		ui_object_state_set(UIState.down);
		
		//Finished with State
		_state_stop = true;
	}	
	
	//Custom Script
	var _stage;
	_stage = (_state_stop)? UIStateStage.stop : UIStateStage.main;
	ui_object_state_script_stage_execute(_state_current,_stage);
}