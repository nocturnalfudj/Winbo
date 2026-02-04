/// @function input_check_keyboard_mouse
/// @summary Check keyboard or mouse button state.
/// @param _input Keyboard keycode or mouse button constant.
/// @returns {real} 1 when pressed, otherwise 0.
function input_check_keyboard_mouse(_input) {
	if(_input == mb_left || _input == mb_right || _input == mb_any){
		if(mouse_check_button(_input))return 1;
		else return 0;
	}
	else if(keyboard_check(_input)) return 1;
	else return 0;
}