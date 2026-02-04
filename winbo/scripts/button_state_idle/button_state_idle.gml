/// @function button_state_idle
/// @summary Default idle logic executed each frame for buttons
function button_state_idle() {
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

	if(!_button_pushed && mouse_collision){
		if(input_active_pressed_required)
			_button_pushed = mouse_check_button_pressed(mouse_control_button);
		else
			_button_pushed = mouse_check_button(mouse_control_button);

		#region Mouse Hover
			//Mouse is over the button
			//but not being pressed
			if(!_button_pushed && (!IS_MOBILE)){
				//State to Hover
				ui_object_state_set(UIState.hover);

				//Finished with State
				_state_stop = true;
			}
		#endregion
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