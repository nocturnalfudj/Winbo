/// @function window_state_down
/// @summary Manage mouse button down behavior for a window widget.
/// @returns {void} Nothing.
function window_state_down() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;
	
	if((mouse_collision && mouse_collision_down_required) || (!mouse_collision_down_required)){
		var _mouse_button,_mouse_button_released;
		_mouse_button = mouse_check_button(mouse_control_button);
		_mouse_button_released = mouse_check_button_released(mouse_control_button);
	
		if(_mouse_button_released){
			//State to Active
			ui_object_state_set(UIState.active);
			
			//Finished with State
			_state_stop = true;
		}
		else if(!_mouse_button){
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
	
	//Custom Script
	var _stage;
	_stage = (_state_stop)? UIStateStage.stop : UIStateStage.main;
	ui_object_state_script_stage_execute(_state_current,_stage);
}