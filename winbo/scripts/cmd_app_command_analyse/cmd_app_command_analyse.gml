/// @function cmd_app_command_analyse
/// @summary Toggle verbose command parsing output.
/// @param _subject Placeholder argument from console.
/// @param _argument_list Array of command parameters.
function cmd_app_command_analyse(_subject,_argument_list) {
	var _val;
	_val = _argument_list[| 0];

	if((string_lower(_val) == "false") || (_val == "0")){
		command_analyse = false;
		
		sdm("Command analyse disabled",LOG_COLOUR_COMMAND_SUCCESS);
	}
	else if((string_lower(_val) == "true") || (_val == "1")){
		command_analyse = true;
		
		sdm("Command analyse enabled",LOG_COLOUR_COMMAND_SUCCESS);
	}
	else{
		sdm("Argument is invalid, must be true/false or 1/0 : " + _val,LOG_COLOUR_COMMAND_ERROR);
	}
}