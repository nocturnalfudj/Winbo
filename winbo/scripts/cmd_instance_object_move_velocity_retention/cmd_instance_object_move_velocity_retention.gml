function cmd_instance_object_move_velocity_retention(_subject,_argument_list) {
	var _velocity_retention;
	_velocity_retention = _argument_list[| 0];
	
	if(string_is_real(_velocity_retention)){
		_velocity_retention = real(_velocity_retention);
	}
	else{
		sdm("Argument is invalid, must be a number : " + _velocity_retention,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	//Convert Subject to Camera if used by Camera
	if(_subject == command_subject[CMDSubject.camera].prefix){
		_subject = o_camera;
	}

	with(_subject){
		if(variable_instance_exists(id,"velocity_retention")){
			movement_velocity_retention_set(_velocity_retention);
			
			sdm("Instance " + string(id) + " velocity retention set to " + string(_velocity_retention),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}