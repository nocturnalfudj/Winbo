/// @function cmd_instance_object_move_speed_stretch_scale
/// @summary Adjust stretch scale when moving an instance object.
function cmd_instance_object_move_speed_stretch_scale(_subject,_argument_list) {
	var _stretch_scale_x,_stretch_scale_y;
	_stretch_scale_x = _argument_list[| 0];
	_stretch_scale_y = _argument_list[| 1];
	
	if(string_is_real(_stretch_scale_x)){
		_stretch_scale_x = real(_stretch_scale_x);
	}
	else{
		sdm("X Argument is invalid, must be a number : " + _stretch_scale_x,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(string_is_real(_stretch_scale_y)){
		_stretch_scale_y = real(_stretch_scale_y);
	}
	else{
		sdm("Y Argument is invalid, must be a number : " + _stretch_scale_y,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"speed_stretch_scale")){
			speed_stretch_scale.Set(_stretch_scale_x,_stretch_scale_y);
			
			sdm("Instance " + string(id) + " speed stretch scale set to " + string(_stretch_scale_x) + "," + string(_stretch_scale_y),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}