/// @function cmd_instance_object_move_gravity_enable
/// @summary Enable or disable gravity movement on an instance.
/// @param _subject        Command subject instance
/// @param _argument_list  List containing boolean state
function cmd_instance_object_move_gravity_enable(_subject,_argument_list) {
	var _gravity_enable;
	_gravity_enable = _argument_list[| 0];

	if((string_lower(_gravity_enable) == "false") || (_gravity_enable == "0")){
		_gravity_enable = false;
	}
	else if((string_lower(_gravity_enable) == "true") || (_gravity_enable == "1")){
		_gravity_enable = true;
	}
	else{
		sdm("Argument is invalid, must be true/false or 1/0 : " + _gravity_enable,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"move_gravity_enable")){
			move_gravity_enable = _gravity_enable;

			sdm("Instance " + string(id) + " gravity enable set to " + string(_gravity_enable),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}