/// @function input_control_check
/// @summary Check if a control is currently active.
/// @param _control Input index to query.
/// @returns {boolean} True if the control is down.
// This function can only be used when input_current[] and input_previous exist
function input_control_check(_control){
	return input_current[_control];
}