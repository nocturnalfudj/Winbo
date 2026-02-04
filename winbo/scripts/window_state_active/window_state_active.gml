/// @function window_state_active
/// @summary Handle the window's active (pressed) state.
/// @returns {void} Nothing.
function window_state_active() {
	if(mouse_collision && !IS_MOBILE){
		//State to Hover
		ui_object_state_set(UIState.hover);
	}
	else{
		//State to Idle
		ui_object_state_set(UIState.idle);
	}

	//Custom Script
	ui_object_state_script_stage_execute(UIState.active,UIStateStage.main);
}