function cmd_instance_object_move_velocity(_subject,_argument_list) {
	var _velocity_x,_velocity_y;
	_velocity_x = _argument_list[| 0];
	_velocity_y = _argument_list[| 1];
	
	if(string_is_real(_velocity_x)){
		_velocity_x = real(_velocity_x);
	}
	else{
		sdm("X Argument is invalid, must be a number : " + _velocity_x,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(string_is_real(_velocity_y)){
		_velocity_y = real(_velocity_y);
	}
	else{
		sdm("Y Argument is invalid, must be a number : " + _velocity_y,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	//Convert Subject to Camera if used by Camera
	if(_subject == command_subject[CMDSubject.camera].prefix){
		_subject = o_camera;
	}

	with(_subject){
		if(variable_instance_exists(id,"velocity")){
			velocity.Set(_velocity_x,_velocity_y);
			
			sdm("Instance " + string(id) + " velocity set to " + string(_velocity_x) + "," + string(_velocity_y),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}