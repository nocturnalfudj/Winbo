function cmd_instance_object_move_gravity(_subject,_argument_list) {
	var _gravity_x,_gravity_y;
	_gravity_x = _argument_list[| 0];
	_gravity_y = _argument_list[| 1];
	
	if(string_is_real(_gravity_x)){
		_gravity_x = real(_gravity_x);
	}
	else{
		sdm("X Argument is invalid, must be a number : " + _gravity_x,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(string_is_real(_gravity_y)){
		_gravity_y = real(_gravity_y);
	}
	else{
		sdm("Y Argument is invalid, must be a number : " + _gravity_y,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"move_gravity")){
			move_gravity.Set(_gravity_x,_gravity_y);
			
			sdm("Instance " + string(id) + " gravity set to " + string(_gravity_x) + "," + string(_gravity_y),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}