/// @function cmd_instance_object_move_accelerate
/// @summary Accelerate an instance in the X and Y directions.
/// @param _subject        Command subject instance
/// @param _argument_list  List containing x and y acceleration values
function cmd_instance_object_move_accelerate(_subject,_argument_list) {
	var _accelerate_x,_accelerate_y;
	_accelerate_x = _argument_list[| 0];
	_accelerate_y = _argument_list[| 1];

	if(string_is_real(_accelerate_x)){
		_accelerate_x = real(_accelerate_x);
	}
	else{
		sdm("X Argument is invalid, must be a number : " + _accelerate_x,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	if(string_is_real(_accelerate_y)){
		_accelerate_y = real(_accelerate_y);
	}
	else{
		sdm("Y Argument is invalid, must be a number : " + _accelerate_y,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	//Convert Subject to Camera if used by Camera
	if(_subject == command_subject[CMDSubject.camera].prefix){
		_subject = o_camera;
	}

	with(_subject){
		if(variable_instance_exists(id,"acceleration")){
			acceleration.AddValues(_accelerate_x,_accelerate_y);

			sdm("Instance " + string(id) + " accelerated by " + string(_accelerate_x) + "," + string(_accelerate_y),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}