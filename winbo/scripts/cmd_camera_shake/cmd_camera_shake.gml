/// @function cmd_camera_shake
/// @summary Trigger a camera shake from the console.
/// @param _subject Placeholder argument from console.
/// @param _argument_list Array containing time and magnitude.
/// @returns {void} No return value.
function cmd_camera_shake(_subject,_argument_list){
	var _time,_magnitude;
	_time = _argument_list[| 0];
	_magnitude = _argument_list[| 1];
	
	if(string_is_real(_time)){
		_time = real(_time);
		
		if(_time >= 0){
			_time *= SECOND;
		}
		else{
			sdm("Time Argument is invalid, must be a number larger than 0 : " +string(_time),LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
	else{
		sdm("Time Argument is invalid, must be a number larger than 0 : " + _time,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(string_is_real(_magnitude)){
		_magnitude = real(_magnitude);
		
		if(_magnitude < 0){
			sdm("Magnitude Argument is invalid, must be a number larger than 0 : " +string(_magnitude),LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
	else{
		sdm("Magnitude Argument is invalid, must be a number larger than 0 : " + _time,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	camera_shake(_time,_magnitude);
	
	sdm("Camera shake for " + string(_time) + "seconds at " + string(_magnitude) + " magnitude",LOG_COLOUR_COMMAND_SUCCESS);
}