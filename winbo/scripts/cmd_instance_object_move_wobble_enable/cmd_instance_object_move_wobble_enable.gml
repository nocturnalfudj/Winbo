function cmd_instance_object_move_wobble_enable(_subject,_argument_list) {
	var _wobble_enable;
	_wobble_enable = _argument_list[| 0];
	
	if((string_lower(_wobble_enable) == "false") || (_wobble_enable == "0")){
		_wobble_enable = false;
	}
	else if((string_lower(_wobble_enable) == "true") || (_wobble_enable == "1")){
		_wobble_enable = true;
	}
	else{
		sdm("Argument is invalid, must be true/false or 1/0 : " + _wobble_enable,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"wobble_enable")){
			wobble_enable = _wobble_enable;
			
			sdm("Instance " + string(id) + " speed wobble enable set to " + string(_wobble_enable),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}