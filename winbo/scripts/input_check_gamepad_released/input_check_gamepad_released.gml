function input_check_gamepad_released(_gp_slot,_input) {
	if(_input == gp_axislh || _input == gp_axislv || _input == gp_axisrh || _input == gp_axisrv){
		return gamepad_axis_value(_gp_slot,_input);
	}
	else if(_input == gp_shoulderrb || _input == gp_shoulderlb){
		return gamepad_button_check_released(_gp_slot,_input);
	}
	else{
		return gamepad_button_check_released(_gp_slot,_input);
	}
}