function control_map_active_main() {
	//Check if other Control Map Buttons are in Choose
	var _other_control_map_in_edit = false;
	with(o_control_map){
		if(state == UIState.edit){
			_other_control_map_in_edit = false;
		}
	}

	//State Change
	if(!_other_control_map_in_edit){
		//State to Down
		ui_object_state_set(UIState.edit);
	
		keyboard_lastkey = -1;
		keyboard_string = "";
	}
	else{
		//State to Idle
		ui_object_state_set(UIState.idle);
	}
}