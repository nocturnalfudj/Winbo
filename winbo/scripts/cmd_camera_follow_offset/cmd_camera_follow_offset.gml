/// @function cmd_camera_follow_offset
/// @summary Adjust the camera follow offset via console.
/// @param _subject Placeholder argument from console.
/// @param _argument_list Array containing x and y offsets.
function cmd_camera_follow_offset(_subject,_argument_list){
	var _x_offset,_y_offset;
	_x_offset = _argument_list[| 0];
	_y_offset = _argument_list[| 1];
	
	if(string_is_real(_x_offset)){
		_x_offset = real(_x_offset);
	}
	else{
		sdm("X Argument is invalid, must be a number : " + _x_offset,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(string_is_real(_y_offset)){
		_y_offset = real(_y_offset);
	}
	else{
		sdm("Y Argument is invalid, must be a number : " + _y_offset,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	with(o_camera){
		follow_offset_target.Set(_x_offset,_y_offset);
		
		sdm("Camera follow offset target set to " + string(_x_offset) + "," + string(_y_offset),LOG_COLOUR_COMMAND_SUCCESS);
	}
}