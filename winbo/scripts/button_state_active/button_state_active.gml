/// @desc Executes when a button is pressed down and held
function button_state_active() {
	var _execute_active_script;
	_execute_active_script = false;

	//Toggle
	if(toggle_enable){
		if((!toggle_oneway_enable) || ((toggle_oneway_enable) && (toggle != toggle_oneway_direction))){
			//Update Toggle State
			button_toggle_set(!toggle);
		
			//Execute Active Script
			_execute_active_script = true;
			
			//If Button is in a Toggle Group that can have only One Button Toggled
			if(toggle_group_enable && toggle_group_mono){
				//Go Through All Buttons
				with(o_button){
					//If Button is Another Button in Button Group
					if((id!=other.id) && (toggle_enable) && (toggle_group_enable) && (toggle_group == other.toggle_group)){
						//Update Toggle State to False
						button_toggle_set(false);
				
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