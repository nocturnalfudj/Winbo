/// @function cmd_instance_object_move_gravity_rise_fall_enable
/// @summary Toggle gravity rise/fall behaviour on an instance.
/// @param _subject Instance to modify.
/// @param _argument_list [enable]
/// @returns {void}
function cmd_instance_object_move_gravity_rise_fall_enable(_subject,_argument_list) {
	var _gravity_rise_fall_enable;
	_gravity_rise_fall_enable = _argument_list[| 0];
	
	if((string_lower(_gravity_rise_fall_enable) == "false") || (_gravity_rise_fall_enable == "0")){
		_gravity_rise_fall_enable = false;
	}
	else if((string_lower(_gravity_rise_fall_enable) == "true") || (_gravity_rise_fall_enable == "1")){
		_gravity_rise_fall_enable = true;
	}
	else{
		sdm("Argument is invalid, must be true/false or 1/0 : " + _gravity_rise_fall_enable,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"move_gravity_rise_fall_enable")){
			move_gravity_rise_fall_enable = _gravity_rise_fall_enable;
			
			sdm("Instance " + string(id) + " gravity rise_fall enable set to " + string(_gravity_enable),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}