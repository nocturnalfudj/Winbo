/// @function cmd_instance_object_move_effects_percent_max
/// @summary Set the instance move effect velocity percentage via the console.
/// @param _subject Instance whose effects are modified.
/// @param _argument_list List of string arguments.
function cmd_instance_object_move_effects_percent_max(_subject,_argument_list) {
	var _effects_percent_max;
	_effects_percent_max = _argument_list[| 0];
	
	if(string_is_real(_effects_percent_max)){
		_effects_percent_max = real(_effects_percent_max);
	}
	else{
		sdm("Argument is invalid, must be a number : " + _effects_percent_max,LOG_COLOUR_COMMAND_ERROR);
		exit;
	}

	with(_subject){
		if(variable_instance_exists(id,"move_effects_velocity_percent_max")){
			move_effects_velocity_percent_max = _effects_percent_max;
			
			sdm("Instance " + string(id) + " move effects velocity perecent max set to " + string(_effects_percent_max),LOG_COLOUR_COMMAND_SUCCESS);
		}
		else{
			sdm("Subject doesn't have movement system",LOG_COLOUR_COMMAND_ERROR);
			exit;
		}
	}
}