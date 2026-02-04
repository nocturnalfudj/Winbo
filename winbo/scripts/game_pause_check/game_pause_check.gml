/// @function game_pause_check
/// @summary Toggle the pause state when the pause input is pressed.
function game_pause_check(){
	var _input_keyboard,_input_gamepad;
	with(o_input){
		_input_keyboard = app_control[AppControl.pause].input[Input.keyboard][InputProperty.key];
		_input_gamepad = app_control[AppControl.pause].input[Input.gamepad][InputProperty.key];
	}
	
	if(os_paused_pause || keyboard_check_pressed(_input_keyboard) || (keyboard_check_pressed(vk_backspace) && IS_MOBILE) || gamepad_button_check_pressed(global.gamepad_device_ui_control,_input_gamepad)){
		//Reset OS Paused Pause
		os_paused_pause = false;
		
		if(global.game_state == GameState.pause){
			//Unpause
			game_unpause();
		}
		else{
			//Pause
			game_pause();
		}
	}
}