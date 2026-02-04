/// @function input_control_system_create
/// @summary Initialise arrays for tracking player input states.
/// @returns {void} No return value.
function input_control_system_create(){
	//User Control Inputs
	for(var _i=0;_i<UserControl.SIZE;_i++){
		input_current[_i] = false;
		input_previous[_i] = input_current[_i];
	}
}