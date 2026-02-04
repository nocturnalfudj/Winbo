//This function can only be used in instances where input_current[] and input_previous have been setup
/// @function input_control_check_released
/// @summary Check if the specified control was released this step.
/// @param _control Index of the control to check.
/// @returns {bool} True when released since last frame.
function input_control_check_released(_control){
	return (!input_current[_control] && input_previous[_control]);
}