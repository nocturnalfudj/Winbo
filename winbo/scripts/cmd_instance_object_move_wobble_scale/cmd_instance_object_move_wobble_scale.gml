function cmd_instance_object_move_wobble_scale(_subject,_argument_list) {
	var _wobble_scale_x,_wobble_scale_y;
	_wobble_scale_x = _argument_list[| 0];
	_wobble_scale_y = _argument_list[| 1];
	
	if(string_is_real(_wobble_scale_x)){
		_wobble_scale_x = real(_wobble_scale_x);
	}
	else{
		sdm("X Argument is invalid, must be a number : " + _wobble_scale_x,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}
	
	if(string_is_real(_wobble_scale_y)){
		_wobble_scale_y = real(_wobble_scale_y);
	}
	else{
		sdm("Y Argument is invalid, must be a number : " + _wobble_scale_y,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"wobble_scale")){
			wobble_scale.Set(_wobble_scale_x,_wobble_scale_y);
			
			sdm("Instance " + string(id) + " speed wobble scale set to " + string(_wobble_scale_x) + "," + string(_wobble_scale_y),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}