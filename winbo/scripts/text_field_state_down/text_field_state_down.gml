function text_field_state_down() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;

	if(mouse_collision){
		var _mouse_button,_mouse_button_released;
		_mouse_button = mouse_check_button(mb_left);
		_mouse_button_released = mouse_check_button_released(mb_left);

		if(_mouse_button_released && text_edit_enable){
			//Finished with State
			_state_stop = true;
		
			//State to Edit with Edit Prep
			text_field_edit_prep();
		}
		else if(mouse_collision){
			if(!_mouse_button_released && !_mouse_button){
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


	//Custom Script
	var _stage;
	_stage = (_state_stop)? UIStateStage.stop : UIStateStage.main;
	ui_object_state_script_stage_execute(_state_current,_stage);
}