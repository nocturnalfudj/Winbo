///@param input
function input_check_keyboard_mouse_pressed(_input) {
	if(_input == mb_left || _input == mb_right || _input == mb_any){
		if(mouse_check_button_pressed(_input)) return 1;
		else return 0;
	}
	else if (keyboard_check_pressed(_input)) return 1;
	else return 0;
}