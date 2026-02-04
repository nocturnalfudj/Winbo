//This function can only be used in instances where input_current[] and input_previous have been setup

function input_control_check_pressed(_control){
	return (input_current[_control] && !input_previous[_control]);
}