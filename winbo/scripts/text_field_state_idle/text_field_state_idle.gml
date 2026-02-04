/// @function text_field_state_idle
/// @summary Idle state behaviour for text fields.
/// @returns {void}
function text_field_state_idle() {
	var _state_stop,_state_current;
	_state_stop = false;
	_state_current = state;

	if(mouse_collision){
		var _mouse_button;
		_mouse_button = mouse_check_button(mb_left);
	
		if(_mouse_button && text_edit_enable){
			//State to Down
			ui_object_state_set(UIState.down);
		
			//Finished with State
			_state_stop = true;
		}
		else if(!IS_MOBILE){
			//State to Hover
			ui_object_state_set(UIState.hover);
		
			//Finished with State
			_state_stop = true;
		}
	}

	//Custom Script
	var _stage;
	_stage = (_state_stop)? UIStateStage.stop : UIStateStage.main;
	ui_object_state_script_stage_execute(_state_current,_stage);
}