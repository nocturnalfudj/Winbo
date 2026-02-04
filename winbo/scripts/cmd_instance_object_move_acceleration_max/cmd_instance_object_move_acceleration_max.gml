function cmd_instance_object_move_acceleration_max(_subject,_argument_list) {
	var _accelerate_max;
	_accelerate_max = _argument_list[| 0];
	
	if(string_is_real(_accelerate_max)){
		_accelerate_max = real(_accelerate_max);
	}
	else{
		sdm("Argument is invalid, must be a number : " + _accelerate_max,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	//Convert Subject to Camera if used by Camera
	if(_subject == command_subject[CMDSubject.camera].prefix){
		_subject = o_camera;
	}

	with(_subject){
		if(variable_instance_exists(id,"acceleration_max")){
			movement_acceleration_max_set(_accelerate_max);
			
			sdm("Instance " + string(id) + " acceleration max set to " + string(_accelerate_max),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}