/// @function text_button_state_active
/// @summary Active (pressed) state logic for text buttons.
/// @returns {void}
function text_button_state_active() {
	var _execute_active_script;
	_execute_active_script = false;

	//Toggle
	if(toggle_enable){
		if((!toggle_oneway_enable) || ((toggle_oneway_enable) && (toggle != toggle_oneway_direction))){
			//Update Toggle
			button_toggle_set(!toggle);
			text_button_toggle_text_update();
			
			//Execute Active Script
			_execute_active_script = true;

			if(toggle_group_enable && toggle_group_mono){
				with(o_text_button){
					if((id!=other.id) && (toggle_enable) && (toggle_group_enable) && (toggle_group == other.toggle_group)){
						//Update Toggle
						button_toggle_set(false);
						text_button_toggle_text_update();
				
						//State to Idle
						ui_object_state_set(UIState.idle);
					}
				}
			}
		}
	}
	else{
		_execute_active_script = true;
	}

	if(mouse_collision && !IS_MOBILE){
		//State to Hover
		ui_object_state_set(UIState.hover);
	}
	else{
		//State to Idle
		ui_object_state_set(UIState.idle);
	}

	//Custom Script
	if(_execute_active_script){
		ui_object_state_script_stage_execute(UIState.active,UIStateStage.main);
	}
}