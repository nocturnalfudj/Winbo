function cmd_instance_object_move_gravity_rise_lerp(_subject,_argument_list) {
	var _gravity_lerp;
	_gravity_lerp = _argument_list[| 0];
	
	if(string_is_real(_gravity_lerp)){
		_gravity_lerp = real(_gravity_lerp);
	}
	else{
		sdm("Lerp Argument is invalid, must be a number : " + _gravity_lerp,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"move_gravity_rise_lerp")){
			move_gravity_rise_lerp = _gravity_lerp;
			
			sdm("Instance " + string(id) + " gravity rise lerp set to " + string(_gravity_lerp),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}