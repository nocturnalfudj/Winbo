function control_map_pause_edit_stop() {
	with(o_btn_continue){
		input_keyboard_active = o_input.app_control[AppControl.pause].input[Input.keyboard][InputProperty.key];
		input_gamepad_active = o_input.app_control[AppControl.pause].input[Input.gamepad][InputProperty.key];
	}
	
	with(o_input){
		input_save_app_control(AppControl.pause);
	}
}