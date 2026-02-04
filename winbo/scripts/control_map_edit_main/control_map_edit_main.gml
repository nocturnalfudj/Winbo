/// @function control_map_edit_main
/// @summary Handle player input mapping in the control edit screen.
function control_map_edit_main() {
	switch(input){
		case Input.keyboard:
			control_map_choose_keyboard();
		break;
	
		case Input.mouse:
			control_map_choose_mouse();
		break;
	
		case Input.mouse_and_keyboard:
			control_map_choose_mouse_and_keyboard();
		break;
	
		case Input.gamepad:
			control_map_choose_gamepad();
		break;
	}
}