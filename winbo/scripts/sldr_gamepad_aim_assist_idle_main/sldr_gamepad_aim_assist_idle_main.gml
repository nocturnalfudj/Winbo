/// @function sldr_gamepad_aim_assist_idle_main
/// @summary Maintain slider value using the user's stored aim assist.
/// @returns {void}
function sldr_gamepad_aim_assist_idle_main() {
	value_current = user.gamepad_aim_assist;
}