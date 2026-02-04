/// @function input_check_keyboard_mouse_released
/// @summary Check if a key or mouse button was released this step.
/// @param input Key or mouse button code.
/// @returns {bool} True if released, otherwise false.
function input_check_keyboard_mouse_released(_input) {
	if(_input == mb_left || _input == mb_right || _input == mb_any){
		if(mouse_check_button_released(_input)) return 1;
		else return 0;
	}
	else if (keyboard_check_released(_input)) return 1;
	else return 0;
}