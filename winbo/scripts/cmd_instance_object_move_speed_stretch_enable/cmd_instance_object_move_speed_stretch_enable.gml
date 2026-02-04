function cmd_instance_object_move_speed_stretch_enable(_subject,_argument_list) {
	var _speed_stretch_enable;
	_speed_stretch_enable = _argument_list[| 0];
	
	if((string_lower(_speed_stretch_enable) == "false") || (_speed_stretch_enable == "0")){
		_speed_stretch_enable = false;
	}
	else if((string_lower(_speed_stretch_enable) == "true") || (_speed_stretch_enable == "1")){
		_speed_stretch_enable = true;
	}
	else{
		sdm("Argument is invalid, must be true/false or 1/0 : " + _speed_stretch_enable,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"speed_stretch_enable")){
			speed_stretch_enable = _speed_stretch_enable;
			
			sdm("Instance " + string(id) + " speed stretch enable set to " + string(_speed_stretch_enable),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}