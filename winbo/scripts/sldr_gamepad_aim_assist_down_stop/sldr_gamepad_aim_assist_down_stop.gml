/// @function sldr_gamepad_aim_assist_down_stop
/// @summary Save the user's aim assist preference when the slider is released.
/// @returns {void} No return value.
function sldr_gamepad_aim_assist_down_stop() {
	with(user){
		//Save Master Volume Value
		input_save_user_gamepad_aim_assist();
	}
}