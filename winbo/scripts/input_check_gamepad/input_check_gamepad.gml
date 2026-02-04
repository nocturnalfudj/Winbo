/// @function input_check_gamepad
/// @summary Read a gamepad axis or button value.
/// @param _gp_slot Gamepad device index.
/// @param _input GameMaker constant for the axis or button.
/// @returns Result as real or boolean depending on input type.
function input_check_gamepad(_gp_slot,_input) {
	if(_input == gp_axislh || _input == gp_axislv || _input == gp_axisrh || _input == gp_axisrv){
		return gamepad_axis_value(_gp_slot,_input);
	}
	else if(_input == gp_shoulderrb || _input == gp_shoulderlb){
		return gamepad_button_value(_gp_slot,_input);
	}
	else{
		return gamepad_button_check(_gp_slot,_input);
	}
}