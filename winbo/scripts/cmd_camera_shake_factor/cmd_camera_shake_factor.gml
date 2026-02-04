/// @function cmd_camera_shake_factor
/// @summary Adjust the global camera shake multiplier.
/// @param _subject Placeholder argument from console.
/// @param _argument_list Array containing the new factor.
function cmd_camera_shake_factor(_subject,_argument_list){
	var _factor;
	_factor = _argument_list[| 0];
	
	if(string_is_real(_factor)){
		_factor = real(_factor);
		
		if(_factor < 0){
			sdm("Argument is invalid, must be a number larger than 0 : " +string(_factor),LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
	else{
		sdm("Argument is invalid, must be a number larger than 0 : " + _factor,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	with(o_camera){
		shake_magnitude_factor = _factor;
		
		sdm("Camera shake factor set to " + string(_factor),LOG_COLOUR_COMMAND_SUCCESS);
	}
}